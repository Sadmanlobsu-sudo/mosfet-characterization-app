# MOSFET Characterization and Analysis Tool

A MATLAB App Designer–based interactive simulator for analyzing MOSFET behavior using numerical methods. The application allows users to configure device parameters, perform bias sweeps, visualize operating regions, and study solver convergence characteristics.

---

## Overview

This tool simulates the DC behavior of a MOSFET using analytical device equations combined with numerical solution techniques. It provides a graphical interface to explore output characteristics, operating regions, and solver performance.

The application is designed as a compact educational and analytical environment for understanding MOSFET operation and nonlinear solver behavior.

---

## Features

**Device Modeling**

* Adjustable MOSFET parameters (threshold voltage, mobility, oxide capacitance, geometry)
* Optional channel-length modulation
* Source resistance feedback modeling

**Bias Sweeps**

* Configurable VDS sweep range
* Flexible VGS set input (manual values or generated range)
* Warm-start continuation across bias points

**Numerical Solver**

* Fixed-point iteration method
* Newton method fallback for non-convergent points
* Adjustable solver parameters:

  * maximum iterations
  * damping factor
  * convergence tolerance
  * Newton finite-difference step

**Visualization**

* Output characteristics (ID vs VDS)
* MOSFET region map (Cutoff / Linear / Saturation)
* Iteration count heatmap
* Solver convergence plot (log-scale error)

**Interactive Controls**

* Run / Pause / Resume solver
* Reset parameters
* Enable or disable physical effects
* Optional region boundary overlay

**Export Options**

* Export plots as **PNG** or **PDF**
* Export data as **CSV**
* Save simulation state as **MAT**

---

## Application Interface

The GUI is divided into several sections:

**Device Parameters**

* Threshold voltage
* Electron mobility
* Oxide capacitance density
* Geometry ratio (W/L)
* Source resistance
* Channel-length modulation

**Solver Controls**

* Solver method selection
* Maximum iteration limit
* Fixed-point damping factor
* Newton fallback configuration
* Convergence tolerance

**Sweep Settings**

* Drain-to-source voltage sweep
* Gate voltage set editor
* Warm-start option

**Visualization Tabs**

* Output Curves
* Mode Map
* Iteration Heatmap
* Convergence Plot
* Summary Report

---

## Numerical Approach

The MOSFET current is solved using an iterative method because the source resistance introduces a nonlinear feedback loop.

The solver performs:

1. **Fixed-Point Iteration**

   ID is iteratively updated using a damped update rule until convergence.

2. **Newton Method Fallback**

   If the fixed-point iteration fails to converge within the specified limit, a Newton iteration is used to refine the solution.

3. **Warm-Start Continuation**

   Each bias point uses the previous solution as an initial guess to improve convergence speed.

---

## Example Outputs

The application generates several visual diagnostics:

* Output characteristic curves for multiple VGS values
* Region classification map across bias space
* Iteration heatmap showing solver difficulty
* Convergence traces for worst-case bias points

These visualizations help analyze both **device behavior** and **numerical solver performance**.

---

## Requirements

* MATLAB R2022+ recommended
* MATLAB App Designer

No additional toolboxes are required.

---

## Running the Application

1. Clone the repository

```bash
git clone https://github.com/Sadmanlobsu-sudo/mosfet-characterization-app.git
```

2. Open MATLAB

3. Open the App Designer file:

```
MOSFET_app.mlapp
```

4. Click **Run** in App Designer.

---

## Project Structure

```
MOSFET-app/
│
├── MOSFET_app.mlapp      % Main App Designer interface
├── solver.m              % Nonlinear solver implementation
├── calc_model.m          % MOSFET current model
└── README.md             % Project documentation
```

---

## Educational Purpose

This project demonstrates:

* nonlinear equation solving
* device modeling
* graphical simulation tools
* MATLAB App Designer development
* numerical convergence diagnostics

It can be used as a learning tool for:

* semiconductor device analysis
* numerical methods
* interactive engineering visualization.
