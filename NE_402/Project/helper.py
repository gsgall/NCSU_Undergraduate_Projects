import numpy as np
import matplotlib.pyplot as plt
import astropy.units as u 
import astropy.units.imperial as ui 
from pyXSteam.XSteam import XSteam
from matplotlib.ticker import ScalarFormatter, AutoMinorLocator, FormatStrFormatter
from math import pi

ui.enable()
plt.rcParams['text.usetex'] = True
plt.rcParams['mathtext.fontset'] = 'stix'
plt.rcParams['font.family'] = 'STIXGeneral'

def calc_G(deltaP, H, n_sg, K_sg, K_dc, K_in, K_out, fbar, De, rho_bar, rho_in, rho_out): 
    g_c = 32.17 * ui.lbm * ui.ft / (ui.lbf * u.s**2) 
    g = 32.17 * ui.ft / u.s**2
    dP_term = g_c * deltaP - rho_bar * g * H
    local_terms = n_sg * K_sg / (2 * rho_bar) + K_dc / (2 * rho_bar) + K_in / (2 * rho_in) + K_out / (2 * rho_out)
    friction_term = fbar * H / (De * 2 * rho_bar)

    G = np.sqrt(dP_term * (local_terms + friction_term)**-1)
    return G.to(ui.lbm / (ui.ft**2 * u.h))

def calc_deltaP(G, H, n_sg, K_sg, K_dc, K_in, K_out, fbar, De, rho_bar, rho_in, rho_out): 
    g_c = 32.17 * ui.lbm * ui.ft / (ui.lbf * u.s**2) 
    g = 32.17 * ui.ft / u.s**2

    local_terms = n_sg * K_sg / (2 * rho_bar) + K_dc / (2 * rho_bar) + K_in / (2 * rho_in) + K_out / (2 * rho_out)
    friction_term = fbar * H / (De * 2 * rho_bar)
    elevation_term = rho_bar * g * H/ g_c 

    deltaP = G**2 / g_c * (local_terms + friction_term) + elevation_term

    return deltaP.to(ui.psi)

def enthalpy_profile(z, qpp, H, D, mdot, lambda_, h_0, gamma_f=1): 
    He = H + 2 * lambda_
    omega = pi * (H + lambda_ - z) / He
    omega2 = pi * (H + lambda_) / He

    omega_terms = omega * np.cos(omega * u.rad) - np.sin(omega * u.rad)
    omega2_terms = omega2 * np.cos(omega2 * u.rad) - np.sin(omega2 * u.rad)

    return h_0 + qpp * He * D / (gamma_f * mdot) * (omega_terms - omega2_terms)




def calc_qpp_bar(gamma_f, n, D, Qdot, H, lambda_): 
    qpp = gamma_f * Qdot / (n * pi * D * int_shape(0, H, H, lambda_))
    return qpp.to(ui.BTU / (u.h * ui.ft**2))

def calc_Re(G, D, mu): 
    return G * D / mu 

def calc_De(Ax, D): 
    return 4 * Ax / (pi * D)

def calc_Ax(S, D): 
    return S**2 - pi * D**2 / 4 

def friction_factor(Re): 
    if Re < 30000: 
        return 0.3164 * Re**(-0.25)
    
    return 0.184 * Re**(-0.2) 

def calc_h_bar(h_0, D, gamma_f, mdot, qpp_0, H, lambda_):
    ''' Calculates the average enthalpy in since channel 
    Args: 
    Returns: 
    '''
    H_e = H + 2 * lambda_
    tau =  D * qpp_0 * H_e / (gamma_f * mdot) 

    omega_1 = pi * lambda_ / H_e
    omega_2 = pi * (H + lambda_) / H_e

    C = h_0 - tau * (omega_2 * np.cos(omega_2 * u.rad) - np.sin(omega_2 * u.rad))

    omega_1_terms = omega_1 * np.sin(omega_1 * u.rad) + 2 * np.cos(omega_1 * u.rad)
    omega_2_terms = omega_2 * np.sin(omega_2* u.rad) + 2 * np.cos(omega_2 * u.rad)

    h_bar = C + tau * H_e / (pi * H) * (omega_2_terms - omega_1_terms)
    return h_bar

def int_shape(start, stop, H, lambda_):
    H_e = H + 2 * lambda_ 
    omega_start = pi * (H + lambda_ - start) / H_e
    omega_stop = pi * (H + lambda_ - stop) / H_e 

    omega_start_terms = omega_start * np.cos(omega_start * u.rad) - np.sin(omega_start * u.rad)
    omega_stop_terms = omega_stop * np.cos(omega_stop * u.rad) - np.sin(omega_stop * u.rad)

    return (H_e / pi) * (omega_stop_terms - omega_start_terms)

def find_omega(step, decimals):
    theta_max = pi
    theta = np.arange(0, np.pi, step)
    vals = np.tan(theta)
    plt.figure() 
    plt.plot(theta, vals)
    plt.plot(theta, -theta)
    
    vals = np.around(vals, decimals=decimals)
    theta = np.around(theta, decimals=decimals)
    idx = np.where(vals == -theta)
    trivial = np.where(idx[-1] < 1e3) 
    idx = np.delete(idx[-1],idx[-1][trivial])
    for i in idx: 
        print('i =', i)
    idx = idx[-1]
    omega = theta[idx]
    print('Omega =', omega)
    plt.plot(theta[idx], vals[idx], '*k')
    plt.title('Intersection of $\\tan(\omega)$ and $-\omega$')
    plt.xlabel('$\omega$')
    plt.ylim([-5, 5])
    plt.legend(['$\\tan(\omega)$', '$-\omega$', 'Intersection Point'])
    plt.savefig('figs/omega.pdf', format='pdf', bbox_inches='tight')
    plt.show()
    return omega 

def find_intersection(lhs, rhs, precision, show=True): 
    lhs = np.around(lhs, precision)
    rhs = np.around(rhs, precision)

    idx = np.where(lhs == rhs)
    if show: 
        for i in idx[0]: 
            print('i =', i)
    return idx

def print_value(str, value): 
    print(str, '= {0:4E}'.format(value))

def find_lambda(D, H, F_z): 
    omega = find_omega(1e-6, 5)
    lambda_range = np.arange(0, H.value / 2, 1e-3) * ui.ft 
    lhs = H * omega * np.sin(omega) / F_z
    rhs = int_shape(0, H, H, lambda_range)
    idx = find_intersection(lhs.value, rhs.value, 3, False)[0][0]
    lambda_ = lambda_range[idx]
    plt.figure() 
    plt.axhline(lhs.value, c='tab:blue')
    plt.plot(lambda_range, rhs, color='tab:orange')
    plt.plot(lambda_, lhs, '*k')
    plt.legend(['$H \\frac{\omega \sin(\omega)}{F_z}$', '$\int_0^H Z(z) dz$', 'Intersection'])
    plt.title('Extrapolated Distance by Intersection')
    plt.xlabel('$\lambda$ [ft]')
    plt.ylabel('[ft]')
    plt.savefig('figs/lambda.pdf', format='pdf', bbox_inches='tight')
    plt.show()
    print_value('lambda', lambda_)
    return lambda_, omega  