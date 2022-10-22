from ECFM_NN_helpers import load_model_scaling_factors
import matplotlib.pyplot as plt
import numpy as np 
plt.rcParams['mathtext.fontset'] = 'stix'
plt.rcParams['font.family'] = 'STIXGeneral'

def show_prev_seperate(profile_type, figsize=(5, 5),
                       title_font_size=24, 
                       label_font_size=20,
                       tick_size=14,
                       bins=20,history_range=(-0.1, 0.1)):
    ''' Displays the training verification data set results saved at the end of the DNN training 

    Args: 
        profile_type: the type of profile used to train the DNN 
        figsize: the size of the linear plot and histogram that will be generated. Default = (5, 5)
        title_font_size: the font size of the plots title. Default = 24 
        label_font_size: the font size of the plots x and y axis labels. Default = 20
        tick_size: the size of the plots ticks. Default = 14 
        bins: The number of bins used in generating the histograms. Default = 20 
        history_range: The range of values that the histogram displays. Defualt = (-0.1, 0.1)
    Returns: 
        Generates a plot with the line y=x on it and each of the DNN predictions plotted against the correct answers 
        plot is then saved as "profile_type_Velocity_Results/profile_type_line.pdf"
        Generates a histogram of the errors in the model predictions 
        plot is then saved as "profile_type_Velocity_Results/profile_type_hist.pdf"
        The maximum error in the predictions is also printed 
    '''
    max_vel = load_model_scaling_factors(profile_type)[-1]
    path_to_results = profile_type + '_Velocity_Results'
    path_to_actual = path_to_results + '/eval_velocity_scaled.npy'
    path_to_predicition = path_to_results + '/model_velocity.npy'
    path_to_figs = path_to_results + '/'
    correct_answers = np.load(path_to_actual) * max_vel 
    model_answers = np.load(path_to_predicition) * max_vel
    correct_answers = correct_answers.reshape(correct_answers.shape[0] * correct_answers.shape[1], 1)
    model_answers = model_answers.reshape(-1, 1)
    line_data = line_data = np.arange(0, max_vel, max_vel * 1e-3) 
    plt.figure(figsize=figsize) 
    plt.plot(correct_answers, model_answers, 'o')
    plt.plot(line_data, line_data, '-k')
    plt.title(profile_type.replace('_With_Phase', '') + ' Model Verification', fontsize=title_font_size)
    plt.xlabel('Actual [m/s]', fontsize=label_font_size)
    plt.ylabel('Predicted [m/s]', fontsize=label_font_size)
    plt.tick_params(axis='x', labelsize=tick_size)
    plt.tick_params(axis='y', labelsize=tick_size)
    plt.savefig(path_to_figs + profile_type + '_line.pdf', format='pdf', bbox_inches='tight')
    plt.show() 

    plt.figure(figsize=figsize) 
    plt.title(profile_type.replace('_With_Phase', '') + ' Model Verification Error', fontsize=title_font_size)
    plt.hist(model_answers - correct_answers, bins=bins, edgecolor='black',range=history_range)
    plt.xlabel('Predicted - Actual [m/s]', fontsize=label_font_size)
    plt.ylabel('Counts', fontsize=label_font_size)
    plt.tick_params(axis='x', labelsize=tick_size)
    plt.tick_params(axis='y', labelsize=tick_size)
    plt.savefig(path_to_figs + profile_type + '_hist.pdf', format='pdf', bbox_inches='tight')
    plt.show() 

    print('Max Error:', np.max(np.abs(model_answers - correct_answers)))