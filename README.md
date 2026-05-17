# Hybrid Audio Restoration System 🎵⚙️

This repository contains a MATLAB-based Digital Signal Processing (DSP) project focused on audio restoration. The system effectively removes multiple types of interference from a corrupted audio signal using a hybrid approach that combines Infinite Impulse Response (IIR) and Finite Impulse Response (FIR) filters.

## 📝 Project Overview

In real-world audio processing, recordings are often corrupted by electrical and environmental noise. This script simulates such an environment by taking a clean audio sample (Handel's "Hallelujah" chorus) and injecting two common types of noise:
1. **Mains Hum (50 Hz):** Simulating low-frequency electrical grid interference.
2. **High-Frequency Whine (3000 Hz):** Simulating continuous high-pitched electronic noise.

The objective of this project is to restore the original signal with minimal distortion to the audio quality.

## 🛠️ Filtering Methodology

To achieve optimal noise reduction without compromising the rich harmonics of the choir, a two-stage hybrid filtering architecture is implemented:

### Stage 1: Surgical Low-Frequency Removal (IIR)
* **Filter Type:** Chebyshev Type II (Bandstop / Notch)
* **Why:** IIR filters offer excellent computational efficiency and incredibly steep roll-offs (surgical precision) at low orders. A Chebyshev Type II was specifically chosen because it provides a flat passband (no distortion to the desired audio) while restricting the ripples entirely to the stopband.
* **Specifications:** Order $N=3$, Stopband 45 Hz - 55 Hz, 40 dB attenuation.

### Stage 2: Targeted High-Frequency Removal (FIR)
* **Filter Type:** Windowed FIR (Bandstop)
* **Why:** A standard Lowpass filter would clip the natural high-frequency harmonics of the vocals, resulting in a "muffled" sound. Instead, a targeted FIR Bandstop filter is used. FIR filters guarantee absolute stability and, when combined with Zero-Phase filtering, prevent any phase distortion across the frequency spectrum.
* **Specifications:** Stopband 2900 Hz - 3100 Hz.

*Note: Both stages utilize Zero-Phase digital filtering (`filtfilt`) to prevent time shifts and phase distortion.*

## 📊 Evaluation & Results

The system evaluates its performance both quantitatively and qualitatively:
* **Quantitative Metric:** Calculates the Total Squared Error between the original uncorrupted signal and the final restored signal, mathematically
