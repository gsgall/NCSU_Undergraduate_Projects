import keras 
import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import mean_squared_error
from ECFM_NN_helpers import get_with_phase_input, load_model_scaling_factors, scale_sensitivty

def magnitude_validation(measured_mag, simulated_mag, frequencies, 
                         title_font_size=24, label_font_size=20,tick_size=14): 
    ''' Performs a comparison between experimentally measured sesnitivity magnitiude and sensitivity 
        magnitude calculated from simulation

    Args: 
        measured_mag: The experimentally measured senstivity magnitude vector 
        simulated_mag: The simulated sensitivity magnitude vector 
        frequencies: The list of frequencies at which the sensitivity was measured/simulated 
        title_font_size: the font size of the plots title. Default = 24 
        label_font_size: the font size of the plots x and y axis labels. Default = 20
        tick_size: the size of the plots ticks. Default = 14 
    Returns: 
        Nothing is returned but a plot containing both the measured and simulated sensitivity is generated. 
        The plot is then saved as "mag_comparison.pdf" 
        A table of absolute errors between the two magnitudes is also displayed 
    '''
    plt.figure() 
    plt.plot(frequencies, measured_mag, 'o-')
    plt.plot(frequencies, simulated_mag, 'o-')
    plt.title('Measured versus Simulated Magnitude', fontsize=title_font_size)
    plt.xlabel('Frequency [Hz]', fontsize=label_font_size)
    plt.ylabel('Magnitude [V]', fontsize=label_font_size)
    plt.tick_params(axis='x', labelsize=tick_size)
    plt.tick_params(axis='y', labelsize=tick_size)
    plt.legend(['Measured Magnitude', 'Simulated Magnitude'])
    plt.savefig('mag_comparison.pdf', format='pdf', bbox_inches='tight')
    plt.show() 
    mag_errors = np.abs((measured_mag - simulated_mag.reshape(measured_mag.shape)))

    for i in range(len(mag_errors)): 
        print('Frequency Index: {:2d}'.format(i + 1), 'AE [V]: {:2.4E}'.format(mag_errors[i]), 'NAE:  {:2.2%}'.format(mag_errors[i] /measured_mag[i]))
    print('Global Average AE [V]: {:2.4E}'.format(np.average(mag_errors)), 'NAE:  {:2.2%}'.format(np.average(mag_errors / measured_mag.reshape(mag_errors.shape))))

def phase_validation(measured_phase, simulated_phase, frequencies, 
                     title_font_size=24, label_font_size=20,tick_size=14): 
    ''' Performs a comparison between experimentally measured sesnitivity phase and sensitivity phase calculated 
        from simulation

    Args: 
        measured_phase: The experimentally measured senstivity phase vector 
        simulated_phase: The simulated sensitivity phase vector 
        frequencies: The list of frequencies at which the sensitivity was measured/simulated 
        title_font_size: the font size of the plots title. Default = 24 
        label_font_size: the font size of the plots x and y axis labels. Default = 20
        tick_size: the size of the plots ticks. Default = 14 
    Returns: 
        Nothing is returned but a plot containing both the measured and simulated sensitivity is generated. 
        The plot is then saved as "phase_comparison.pdf" in the current directory
        A table of absolute errors between the two phases is also displayed 
    '''
    plt.figure()
    plt.plot(frequencies, measured_phase, 'o-')
    plt.plot(frequencies, simulated_phase, 'o-')
    plt.title('Measured versus Simulated Phase', fontsize=title_font_size)
    plt.xlabel('Frequency [Hz]', fontsize=label_font_size)
    plt.ylabel('Phase [Radians]', fontsize=label_font_size)
    plt.tick_params(axis='x', labelsize=tick_size)
    plt.tick_params(axis='y', labelsize=tick_size)
    plt.legend(['Measured Phase', 'Simulated Phase'])
    plt.savefig('phase_comparison.pdf', format='pdf', bbox_inches='tight')
    plt.show() 
    phase_errors = np.abs((measured_phase - simulated_phase))
    for i in range(phase_errors.shape[0]): 
        print('Frequency Index: {:2d}'.format(i + 1), 'AE [Rad]: {:2.4E}'.format(phase_errors[i][0]), 'NAE:  {:2.2%}'.format(phase_errors[i][0] / np.abs(measured_phase[i][0])))
    print('Global Average AE [Rad]: {:2.4E}'.format(np.average(phase_errors)), 'NAE:  {:2.2%}'.format(np.average(phase_errors / np.abs(measured_phase))))

def sample_actual_profile(actual_rad, actual_vel, wanted_rad): 
    ''' Given a more complete velocity profile this function samples it at the location the NN model is trained to predict 

    Behaviour is undefined if all positions in wanted_rad are contained by actual_rad 

    Args: 
        actual_rad: The radial positions of the velocities in the actual_vel profile 
        actual_vel: The velocity profile that is being sampled 
        wanted_rad: The positions at which you want to sample the actual_vel profile 
    Returns: 
        The velocity profile sampled at each location in wanted_rad 
    '''
    sample_profile = np.zeros((wanted_rad.shape[0], 1))
    for i in range(wanted_rad.shape[0]): 
        rad_below = [x for x in actual_rad if x<=wanted_rad[i]][-1]
        rad_above = [x for x in actual_rad if x>wanted_rad[i]][0]
        
        idx_below = np.where(actual_rad == rad_below)[0][0]
        idx_above = np.where(actual_rad == rad_above)[0][0]

        vel_above = actual_vel[idx_below]
        vel_below = actual_vel[idx_above]

        slope = (vel_below - vel_above) / (rad_below - rad_above)
        sample_profile[i] = slope * (rad_above -  wanted_rad[i]) + vel_below

    return sample_profile

def get_path_to_model(profile_type):
    ''' Gets the location where model information is stored 
    Args: 
        profile_type: The type of profile used to train the model 
    Returns: 
        path_to_model: The location where the model is stored 
        path_to_params: The location where the model_params are stored  
    '''
    path_to_results = profile_type + '_Velocity_Results/'   
    path_to_model = path_to_results + profile_type + '_Model'  
    path_to_params = path_to_results + 'model_params.txt' 
    return path_to_model, path_to_params 


def print_model_error(profile_type, actual_profile, model_profile): 
    ''' Prints the errors in the model predictions when performing validation 

    Args: 
        profile_type: The type of velocity profile used to train the NN 
        actual_profile: The velocity profile used as a baseline 
        model_profile: The profile predicted by the model 
    '''
    print('Actual Error in the', profile_type, 'model')
    error_sum = 0 
    normalized_sum = 0 
    max_error = 0 
    nmax_error = 0 
    max_component = 0; 
    for i in range(len(actual_profile)): 
        error = np.abs(actual_profile[i] - model_profile[i])
        normalized_error = error / actual_profile[i]
        if normalized_error >= nmax_error: 
            max_error = error[0] 
            nmax_error = normalized_error[0]
            max_component = i 
        error_sum += error[0] 
        normalized_sum += normalized_error[0]
        print('Component:', i, 'MAE: {:.2f} m/s'.format(error[0]), 'NMAE: {:.0%}'.format(normalized_error[0]))
    print('Average Error in profile MAE: {:.2f} m/s'.format(error_sum / len(actual_profile)), 'NMAE: {:.0%}'.format(normalized_sum / len(actual_profile)))
    print('Max Error Component:', max_component, ' MAE: {:.2f} m/s'.format(max_error), 'NMAE: {:.0%}'.format(nmax_error))
    print()
    print()

def model_validation(profile_type, actual_profile, actual_rad_pos, model_rad_pos, actual_sensitivity,
                     title_font_size=24, 
                     label_font_size=20,
                     tick_size=14,
                     num_samples=1000, error_factor=0.05, figsize=(5, 5)): 
    ''' Compares the models predicted velocity profile to one generated via CFD simulation. Monte Carlo uncertainty 
        analysis is then performed adding noise to the sensitivity only 

    Args: 
        profile_type: the name of the profile used to train the DNN model. 
        actual_profile: the velocity profile that the model should be trying to predict 
        actual_rad_pos: the radial position vector for the target velocity profile 
        model_rad_pos: the radial positions where the model predicts velocity profiles 
        actual_sensitivity: The measured sensitivity for the given actual velocity profile 
        title_font_size: the font size of the plots title. Default = 24 
        label_font_size: the font size of the plots x and y axis labels. Default = 20
        tick_size: the size of the plots ticks. Default = 14 
        num_samples: the number of sensitivity profiles used in the monte carlo anlysis. Default = 1000
        error_factor: the percentage of noise added to the sensitivity profile. Default = 0.05
        figsize: the size of the pdf that is generated. Default = (5, 5)
    Returns: 
        No value is returned but a plot of the given profile and model guesses with error bars is generated. 
        A table of RMSE and NRMSE is generated for the monte carlo analysis 
        A table of AE and NAE is generated for the models predictions with the given sensitivity profile 
    '''
    path_to_model = get_path_to_model(profile_type)[0]
    sensitivity_scale_factor, max_vel = load_model_scaling_factors(profile_type)[1:3]
    sensitivity_scaled = scale_sensitivty(actual_sensitivity, scale_factor=sensitivity_scale_factor)[0]
    model = keras.models.load_model(path_to_model)
    base_case = model.predict(sensitivity_scaled.reshape(1, len(sensitivity_scaled), 1)).reshape(-1,)
    base_case *= max_vel  
    noisy_sensitivity =  np.zeros((num_samples, len(actual_sensitivity), 1))
    velocity_profiles = np.zeros((num_samples, len(model_rad_pos), 1))
    velocity_profile = sample_actual_profile(actual_rad_pos, actual_profile, model_rad_pos)

    for i in range(num_samples): 
        velocity_profiles[i] = velocity_profile
    for i in range(len(actual_sensitivity)):
        noisy_sensitivity[:, i] = np.random.normal(actual_sensitivity[i], error_factor * actual_sensitivity[i], num_samples).reshape(-1, 1)
    
    noisy_profiles_scaled = model.predict(noisy_sensitivity / sensitivity_scale_factor)
    velocity_predictions =  noisy_profiles_scaled * max_vel

    errors = np.zeros((len(model_rad_pos)))
    normalized_errors = np.zeros((len(model_rad_pos)))
    print('Monte Carlo Uncertainty Quantification')
    max_error = 0
    nmax_error = 0
    max_idx = 0
    for i in range(velocity_predictions.shape[1]):
        errors[i] = np.sqrt(mean_squared_error(velocity_profiles[:, i], velocity_predictions[:, i]))
        normalized_errors[i] = errors[i] / actual_profile[i]
        print('component:', i, 'RMSE: {:.2f} m/s'.format( errors[i]), 'NRMSE: {:.0%}'.format(normalized_errors[i]))
        if nmax_error <= normalized_errors[i]:
            nmax_error = normalized_errors[i]
            max_error = errors[i]
            max_idx = i
    print('Max Error Component:', max_idx, 'RMSE: {:.2f} m/s'.format(max_error), 'NRMSE: {:.0%}'.format(nmax_error))
    plt.figure(figsize=figsize)
    plt.plot(actual_rad_pos, actual_profile, '-k')
    plt.title(profile_type.replace('_With_Phase', '') + ' Model Validation', fontsize=title_font_size)
    plt.xlabel('Radial Position [m]', fontsize=label_font_size)
    plt.ylabel('Velocity [m/s]', fontsize=label_font_size)
    plt.tick_params(axis='x', labelsize=tick_size)
    plt.tick_params(axis='y', labelsize=tick_size)
    plt.plot(model_rad_pos, base_case, '-o', color='C01')
    plt.fill_between(model_rad_pos, velocity_profile.reshape(-1,) - errors, velocity_profile.reshape(-1,) + errors)
    plt.legend(['CFD', 'NN'])
    file_name = profile_type + '_Velocity_Results/' + profile_type + '_Validation_plot.pdf'
    plt.savefig(file_name, format='pdf', bbox_inches='tight')
    plt.show()

    print_model_error(profile_type, sample_actual_profile(actual_rad_pos, actual_profile, model_rad_pos), base_case)

def model_validation_with_phase(profile_type, actual_profile, actual_rad_pos, model_rad_pos, 
                                actual_sensitivity, actual_phase, 
                                title_font_size=24, 
                                label_font_size=20,
                                tick_size=14,
                                num_samples=1000, error_factor=0.05, figsize=(5, 5)): 
    ''' Compares the models predicted velocity profile to one generated via CFD simulation. Monte Carlo uncertainty 
        analysis is then performed adding noise to the sensitivity only 

    Args: 
        profile_type: the name of the profile used to train the DNN model. 
        actual_profile: the velocity profile that the model should be trying to predict 
        actual_rad_pos: the radial position vector for the target velocity profile 
        model_rad_pos: the radial positions where the model predicts velocity profiles 
        actual_sensitivity: The measured sensitivity for the given actual velocity profile 
        actual_phase: The measured phase for the given velocity profile 
        title_font_size: the font size of the plots title. Default = 24 
        label_font_size: the font size of the plots x and y axis labels. Default = 20
        tick_size: the size of the plots ticks. Default = 14 
        num_samples: the number of sensitivity profiles used in the monte carlo anlysis. Default = 1000
        error_factor: the percentage of noise added to the sensitivity profile. Default = 0.05
        figsize: the size of the pdf that is generated. Default = (5, 5)
    Returns: 
        No value is returned but a plot of the given profile and model guesses with error bars is generated. 
        A table of RMSE and NRMSE is generated for the monte carlo analysis 
        A table of AE and NAE is generated for the models predictions with the given sensitivity profile 
    '''
    path_to_model = get_path_to_model(profile_type)[0]
    phase_scale_factor, sensitivity_scale_factor, max_vel = load_model_scaling_factors(profile_type)
    scaled_input = get_with_phase_input(actual_sensitivity.reshape(1, -1, 1), actual_phase.reshape(1, -1, 1), 
                                        sensitivity_scale_factor=sensitivity_scale_factor, 
                                        phase_scale_factor=phase_scale_factor)[0]
    model = keras.models.load_model(path_to_model)
    base_case = model.predict(scaled_input).reshape(-1,)
    base_case *= max_vel 
    
     
    noisy_sensitivity = np.zeros((num_samples, len(actual_sensitivity), 1))
    phases = np.zeros((num_samples, len(actual_sensitivity), 1))
    velocity_profiles = np.zeros((num_samples, len(model_rad_pos), 1))
    velocity_profile = sample_actual_profile(actual_rad_pos, actual_profile, model_rad_pos)

    for i in range(num_samples): 
        velocity_profiles[i] = velocity_profile
        phases[i] = actual_phase
    for i in range(len(actual_sensitivity)):
        noisy_sensitivity[:, i] = np.random.normal(actual_sensitivity[i], error_factor * actual_sensitivity[i], num_samples).reshape(-1, 1)
    
    scaled_input = get_with_phase_input(noisy_sensitivity, phases, 
                                        sensitivity_scale_factor=sensitivity_scale_factor, 
                                        phase_scale_factor=phase_scale_factor)[0]
    noisy_profiles_scaled = model.predict(scaled_input)
    velocity_predictions =  noisy_profiles_scaled * max_vel

    errors = np.zeros((len(model_rad_pos)))
    normalized_errors = np.zeros((len(model_rad_pos)))
    print('Monte Carlo Uncertainty Quantification')
    max_error = 0
    nmax_error = 0
    max_idx = 0
    for i in range(velocity_predictions.shape[1]):
        errors[i] = np.sqrt(mean_squared_error(velocity_profiles[:, i], velocity_predictions[:, i]))
        normalized_errors[i] = errors[i] / actual_profile[i]
        print('component:', i, 'RMSE: {:.2f} m/s'.format( errors[i]), 'NRMSE: {:.0%}'.format(normalized_errors[i]))
        if nmax_error <= normalized_errors[i]:
            nmax_error = normalized_errors[i]
            max_error = errors[i]
            max_idx = i
    print('Max Error Component:', max_idx, 'RMSE: {:.2f} m/s'.format(max_error), 'NRMSE: {:.0%}'.format(nmax_error))
    plt.figure(figsize=figsize)
    plt.plot(actual_rad_pos * 100, actual_profile, '-k')
    plt.title(profile_type.replace('_With_Phase', '') + ' Model Validation', fontsize=title_font_size)
    plt.xlabel('Radial Position [cm]', fontsize=label_font_size)
    plt.ylabel('Velocity [m/s]', fontsize=label_font_size)
    plt.tick_params(axis='x', labelsize=tick_size)
    plt.tick_params(axis='y', labelsize=tick_size)
    plt.plot(model_rad_pos * 100, base_case, '-o', color='C01')
    plt.fill_between(model_rad_pos * 100, velocity_profile.reshape(-1,) - errors, velocity_profile.reshape(-1,) + errors)
    plt.legend(['CFD', 'NN'], fontsize=16)
    plt.tick_params(axis='x', labelsize=14)
    plt.tick_params(axis='y', labelsize=14)
    file_name = profile_type + '_Velocity_Results/' + profile_type + '_Validation_plot.pdf'
    plt.savefig(file_name, format='pdf', bbox_inches='tight')
    plt.show()

    print_model_error(profile_type, sample_actual_profile(actual_rad_pos, actual_profile, model_rad_pos), base_case)





