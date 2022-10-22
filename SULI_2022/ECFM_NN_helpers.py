import numpy as np 
import random as rand
import matplotlib.pyplot as plt
from keras import Sequential
from keras.layers import Dropout
from keras.layers import Dense
from keras.layers import Input
from sklearn.linear_model import LinearRegression
# Updating Default Plot Font to be LaTex
plt.rcParams['mathtext.fontset'] = 'stix'
plt.rcParams['font.family'] = 'STIXGeneral'

def get_sensitivity(b): 
    ''' get_sesativity calculates the sensitivity resulting from the A' * v operation 
    
    Args: 
        b: The result of the A' * v operation 
    Returns: 
        The real valued magnitude of the complex numbers that result from the multiplication 
    '''
    return np.abs(b)

def generate_constant_data(A, size, min_vel, max_vel): 
    ''' Generates a sample of sensitivity and velocity data using a constant velocity profiles
    
    Each component of the velocity profile is set to the same number that is between min_vel and max_vel 

    Args:
        A: the matrix generated from the COMSOL simulation, (M, N) 
        size: the number of pairs of sensitivity, velocity vectors that you want to generate 
        min_vel: the minimum fluid velocity that will be included in the sensitivity generation 
        max_vel: the maximum fluid velocity that will be included in the sensitivity generation 
    Returns: 
        sensitivity: (size, M, 1) ndarray of sensitivity matricies. 
        velocity_profile: (size, N, 1) ndarray of corrisponding velocty profiles.
        phases: (size, M, 1) of phases of the values in b 
        bs: (size, M, 1) ndarray of both the real and imginary components of the b vector 
    ''' 
    sensitivity = np.zeros((size, A.shape[0], 1))
    velocity_profile = np.zeros((size, A.shape[1], 1))
    phases = np.zeros((size, A.shape[0], 1))
    bs = np.zeros((size, A.shape[0], 1), dtype=complex)

    for i in range(size):
        # creating the random v vector
        velocity_profile[i] = rand.uniform(min_vel, max_vel) * np.ones((A.shape[1], 1))
        b = np.matmul(A, velocity_profile[i])
        phases[i] = np.angle(b)
        sensitivity[i] = np.reshape(get_sensitivity(b), (A.shape[0], 1)) 
        bs[i] = b 
    return sensitivity, velocity_profile, phases, bs

def generate_linear_data(A, size, min_vel, max_vel, rad_pos): 
    ''' Generates a sample of sensitivity and velocity data using a linear velocity profiles
    
    A random temp_max_vel is generated within the range min_val to max_vel then a random temp_min_vel
    is generated in the range temp_max_vel and min_vel. The range over which the fit is performed is 
    then normalized to prevent numeric instability when fitting and to maintian relative spaces between 
    the points. A linear fit is performed between the starting and stopping points of the normalized range 
    and each point within the normalized range is sampled. 

    Args:
        A: the matrix generated from the COMSOL simulation, (M, N) 
        size: the number of pairs of sensitivity, velocity vectors that you want to generate 
        min_vel: the minimum fluid velocity that will be included in the sensitivity generation 
        max_vel: the maximum fluid velocity that will be included in the sensitivity generation 
        rad_pos: A list of radial positions where the velocity profile should be sampled 
    Returns: 
        sensitivity: (size, M, 1) ndarray of sensitivity matricies. 
        velocity_profile: (size, N, 1) ndarray of corrisponding velocty profiles.
        phases: (size, M, 1) of phases of the values in b 
        bs: (size, M, 1) ndarray of both the real and imginary components of the b vector 
    ''' 
    sensitivity = np.zeros((size, A.shape[0], 1))
    velocity_profile = np.zeros((size, A.shape[1], 1))
    phases = np.zeros((size, A.shape[0], 1))
    bs = np.zeros((size, A.shape[0], 1), dtype=complex)
    scaled_rad_pos = (rad_pos / rad_pos[-1]).reshape(-1, 1)

    for i in range(size):
        # creating the random v vector
        temp_max_vel = rand.uniform(min_vel, max_vel)
        temp_min_vel = rand.uniform(min_vel, temp_max_vel) 
        slope = (temp_min_vel - temp_max_vel) / (scaled_rad_pos[-1] - scaled_rad_pos[0])
        velocity_profile[i] = (slope * (scaled_rad_pos - scaled_rad_pos[0]) + temp_max_vel).reshape(-1, 1)
        b = np.matmul(A, velocity_profile[i])
        phases[i] = np.angle(b)
        sensitivity[i] = np.reshape(get_sensitivity(b), (A.shape[0], 1)) 
        bs[i] = b 
    return sensitivity, velocity_profile, phases, bs

def generate_parabolic_data(A, size, min_vel, max_vel, rad_pos): 
    ''' Generates a sample of sensitivity and velocity data using parabolic velocity profiles

    Args:
        A: the matrix generated from the COMSOL simulation, (M, N) 
        size: the number of pairs of sensitivity, velocity vectors that you want to generate 
        min_vel: the minimum fluid velocity that will be included in the sensitivity generation 
        max_vel: the maximum fluid velocity that will be included in the sensitivity generation 
        rad_pos: A list of radial positions where the velocity profile should be sampled 
    Returns: 
        sensitivity: (size, M, 1) ndarray of sensitivity matricies. 
        velocity_profile: (size, N, 1) ndarray of corrisponding velocty profiles.
        phases: (size, M, 1) of phases of the values in b 
        bs: (size, M, 1) ndarray of both the real and imginary components of the b vector 
    ''' 
    sensitivity = np.zeros((size, A.shape[0], 1))
    velocity_profile = np.zeros((size, A.shape[1], 1))
    phases = np.zeros((size, A.shape[0], 1))
    bs = np.zeros((size, A.shape[0], 1), dtype=complex)
    scaled_rad_pos = (rad_pos / rad_pos[-1]).reshape(-1, 1)

    for i in range(size):
        # creating the random v vector
        temp_max_vel = rand.uniform(min_vel, max_vel)
        temp_min_vel = rand.uniform(min_vel, temp_max_vel) 
        coef = (temp_max_vel - temp_min_vel) / (1 - (scaled_rad_pos[0] / scaled_rad_pos[-1])**2)

        velocity_profile[i] = coef * (1 - (scaled_rad_pos / scaled_rad_pos[-1])**2) + temp_min_vel
        b = np.matmul(A, velocity_profile[i])
        phases[i] = np.angle(b)
        sensitivity[i] = np.reshape(get_sensitivity(b), (A.shape[0], 1)) 
        bs[i] = b 
    return sensitivity, velocity_profile, phases, bs

def generate_power_data(A, size, min_vel, max_vel, rad_pos, R, min_n, max_n): 
    ''' Generates a sample of sensitivity and velocity data using parabolic velocity profiles

    Args:
        A: the matrix generated from the COMSOL simulation, (M, N) 
        size: the number of pairs of sensitivity, velocity vectors that you want to generate 
        min_vel: the minimum fluid velocity that will be included in the sensitivity generation 
        max_vel: the maximum fluid velocity that will be included in the sensitivity generation 
        rad_pos: A list of radial positions where the velocity profile should be sampled 
    Returns: 
        sensitivity: (size, M, 1) ndarray of sensitivity matricies. 
        velocity_profile: (size, N, 1) ndarray of corrisponding velocty profiles.
        phases: (size, M, 1) of phases of the values in b 
        bs: (size, M, 1) ndarray of both the real and imginary components of the b vector 
    ''' 
    sensitivity = np.zeros((size, A.shape[0], 1))
    velocity_profile = np.zeros((size, A.shape[1], 1))
    phases = np.zeros((size, A.shape[0], 1))
    bs = np.zeros((size, A.shape[0], 1), dtype=complex)
    scaled_rad_pos = (rad_pos / R).reshape(-1, 1)

    for i in range(size):
        # creating the random v vector
        temp_max_vel = rand.uniform(min_vel, max_vel)
        n = rand.uniform(min_n, max_n)
        u_max = temp_max_vel / ( 1 - scaled_rad_pos[0])**( 1 / n )
        velocity_profile[i] = u_max * ( 1 - scaled_rad_pos)**( 1 / n )
        b = np.matmul(A, velocity_profile[i])
        phases[i] = np.angle(b)
        sensitivity[i] = np.reshape(get_sensitivity(b), (A.shape[0], 1)) 
        bs[i] = b 
    return sensitivity, velocity_profile, phases, bs

def generate_monotonic_data(A, size, min_vel, max_vel): 
    ''' Generates a sample of sensitivity and velocity data using a random monotonically decreasing velocity profile 
    
    Each component of the velocity profile is set to a random value between min_vel and max_vel and 
    v_i - 1 >= v_i 

    Args:
        A: the matrix generated from the COMSOL simulation, (M, N) 
        size: the number of pairs of sensitivity, velocity vectors that you want to generate 
        min_vel: the minimum fluid velocity that will be included in the sensitivity generation 
        max_vel: the maximum fluid velocity that will be included in the sensitivity generation 
    Returns: 
        sensitivity: (size, M, 1) ndarray of sensitivity matricies. 
        velocity_profile: (size, N, 1) ndarray of corrisponding velocty profiles.
        phases: (size, M, 1) of phases of the values in b 
        bs: (size, M, 1) ndarray of both the real and imginary components of the b vector 
    ''' 
    sensitivity = np.zeros((size, A.shape[0], 1))
    velocity_profile = np.zeros((size, A.shape[1], 1))
    phases = np.zeros((size, A.shape[0], 1))
    bs = np.zeros((size, A.shape[0], 1), dtype=complex)
    for i in range(size):
        # creating the random v vector
        velocity_profile[i][0] = rand.uniform(min_vel, max_vel)
        velocity_profile[i][-1] = rand.uniform(min_vel, velocity_profile[i][0])
        for j in range(1, A.shape[1] - 1): 
            velocity_profile[i][j] = rand.uniform(velocity_profile[i][-1], velocity_profile[i][j - 1])
        b = np.matmul(A, velocity_profile[i])
        phases[i] = np.angle(b)
        sensitivity[i] = np.reshape(get_sensitivity(b), (A.shape[0], 1)) 
        bs[i] = b 
    return sensitivity, velocity_profile, phases, bs

def generate_random_data(A, size, min_vel, max_vel): 
    ''' Generates a sample of sensitivity and velocity data using a random velocity profiles
    
    Each component of the velocity profile is set to a random value between min_vel and max_vel 

    Args:
        A: the matrix generated from the COMSOL simulation, (M, N) 
        size: the number of pairs of sensitivity, velocity vectors that you want to generate 
        min_vel: the minimum fluid velocity that will be included in the sensitivity generation 
        max_vel: the maximum fluid velocity that will be included in the sensitivity generation 
    Returns: 
        sensitivity: (size, M, 1) ndarray of sensitivity matricies. 
        velocity_profile: (size, N, 1) ndarray of corrisponding velocty profiles.
        phases: (size, M, 1) of phases of the values in b 
        bs: (size, M, 1) ndarray of both the real and imginary components of the b vector 
    ''' 
    sensitivity = np.zeros((size, A.shape[0], 1))
    velocity_profile = np.zeros((size, A.shape[1], 1))
    phases = np.zeros((size, A.shape[0], 1))
    bs = np.zeros((size, A.shape[0], 1), dtype=complex)
    for i in range(size):
        # creating the random v vector
        velocity_profile[i] = np.reshape(np.array([rand.uniform(min_vel, max_vel) for j in range(A.shape[1])]), (A.shape[1], 1))
        b = np.matmul(A, velocity_profile[i])
        phases[i] = np.angle(b)
        sensitivity[i] = np.reshape(get_sensitivity(b), (A.shape[0], 1)) 
        bs[i] = b 
    return sensitivity, velocity_profile, phases, bs

def get_with_phase_input(sensitivity, phase, sensitivity_scale_factor=None, phase_scale_factor=None): 
    ''' Puts phases and sensitivity into the expected input for the NN model and scales them as needed 
    Args: 
        sensitivity: The sensitivity data to be used on the model 
        phase: The phase data to be used on the model 
        sensitivity_scale_factor: The factor the sensitivity should be scaled by. If none is provided 
                                  sensitivity will be scaled in the method setup by the scale_sensitivity method 
                                  expected shape is (N, num_compenets, 1)
        phase_scale_factor: The factor the phase should be scaled by. If none is provided 
                            phase will be scaled in the method setup by the scale_sensitivity method
                            expected shape is (N, num_compenets, 1)
    Returns: 
        scaled_input: The sensitivity and phases scaled and concatinated into the expected format for the NN 
        sensitivity_scale_factor: The factor the sensitivity was scaled by 
        phase_scale_factor: The factor the phase was scaled by  
    '''
    if sensitivity_scale_factor == None: 
        sensitivity_scaled, sensitivity_scale_factor = scale_sensitivty(sensitivity)
    else: 
        sensitivity_scaled = sensitivity / sensitivity_scale_factor
    if phase_scale_factor == None: 
        phase_scaled, phase_scale_factor = scale_phase(phase)
    else: 
        phase_scaled = phase / phase_scale_factor
    scaled_input = np.ma.concatenate([sensitivity_scaled, phase_scaled], axis=1)
    return scaled_input, sensitivity_scale_factor, phase_scale_factor

def scale_velocity(velocity, max_vel): 
    ''' Method scales a velocity profile between 0 and 1 for NN training 
    
    Args: 
        velocity: The velocity profile(s) that should be scaled 
        max_vel: The maximum possible velocity in the training set 
    Returns: 
        The velocity profile(s) scaled such that all are between 0 and 1 
    '''
    return velocity / max_vel

def scale_sensitivty(sensitivity, scale_factor=None):
    ''' Method scales the sensitivity beetween 0 and 1 for NN use 
    
    Args: 
        sensitivity: The sensitivity profile(s) that need to be scaled 
        scale_factor: The factor by which they will be scaled. If none is provided 
                      it will be scaled by the maximum sensitivity in the data set 
    Returns: 
        The sensitivity scaled between 0 and 1 
        scale_factor: the factor by which the sensitivity was scaled 
    '''
    if scale_factor == None: 
        scale_factor = np.max(sensitivity)
    return sensitivity / scale_factor, scale_factor

def scale_phase(phase, scale_factor=None):
    ''' Method scales the phases by the largest magnitude of the provided phases 
    
    Args: 
        phases: The sensitivity profile(s) that need to be scaled 
        scale_factor: The factor by which they will be scaled. If none is provided 
                      it will be scaled by the maximum absolute value of phase in the data set 
    Returns: 
        The phase scaled
        scale_factor: the factor by which the phase was scaled 
    ''' 
    if scale_factor == None:
        scale_factor = np.max(np.abs(phase))
    return phase / scale_factor, scale_factor

def plot_model_results(profile_type, training_velocity, model_velocity, regression=True, 
                       component_graphs=True, global_graphs=True,
                       title_font_size=20, xlabel_font_size=16, ylabel_font_size=16, 
                       bins=50, figsize=None, show_legend=True, hist_range_mag=0.1): 
    ''' Creates a plot of the NN performance for each velocity component being modeled 

    The plot will be a num_vel x 2 subplot where each component has a plot of its predictions versus the actual
    and next to that will be a histogram where the difference between the actual and calculated values is plotted

    Args: 
        training_velocity: The correct values for the velocity profile. 
                           Expected as (size, num_components, 1) 
        model_velocity: The values calcualted by the model for the velocity profile. 
                        Expected as (size, num_components, 1) 
        file_path: The location to where you want to save the pdf version of the results 
        regression: A boolean value if set to true a linear regression of the models performance will be included in the plots. 
                    Set to True by default
        component_graphs: An option to show a graph of each component of velocity seperately 
        global_graphs: An option to show the graph of the results of all components together 
        title_font_size: Sets the font size of the title for each subplot. Default = 12
        xlabel_font_size: Sets the font size of the title for each subplot. Default = 12
        ylabel_font_size: Sets the font size of the title for each subplot. Default = 12
        bins: the number of bins to be used when creating the historgams. Defauly = 50 
        figsize: An optional specifer for a custom size figure to be created. Default = None
        show_lenend: A boolean option to turn on and off the legend being displayed. Default = True 
        hist_range_mag: The upper bound of the histogram range. A symmetric range will be used. Default = 0.1
    Returns: 
        Nothing is returned the plot is created and displayed
    '''
    # creating x labels for plotting linear fits 
    line_data = np.arange(np.min(training_velocity), np.max(training_velocity), np.min(training_velocity) * 1e-3 + 1e-3).reshape(-1, 1)
    # making the correct answers into a 1 dimensional array 
    correct = np.array(training_velocity).reshape(training_velocity.shape[0] * training_velocity.shape[1], 1)
    # making the model answers into a 1 dimensional array 
    guesses = np.array(model_velocity).reshape(model_velocity.shape[0] * model_velocity.shape[1], 1)
    # Getting the components for each vector 
    training_components = np.zeros((training_velocity.shape[0], training_velocity.shape[1]))
    model_components = np.zeros((training_velocity.shape[0], training_velocity.shape[1]))
    history_range = (-hist_range_mag, hist_range_mag)
    # seperating the components for each predition
    for i in range(training_velocity.shape[0]): 
        for j in range(training_velocity.shape[1]): 
            training_components[i, j] = training_velocity[i, j, 0]
            model_components[i, j] = model_velocity[i, j]

    if regression: 
        # Linear Regression for all of the components of every prediction 
        global_fit = LinearRegression().fit(correct, guesses)   
        regressions = [] 
        # Creating a linear fit for each component
        for i in range(training_velocity.shape[1]): 
            temp_correct = training_components[:, i]
            temp_guess = model_components[:, i]
            regressions.append(LinearRegression().fit(temp_correct.reshape(-1, 1),  temp_guess.reshape(-1, 1)))
    # Creating the plots and subplots 
    num_components = training_velocity.shape[1]

    global_index = 0
    file_name = profile_type + '_Velocity_Results/' + profile_type + '_'
    if component_graphs and not global_graphs: 
        file_name += 'All_Components_'
        if figsize == None: 
            figsize = (10, 30)
        fig = plt.figure(figsize=(20, 30)) 
        gs = fig.add_gridspec(num_components, 2, hspace=0.3)
    if global_graphs and not component_graphs: 
        file_name += 'Global_Only_'
        if figsize == None: 
            figsize = (10, 5)
        fig = plt.figure(figsize=figsize) 
        gs = fig.add_gridspec(1, 2, hspace=0.3)
    if component_graphs and global_graphs:
        file_name += 'All_Profiles_' 
        if figsize == None: 
            figsize = (10, 40)
        fig = plt.figure(figsize=figsize) 
        gs = fig.add_gridspec(num_components + 1, 2, hspace=0.3)
        global_index = num_components
    axs = gs.subplots()
    if regression: 
        file_name += 'With_Regression.pdf'
    else : 
        file_name += 'No_Regression.pdf'
    # Plotting results for every individual component 
    line_xlabel = 'Actual [m/s]'
    line_ylabel = 'Predicted [m/s]'

    hist_xlabel = 'Predicted - Actual [m/s]'
    hist_ylabel = 'Counts'
    if component_graphs: 
        for i in range(num_components): 
            legend_names = ['Model', 'y = x']
            axs[i, 0].set
            axs[i, 0].set_title('$\mathregular{v_{%d}}$' % (i), fontsize=title_font_size)
            axs[i, 0].set_xlabel(line_xlabel, fontsize=xlabel_font_size)
            axs[i, 0].set_ylabel(line_ylabel, fontsize=ylabel_font_size)

            axs[i, 0].plot(training_components[:, i], model_components[:, i], 'o')
            axs[i, 0].plot(line_data, line_data, '-k')
            if regression: 
                axs[i, 0].plot(line_data, regressions[i].predict(line_data))
                legend_names.append('Model Regression\n y = %.4f x + %.4f' % (regressions[i].coef_, regressions[i].intercept_))
            if show_legend: 
                axs[i, 0].legend(legend_names)

            axs[i, 1].set_title('$\mathregular{v_{%d}}$' % (i), fontsize=title_font_size)
            axs[i, 1].set_xlabel(hist_xlabel, fontsize=xlabel_font_size)
            axs[i, 1].set_ylabel(hist_ylabel, fontsize=xlabel_font_size)
            axs[i, 1].hist(model_components[:, i] - training_components[:, i], bins=bins, edgecolor='black', range=history_range)
    # plotting for the global fit 
    if global_graphs: 
        legend_names = ['Model', 'y = x']
        if regression: 
            legend_names.append('y = %.4f x + %.4f' % (global_fit.coef_, global_fit.intercept_))
        if global_index == 0: 
            axs[0].set_title('$\mathregular{\\vec{v}}$', fontsize=title_font_size)
            axs[0].set_xlabel(line_xlabel, fontsize=xlabel_font_size)
            axs[0].set_ylabel(line_ylabel, fontsize=ylabel_font_size)
            axs[0].plot(correct, guesses, 'o')
            axs[0].plot(line_data, line_data, '-k')
            if regression: 
                axs[0].plot(line_data, global_fit.predict(line_data))
            if show_legend: 
                axs[0].legend(legend_names)

            axs[1].set_title('$\mathregular{\\vec{v}}$', fontsize=title_font_size)
            axs[1].set_xlabel(hist_xlabel, fontsize=xlabel_font_size)
            axs[1].set_ylabel(hist_ylabel, fontsize=xlabel_font_size)
            axs[1].hist(guesses - correct, bins=bins, edgecolor='black', range=history_range)
        else: 
            axs[global_index, 0].set_title('$\mathregular{\\vec{v}}$', fontsize=title_font_size)
            axs[global_index, 0].set_xlabel(line_xlabel, fontsize=xlabel_font_size)
            axs[global_index, 0].set_ylabel(line_ylabel, fontsize=ylabel_font_size)
            axs[global_index, 0].plot(correct, guesses, 'o')
            axs[global_index, 0].plot(line_data, line_data, '-k')
            if regression: 
                axs[global_index, 0].plot(line_data, global_fit.predict(line_data))
            if show_legend: 
                axs[global_index, 0].legend(legend_names)

            axs[global_index, 1].set_title('$\mathregular{\\vec{v}}$', fontsize=title_font_size)
            axs[global_index, 1].set_xlabel(hist_xlabel, fontsize=xlabel_font_size)
            axs[global_index, 1].set_ylabel(hist_ylabel, fontsize=xlabel_font_size)
            axs[global_index, 1].hist(guesses - correct, bins=bins, edgecolor='black',range=history_range)
    plt.savefig(file_name, format='pdf', bbox_inches='tight')
    plt.show()


def create_model(input_shape, num_output, num_nodes, 
                 num_hidden_layers=1, hidden_layer_activation='relu',  
                 output_activation='linear', optimizer='adam', loss='mse',
                 metrics=['mse', 'mae'], dropout_rate=0): 
    ''' Method creates a simple Sequential MLP NN with fully connected layers 

    Args: 
        input_shape: the shape for the input layer 
        num_output: the number of velocity components being predicted 
        num_nodes: the number of node that will be in each hidden layer 
        num_hidden_layers: the number of hiddens that will be used 
        hidden_layer_activation: the activation function to be used on all hidden layers 
        outpt_activation: the activation for the output layer 
        optimizer: the optimizer that will be used during training 
        loss: the the loss function that will be used to train the model 
        metrics: a list of metrics to track model performance 
        dropout_rate: the dropout rate of node during training to prevent overfitting 
    Returns: 
        The NN model compiled and the model summary is displayed 
    '''
    model = Sequential()
    model.add(Input(shape=input_shape))
    model.add(Dropout(rate=dropout_rate))
    for i in range(num_hidden_layers): 
        model.add(Dense(num_nodes, activation=hidden_layer_activation))
    model.add(Dense(num_output, activation=output_activation))
    model.compile(optimizer=optimizer, loss=loss, metrics=metrics)
    model.summary() 
    return model 
    

def save_model_information(sensitivity_scale_factor, 
                           min_vel, max_vel, num_training_samples, 
                           num_test_samples, nodes_per_layer, 
                           num_hidden_layers, hidden_layer_activation, 
                           epochs, path_to_file, batch_size=None, learning_rate=1e-3, 
                           optimizer='adam', phase_scale_factor=None):
    ''' Save the paramters used when achieving a set of results for the NN model iteration 
    Args: 
        sensitivity_scale_factor: the factor by which the sensitivities will be scaled 
        min_vel: the minimum velocity used in the training data
        max_vel: the mmaximum velocity used in the training data
        num_training_samples: the number of velocity profile, sensitivity profiles pairs the model is trained on 
        num_test_samples: the number velocity profile, sensitivity profiles pairs that are used to validate the model 
        nodes_per_layer: the number of nodes that each hidden layer has 
        num_hidden_layers: the number of hidden layers used in the model 
        hidden_layer_activation: the type of activation function used in the hidden layers 
        epochs: the number of times the training set is shown to the model 
        path_to_file: the location where this information is to be saved 
        batch_size: The batch sized using during training 
        learning_rate: The learning rate used during training 
        optimizer: The optimizer used during training 
        phase_scale_factor: The phase scale factor that should be used when making model predicitions 
    Returns: 
        Nothing is returned but a file with the information is created at the location path_to_file
    '''
    with open(path_to_file, 'w') as f: 
        f.write('phase_scale_factor = ' + str(phase_scale_factor) + '\n')
        f.write('sensitivity_scale_factor = ' + str(sensitivity_scale_factor) + '\n')
        f.write('min_vel = ' + str(min_vel) + '\n') 
        f.write('max_vel = ' + str(max_vel) + '\n') 
        f.write('num_training_samples = ' + str(num_training_samples) + '\n')
        f.write('num_test_samples = ' + str(num_test_samples) + '\n')
        f.write('nodes_per_layer = ' + str(nodes_per_layer) + '\n') 
        f.write('num_hidden_layers = ' + str(num_hidden_layers) + '\n')
        f.write('hidden_layer_activation = ' + hidden_layer_activation + '\n')
        f.write('num_epochs = ' + str(epochs) + '\n') 
        f.write('batch_size = ' + str(batch_size) + '\n') 
        f.write('learning_rate = %E' % learning_rate + '\n')
        f.write('optimizer = '+ optimizer)

def show_previous_results(profile_type, regression=True, 
                          component_graphs=True, global_graphs=True,
                          title_font_size=20, xlabel_font_size=16, ylabel_font_size=16, 
                          bins=50, figsize=None, show_legend=True, hist_range_mag=0.1): 
    ''' Generates plots of the models performance on the validation set after training using the show results function 
        
    Args:   
        profile_type: The profile type that was used to train the model 
        See plot model results for input descriptions 
    Returns:    
        Nothing is returned the plot is diplayed and saved 
    '''
    path_to_results = profile_type + '_Velocity_Results'
    path_to_actual = path_to_results + '/eval_velocity_scaled.npy'
    path_to_predicition = path_to_results + '/model_velocity.npy'
    max_vel = load_model_scaling_factors(profile_type)[-1]

    actual_velocities = np.load(path_to_actual) * max_vel
    predicted_velocities = np.load(path_to_predicition) * max_vel
    plot_model_results(profile_type, actual_velocities, predicted_velocities, path_to_results, regression=regression, 
                       component_graphs=component_graphs, global_graphs=global_graphs, 
                       title_font_size=title_font_size, 
                       xlabel_font_size=xlabel_font_size, 
                       ylabel_font_size=ylabel_font_size, 
                       bins=bins, figsize=figsize,
                       show_legend=show_legend, 
                       hist_range_mag=hist_range_mag)

def load_model_scaling_factors(profile_type): 
    ''' Method loads the scaling factors needed for use of a given model 
    Args:   
        profile_type: the profile type that is used for training the model 
    Returns: 
        phase_scale_factor: The scale factor for the phases 
        sensitivity_scale_factor: The scale factor for the sensitivity 
        max_vel: The maximum possible velocity in the training set 
    '''
    path_to_results = profile_type + '_Velocity_Results'
    path_to_model_params = path_to_results + '/model_params.txt'
    with open(path_to_model_params, 'r') as f: 
        # throw away the phase_scale_factor 
        phase_scale_factor = f.readline()[len('phase_scale_factor = '):-1]
        # throw away sensitivity_scale_factor 
        sensitivity_scale_factor = f.readline()[len('sensitivity_scale_factor = ' ):-1]
        # throw away min_vel 
        f.readline()
        max_vel = float(f.readline()[len('max_vel = ' ):-1])

        if 'None' not in phase_scale_factor: 
            phase_scale_factor = float(phase_scale_factor)
        if 'None' not in sensitivity_scale_factor: 
            sensitivity_scale_factor = float(sensitivity_scale_factor)
    return phase_scale_factor, sensitivity_scale_factor, max_vel 

def plot_historys(historys, params, param_name=None, validation=True): 
    ''' Plots NN models training models training performance over the course of several different training sets 
    Args: 
        historys: an array of the historys of each NN training 
        params: the values of the parameter that is varried over the course of all training 
        param_name: The name of parameter that is being varried 
        validation: An option to plot the validation histories as well as training data 
    Returns: 
        Nothing is displayed but histories are plotted in a (1, 2) subplot with mse on the left and mae on the right 
    '''
    fig = plt.figure(figsize=(10, 5))
    gs = fig.add_gridspec(1, 2, hspace=0.25)
    axs = gs.subplots()
    legend_names = []  
    for i in range(len(historys)):

        curr_names = ["Training"]
        if validation: 
            curr_names.append("Validation")

        for name in curr_names: 
            legend_names.append(str(params[i]) + ' ' + name)       
        axs[0].plot(historys[i].history['mse'], '-o')
        if validation: 
            axs[0].plot(historys[i].history['val_mse'], '-o')
        axs[0].set_title('MSE')
        axs[0].set_xlabel('Epochs')
        axs[0].set_ylabel('Error')

        axs[1].plot(historys[i].history['mae'], '-o')
        if validation: 
            axs[1].plot(historys[i].history['val_mae'], '-o')
        axs[1].set_title('MAE')
        axs[1].set_xlabel('Epochs')
        axs[1].set_ylabel('Error')
        if param_name is not None: 
            print(param_name)
        print('Final Training MSE ' + str(params[i]) + ': %E' % (historys[i].history['mse'][-1]))
        print('Final Validation MSE ' + str(params[i]) + ': %E' % (historys[i].history['val_mse'][-1]))
        print('Final Training MAE ' + str(params[i]) + ': %E' % (historys[i].history['mae'][-1]))
        print('Final Validation MAE ' + str(params[i]) + ': %E\n\n' % (historys[i].history['val_mae'][-1]))
    axs[0].legend(legend_names)
    axs[1].legend(legend_names)
    plt.show()