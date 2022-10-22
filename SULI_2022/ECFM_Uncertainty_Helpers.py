import numpy as np 
import matplotlib.pyplot as plt
from tensorflow import keras
from math import pi 
from ECFM_NN_helpers import get_sensitivity
from sklearn.metrics import mean_squared_error

def generate_noisy_data(velocity_profile, A, num_samples, error_factor): 
    ''' Generates sensitivity profiles with noise to simulate experimental uncertainty in measurements 

    Args: 
        velocity_profile: The profile that will be used as a baseline for the unceratinty quantification 
        A: The a matrix for calculating sensitivity and phase 
        num_samples: The number of noisy profiles to be generated 
        error_factor: The amount of noise that will be used when generating the noise 
    Returns: 
        velocity_profiles: A tensor of the correct velocity profiles (num_samples, num_vel_components, 1)
        noisy_sensitivities; A tensor of the noisy sensitivies generated (num_samples, num_sesitivity_components, 1)
    '''
    sensivity = get_sensitivity(np.matmul(A, velocity_profile.reshape(-1, 1)))
    noisy_sensitivity =  np.zeros((num_samples, A.shape[0], 1))
    velocity_profiles = np.zeros((num_samples, A.shape[1], 1))
    velocity_profile = velocity_profile.reshape(-1, 1)
    for i in range(num_samples): 
        velocity_profiles[i] = velocity_profile
    for i in range(len(sensivity)):
        noisy_sensitivity[:, i] = np.random.normal(sensivity[i], error_factor * sensivity[i], num_samples).reshape(-1, 1)
    return velocity_profiles, noisy_sensitivity

def uncertainty_monte_carlo(profile_type, A, velocity_profile, rad_pos, num_samples, error_factor, R, 
                            band_color=None, line_color='black'): 
    ''' Method performs the monte carlo uncerainty quantification on the profile with noisy sensitivities
    
    Args: 
        profile_type: The profile used to train the NN model 
        A: the matrix used to calculate the sensitivity 
        velocity_profile: The profile around which you are generating noise 
        rad_pos: the radial posisions where the NN calculates the velocities 
        num_samples: The number of noisy profiles used to generate the uncertainty
        error_factor: The percentage of noise in the measurement to be used 
        R: The inner radius of the pipe being modeled 
        band_color: The color that will be used on the error bands 
        line_color: The color that will be used when plotting the base velocity profile 
    Returns:    
        The RMSE and NRMSE for each component is printed 
        errors: MRSE in the velocity calculation of each profile 
    '''
    velocity_profile = velocity_profile.reshape(-1,)
    path_to_results = profile_type + '_Velocity_Results/'
    path_to_model = path_to_results + profile_type + '_Model'
    path_to_params = path_to_results + 'model_params.txt'
    model = keras.models.load_model(path_to_model)
    file_name = path_to_results + profile_type + '_error_plot.pdf'
    with open(path_to_params, 'r') as f: 
            # throw away phase scaling 
            f.readline()
            sensitivity_scale_factor = float(f.readline()[len('sensitivity_scale_factor = ' ):-1])
            f.readline() 
            max_vel = int(f.readline()[len('max_vel = '):-1])

    velocity_profiles, noisy_sensitivities = generate_noisy_data(velocity_profile, A, num_samples, error_factor)
    noisy_sensitivities_scaled = noisy_sensitivities / sensitivity_scale_factor
    velocity_predictions = model.predict(noisy_sensitivities_scaled).reshape(num_samples, A.shape[1], 1)
    velocity_predictions *= max_vel 

    errors = np.zeros((A.shape[1]))
    normalized_errors = np.zeros((A.shape[1]))
    print('Uncertainty Monte Carlo:', profile_type, 'errors')
    for i in range(velocity_predictions.shape[1]):
        errors[i] = np.sqrt(mean_squared_error(velocity_profiles[:, i], velocity_predictions[:, i]))
        normalized_errors[i] = errors[i] / np.mean(velocity_profiles[:, i])
        print('component:', i, 'RMSE: {:.4f} m/s'.format( errors[i]), 'NRMSE: {:.0%}'.format(normalized_errors[i]))
    
    plt.figure() 
    plt.title('Uncertainty in ' + profile_type.replace('_', ' ') + ' model with {:.0%}'.format(error_factor) + ' sensitivity noise' )
    plt.xlabel('Radial Position [m]')
    plt.ylabel('Velocity [m/s]')
    plt.xlim([0, R])
    plt.ylim([0, np.max(velocity_profile + errors) + 0.1])
    plt.plot(rad_pos, velocity_profile, '-o', color=line_color)
    plt.fill_between(rad_pos, velocity_profile - errors, velocity_profile + errors, facecolor=band_color)
    plt.savefig(file_name, format='pdf', bbox_inches='tight')
    plt.show()
    return errors

def generate_noisy_data_with_phases(velocity_profile, A, num_samples, error_factor):
    ''' Generates sensitivity profiles with noise to simulate experimental uncertainty in measurements 
        also generated the phases to be used. No noise is put on the phases 

    Args: 
        velocity_profile: The profile that will be used as a baseline for the unceratinty quantification 
        A: The a matrix for calculating sensitivity and phase 
        num_samples: The number of noisy profiles to be generated 
        error_factor: The amount of noise that will be used when generating the noise 
    Returns: 
        velocity_profiles: A tensor of the correct velocity profiles (num_samples, num_vel_components, 1)
        noisy_sensitivities; A tensor of the noisy sensitivies generated (num_samples, num_sesitivity_components, 1)
        phases: The phases associated with the velocity profile generated (num_samples, num_sesitivity_components, 1)
    '''
    b =  np.matmul(A, velocity_profile.reshape(-1, 1))
    sensivity = get_sensitivity(b)
    phase = np.angle(b)
    noisy_sensitivity = np.zeros((num_samples, A.shape[0], 1))

    phases = np.zeros((num_samples, A.shape[0], 1))
    velocity_profiles = np.zeros((num_samples, A.shape[1], 1))
    velocity_profile = velocity_profile.reshape(-1, 1)

    for i in range(num_samples): 
        velocity_profiles[i] = velocity_profile
        phases[i] = phase 
    for i in range(len(sensivity)):
        noisy_sensitivity[:, i] = np.random.normal(sensivity[i], error_factor * sensivity[i], num_samples).reshape(-1, 1)
    return velocity_profiles, noisy_sensitivity, phases


def uncertainty_monte_carlo_phases(profile_type, A, velocity_profile, rad_pos, num_samples, error_factor, R, 
                                   band_color=None, line_color='black', phase_shift=2 * pi): 
    ''' Method performs the monte carlo uncerainty quantification on the profile with noisy sensitivities
    
    Args: 
        profile_type: The profile used to train the NN model 
        A: the matrix used to calculate the sensitivity 
        velocity_profile: The profile around which you are generating noise 
        rad_pos: the radial posisions where the NN calculates the velocities 
        num_samples: The number of noisy profiles used to generate the uncertainty
        error_factor: The percentage of noise in the measurement to be used 
        R: The inner radius of the pipe being modeled 
        band_color: The color that will be used on the error bands 
        line_color: The color that will be used when plotting the base velocity profile 
    Returns:    
        The RMSE and NRMSE for each component is printed 
        errors: MRSE in the velocity calculation of each profile 
    '''                                
    velocity_profile = velocity_profile.reshape(-1,)
    path_to_results = profile_type + '_Velocity_Results/'
    path_to_model = path_to_results + profile_type + '_Model'
    path_to_params = path_to_results + 'model_params.txt'
    model = keras.models.load_model(path_to_model)
    file_name = path_to_results + profile_type + '_error_plot.pdf'
    
    with open(path_to_params, 'r') as f: 
            phase_scale_factor = float(f.readline()[len('phase_scale_factor = ' ):-1])
            sensitivity_scale_factor = float(f.readline()[len('sensitivity_scale_factor = ' ):-1])
            f.readline() 
            max_vel = int(f.readline()[len('max_vel = '):-1])

   

    velocity_profiles, noisy_sensitivity, noisy_phases = generate_noisy_data_with_phases(velocity_profile, A, num_samples, error_factor)
    noisy_phases += phase_shift
    noisy_sensitivity_scaled = noisy_sensitivity / sensitivity_scale_factor
    noisy_phases_scaled = noisy_phases / phase_scale_factor
    noisy_input = np.ma.concatenate([noisy_sensitivity_scaled, noisy_phases_scaled], axis=1)
    velocity_predictions = model.predict(noisy_input)
    velocity_predictions *= max_vel
    
    errors = np.zeros((A.shape[1]))
    normalized_errors = np.zeros((A.shape[1]))
    print('Uncertainty Monte Carlo:', profile_type, 'errors')
    for i in range(velocity_predictions.shape[1]):
        errors[i] = np.sqrt(mean_squared_error(velocity_profiles[:, i], velocity_predictions[:, i]))
        normalized_errors[i] = errors[i] / np.mean(velocity_profiles[:, i])
        print('component:', i, 'RMSE: {:.4f} m/s'.format( errors[i]), 'NRMSE: {:.0%}'.format(normalized_errors[i]))
    
    plt.figure() 
    plt.title('Uncertainty in ' + profile_type.replace('_', ' ') + ' model with {:.0%}'.format(error_factor) + ' sensitivity noise' )
    plt.xlabel('Radial Position [m]')
    plt.ylabel('Velocity [m/s]')
    plt.xlim([0, R])
    plt.ylim([0, np.max(velocity_profile + errors) + 0.1])
    plt.plot(rad_pos, velocity_profile, '-o', color=line_color)
    plt.fill_between(rad_pos, velocity_profile - errors, velocity_profile + errors, facecolor=band_color)
    plt.show()

    return errors