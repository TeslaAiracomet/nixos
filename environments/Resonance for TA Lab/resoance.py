# %% Cell 1
import numpy as np
import matplotlib.pyplot as plt

def plot_resonance_curve(frequencies, amplitudes):
    """
    Plots the resonance curve given frequencies and corresponding amplitudes.

    Parameters:
    frequencies (array-like): Frequencies at which the amplitude is measured.
    amplitudes (array-like): Amplitudes corresponding to the frequencies.

    Returns:
    None
    """
    plt.figure(figsize=(10, 6))
    plt.plot(frequencies, amplitudes, marker='o', linestyle='-', color='b')
    plt.title('Resonance Curve')
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('Amplitude (units)')
    plt.grid(True)
    plt.xlim(min(frequencies), max(frequencies))
    plt.ylim(min(amplitudes), max(amplitudes))
    plt.show()

# %% Cell 2
def calculate_amplitude(frequency, mass, gamma):
    """
    Calculates the amplitude of a driven harmonic oscillator.

    Parameters:
    frequency (float): Frequency of the driving force.
    mass (float): Mass of the oscillator.
    damping_coefficient (float): Damping coefficient.

    Returns:
    float: Amplitude of the oscillator.
    """
    omega = 2 * np.pi * frequency
    amplitude = 1.225**2 / np.sqrt((7.702**2 - (omega**2))**2 + (2 * gamma * omega)**2)
    return amplitude


# %% Cell 3
mass = .25
gamma = 0.012
frequencies = np.linspace(1.22, 1.23, 80)
amplitudes = [calculate_amplitude(f, mass, gamma) for f in frequencies]
plot_resonance_curve(frequencies, amplitudes)
