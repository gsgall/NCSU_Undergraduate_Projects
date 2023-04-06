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

steamTable = XSteam(XSteam.UNIT_SYSTEM_FLS)
g_c = 32.17 * ui.lbm * ui.ft / (u.s**2 * ui.lbf) 
g = 32.17 * ui.ft / u.s**2

def fuel_centerline_profile(T_s, T_range, z_range, qpp_0, H_f, lambda_, R_o): 
    T_o = np.zeros(z_range.shape) * T_s.unit
    for i, z in enumerate(z_range): 
        lhs = condutivity_int_UO2(T_range) - condutivity_int_UO2(T_s[i])
        rhs = heat_flux(z, qpp_0, H_f, lambda_) * R_o / 2 
        idx = np.where(lhs.value < rhs.value)[0][-1]
        T_o[i] = T_range[idx]
    return T_o

def zuber_findlay(G, x, rho_g, rho_l): 
    if x == 0: 
        return 0
    C_0, V_g = dix(x, rho_g, rho_l)
    alpha_g = 1 / (C_0 * (1 + (1 - x) / x * (rho_g / rho_l)) + rho_g * V_g / (G * x))
    return alpha_g 

def dix(x, rho_g, rho_l): 
    b = (rho_g / rho_l) ** 0.1
    beta = x / (x + (1 - x) * rho_g / rho_l)
    C_0 = beta * (1 + (1 / beta - 1) ** b) 
    sigma = 1.2e-3 * ui.lb / ui.ft 
    g = 32.17 * ui.ft / u.s**2
    g_c = 32.17 * ui.ft / u.s**2
    V_g = 2.9 * ((sigma * g * g_c * (rho_l - rho_g)) / rho_l**2) ** (1/4)
    return C_0, V_g 


def clad_temp(z, H_f, lambda_, T_in,  qpp_0, hc, D, mdot, Cp, gamma_f): 
    T_inf = fluid_temp(z, H_f, lambda_, qpp_0, D, T_in, mdot, Cp, gamma_f)
    T_clad = T_inf + heat_flux(z, qpp_0, H_f, lambda_) / hc
    return T_clad 

def clad_temp_jens_lottes(z, qpp_0, H_f, lambda_, P, T_sat):
    return T_sat + (1.897 * heat_flux(z, qpp_0, H_f, lambda_)**(1/4) * np.exp(-P.value / 900)).value * ui.deg_F
    
def fuel_surface_temp(z, qpp, P, T_sat, lambda_, H, R_o, R_i, H_G, k_c): 
    T_clad = clad_temp_jens_lottes(z, qpp, H, lambda_, P, T_sat)
    qpp_z = heat_flux(z, qpp, H, lambda_)
    return T_clad + qpp_z * R_o * (1 / (H_G * R_i) + 1 / k_c * np.log(R_o / R_i))

def calc_pump_HP(n_p, rho_bar, mdot_core, deltaP, nu=0.75):
    mdot_pump = mdot_core / n_p 
    W = (mdot_pump * deltaP / rho_bar).to(ui.lbf * ui.ft / u.s)
    W = W.to(u.W).to(ui.hp) / nu
    return W 

def martinelli_multiplier(x, mu_f, mu_g, rho_f, rho_g):
    #if x <= 0: 
    #   return 1

    chi_2 = (mu_f / mu_g)**(0.2) * ((1 - x) / x)**(1.8) * (rho_g / rho_f)
    chi = np.sqrt(chi_2)
    phi_2 = (1 + (20 / chi) + (1 / chi_2)) * (1 - x)**(1.8)
    return (1 + phi_2) / 2.2 

def homogeneous_multiplier(z, H_0, x, rho_l, rho_f, rho_g): 
    if z < H_0: 
        return 1 
    if x <= 0: 
        return 1 
    v_f = 1 / rho_f
    v_lg = (1 / rho_g) - (1 / rho_l)
    term1 = rho_f / rho_l 
    term2 = (v_lg / v_f) * x
    return term1 + term2 

def deltaP_f_norm_dc(f, De, H_c, rho_in): 
    return f * (H_c / De)  / (2 * rho_in)

def deltaP_local_norm_dc(K_dc, rho_in): 
    return K_dc / (2 * rho_in)
    
def detlaP_f_norm(f, D_e, x_bar, mu_f, mu_g, rho_f, rho_g, H_0, H_f, show=False, G=0): 
    multiplier = martinelli_multiplier(x_bar, mu_f, mu_g, rho_f, rho_g)
    dP = (f / D_e) * (1 / (2 * rho_f)) * (H_0 + (H_f - H_0) * multiplier)
    if show: 
        print('Core Friction')
        print('Loss = {:f} Quality = {:f} Multiplier = {:f}'.format((dP * G**2 / g_c).to(ui.psi), x_bar, multiplier))
        print()
    return dP

def deltaP_local_norm(loss_array, H_0, rho_l_array, rho_f, rho_g, K_array, x_array, show=False, G=0): 
    multipliers = np.zeros(K_array.shape)

    for i in range(x_array.size): 
        multipliers[i] = homogeneous_multiplier(loss_array[i], H_0, x_array[i], rho_l_array[i], rho_f, rho_g)

    dP = (1 / (2 * rho_f)) * K_array * multipliers
    if show:
        print("Local Core Losses")
        for i in range(dP.size): 
            print('Loss: {:d} = {:f} Quality = {:f} Multiplier: {:f}'.format(i, (G**2 / g_c * dP[i]).to(ui.psi), x_array[i], multipliers[i]))

    return  np.sum(dP)

def delatP_elev(rho_bar, H_c): 
    return rho_bar * g / g_c * H_c 

def dP_from_G(G, G_dc, f, f_dc, D_e, De_dc, H_0, H_f, H_c, x_bar, rho_bar, rho_f, rho_g, mu_f, mu_g, rho_l_array, K_array, K_dc,  x_array, rho_in, loss_array, show=False): 
    dP_f_norm = detlaP_f_norm(f, D_e, x_bar, mu_f, mu_g, rho_f, rho_g, H_0, H_f, show, G)
    dP_local_norm = deltaP_local_norm(loss_array, H_0, rho_l_array, rho_f, rho_g, K_array, x_array, show, G)
    dP_f_norm_dc = deltaP_f_norm_dc(f_dc, De_dc, H_c + H_f, rho_in)
    dP_local_norm_dc = deltaP_local_norm_dc(K_dc, rho_in)
    dP_dc = (G_dc**2 / g_c) * (dP_f_norm_dc + dP_local_norm_dc)
    dP_part = (G**2 / g_c) * (dP_f_norm + dP_local_norm)
    # elevation losses 
    dP_elev_c = delatP_elev(rho_bar, H_c)
    dP_elev_dc = delatP_elev(rho_in, H_c)
    if show: 
        print() 
        print_value('Local Core', ((G**2 / g_c) * dP_local_norm).to(ui.psi))
        print_value('f Downcomer', ((G_dc**2 / g_c) * dP_f_norm_dc).to(ui.psi))
        print_value('Local Downcomer', ((G_dc**2 / g_c) * dP_local_norm_dc).to(ui.psi))
        print_value('Core Elevation', dP_elev_c.to(ui.psi))
        print_value('Downcomer Elevation', dP_elev_dc.to(ui.psi))
        print() 

    dP_elev = dP_elev_c - dP_elev_dc
    dP = (dP_part + dP_dc + (dP_elev - dP_elev_dc)).to(ui.psi)
    return dP

def G_from_DP(deltaP, G_dc, f, f_dc, D_e, De_dc, H_0, H_f, H_c, x_bar, rho_bar, rho_f, rho_g, mu_f, mu_g, rho_l_array, K_array, K_dc, x_array, rho_in, loss_array): 
    dP_f_norm = detlaP_f_norm(f, D_e, x_bar, mu_f, mu_g, rho_f, rho_g, H_0, H_f)
    dP_local_norm = deltaP_local_norm(loss_array, H_0, rho_l_array, rho_f, rho_g, K_array, x_array)
    dP_f_norm_dc = deltaP_f_norm_dc(f_dc, De_dc, H_c + H_f, rho_in)
    dP_local_norm_dc = deltaP_local_norm_dc(K_dc, rho_in)
    dP_dc = (G_dc**2 / g_c) * (dP_f_norm_dc + dP_local_norm_dc)
    dP_part = (dP_f_norm + dP_local_norm)
    # elevation losses 
    dP_elev_c = delatP_elev(rho_bar, H_c)
    dP_elev_dc = delatP_elev(rho_in, H_c)
    dP_elev = dP_elev_c - dP_elev_dc
    numer = g_c * (deltaP - (dP_elev + dP_dc))
    denom = dP_part 
    G = np.sqrt(numer / denom)
    G = G.to(ui.lbm / (ui.ft**2 * u.hr))
    return G 
    
def x_e(h, h_f, h_fg): 
    x = (h - h_f) / h_fg 
    if x < 0: 
        return 0
    return x


def calc_h_in(n, mdot_fd, h_fd, mdot_channel, h_f): 
    h_in = (mdot_fd / (n * mdot_channel)) * h_fd + (1 - (mdot_fd / (n * mdot_channel))) * h_f 
    return h_in

def calc_sg_location(N_sg, H_f): 
    locations = np.linspace(0, H_f.value, N_sg + 2)
    locations = locations[1:-1] * ui.ft 
    return locations

def a_CISE_4(G, P, P_c): 
    G = G.to(u.kg / (u.m**2 * u.s))
    G = G.value 
    P = P.to(u.MPa)
    P = P.value
    P_c = P_c.to(u.MPa)
    P_c = P_c.value 
    if G <= 3375 * ( 1 - (P / P_c))**3:
        return (1 / (1 + 1.481e-4 * (1 - (P / P_c))**(-3) * G))
    else: 
        return ((1 - (P / P_c)) / (G / 1000)**(1/3))

def b_CISE_4(D, G, P, P_c): 
    D = D.to(u.m)
    G = G.to(u.kg / (u.m**2 * u.s))
    P = P.to(u.MPa)
    P_c = P_c.to(u.MPa)
    b = ((0.199 * ((P_c / P) - 1)**0.4 * G * D**1.4).value) * u.m 
    return b

def non_boiling_height_BOC_CISE_4(D, G, P, P_c, H, lambda_, T_in, D_e, D_h, int_shape, show=False):   
    steamTableLocal = XSteam(XSteam.UNIT_SYSTEM_MKS)
    a = a_CISE_4(G, P, P_c) 
    b = b_CISE_4(D, G, P, P_c)

    D_e = D_e.to(u.m)
    D_h = D_h.to(u.m)
    D = D.to(u.m)
    G = G.to(u.kg / (u.m**2 * u.s))
    P = P.to(u.MPa)
    P_c = P_c.to(u.MPa)
    H = H.to(u.m)
    lambda_ = lambda_.to(u.m)
    T_in = T_in.to(u.deg_C, equivalencies=u.temperature())

    H_range = np.arange(1e-3, H.value, 1e-3) * u.m 
    h_f = steamTableLocal.hL_p((P.to(u.bar)).value) * u.kJ / u.kg
    h_g = steamTableLocal.hV_p((P.to(u.bar)).value) * u.kJ / u.kg
    h_in = steamTableLocal.h_pt((P.to(u.bar)).value, (T_in.value)) * u.kJ / u.kg
    lhs = (D_h / D_e) * (a * (H - H_range) / (H - H_range + b))
    rhs = (h_f - h_in) / (h_g - h_f) * int_shape(H_range, H, H, lambda_) / int_shape(0, H_range, H, lambda_)
    
    idx = np.where(lhs.value < rhs.value)[0][-1]
    H_0 = H_range[idx]
    
    if show: 
        print_value('H_0', H_0)
        print_value('H_0', H_0.to(ui.ft))
        plt.figure() 
        plt.plot(H_range, lhs)
        plt.plot(H_range, rhs)
        #plt.plot(H_0, lhs[idx], '*k')
        plt.xlabel('$H_0$ [m]')
        plt.ylim((0, 1))
        plt.title('Non-Boiling Height by Intersection')
        plt.legend(['LHS', 'RHS', 'Intersection'])
        plt.savefig('H_0.pdf', format='pdf', bbox_inches='tight')
        plt.show() 
    return H_0

def mdot_CISE_4(qpp_crit, D, H_0, H_f, lambda_, h_f, h_in, gamma_f, int_shape):
    num = qpp_crit * pi * D * int_shape(0 * ui.ft, H_0, H_f, lambda_)
    denom = gamma_f * (h_f - h_in)  
    mdot = (num / denom).to(ui.lbm / u.hr)
    return mdot 

def qpp_crit_CISE_4(gamma_f, mdot, h_f, h_in, D, H_0, H_f, lambda_, int_shape): 
    num = gamma_f * mdot * (h_f - h_in)
    denom = pi * D * int_shape(0 * ui.ft, H_0, H_f, lambda_)
    qpp_crit = num / denom
    return qpp_crit


def enthalpy_profile(z, qpp, H, D, mdot, lambda_, h_0, gamma_f=1): 
    He = H + 2 * lambda_
    omega = pi * (H + lambda_ - z) / He
    omega2 = pi * (H + lambda_) / He

    omega_terms = omega * np.cos(omega * u.rad) - np.sin(omega * u.rad)
    omega2_terms = omega2 * np.cos(omega2 * u.rad) - np.sin(omega2 * u.rad)

    return h_0 + qpp * He * D / (gamma_f * mdot) * (omega_terms - omega2_terms)


def shape(z, H, lambda_): 
    H_e = H + 2 * lambda_ 
    omega = (pi * (H + lambda_ - z) / H_e) * u.rad
    return omega.value * np.sin(omega)

def heat_flux(z, qpp_0, H, lambda_): 
    return qpp_0 * shape(z, H, lambda_)

def fluid_temp(z, H, lambda_, qpp_0, D, T_in, mdot, Cp, gamma_f): 
    return T_in + (pi * D / (gamma_f * mdot * Cp)) * qpp_0 * int_shape(0 * ui.ft, z, H, lambda_)

def hc_Weisman(G, Ax, D, S, mu, Cp, k): 
    C = 0.042 * S / D - 0.024 
    De = 4 * Ax / (pi * D)
    Re = G * De / mu
    Pr = Cp * mu / k 
    Nu = C * Re**0.8 * Pr**(1/3)
    hc = k * Nu / De 
    hc = hc.value 
    return hc * ui.BTU / (ui.ft**2 * u.hr * ui.deg_F)

def condutivity_int_UO2(T): 
    ans = 3978.1 * np.log((692.6 + T.value) / 692.6) + 6.02366e-12 / 4 * ((T.value - 460)**4 - 460**4) 
    return ans * ui.BTU / (u.hr * ui.ft)

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
    print(str, '= {:0.6E}'.format(value))

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