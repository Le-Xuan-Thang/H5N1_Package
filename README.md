# H5N1 Algorithm: A Viral-Inspired Optimization Approach

## Introduction
The **H5N1 Algorithm** is a novel metaheuristic optimization algorithm inspired by the infection and mutation mechanisms of the avian influenza virus (H5N1). This algorithm simulates the adaptive behavior and evolutionary process of the H5N1 virus to enhance optimization performance for solving complex real-world engineering problems.

This repository provides the source code for **SH5N1** (single-objective version) and **MH5N1** (multi-objective version), implemented in MATLAB.

## Features
- **Bio-Inspired Mechanism**: Models the spread, mutation, and adaptation of the H5N1 virus for improved search efficiency.
- **Single and Multi-Objective Optimization**: Supports both single-objective (SH5N1) and multi-objective (MH5N1) optimization problems.
- **Benchmark Testing**: Evaluated on standard benchmark functions and real-world engineering problems.
- **Superior Performance**: Demonstrated to outperform various existing optimization algorithms.

## How It Works
The H5N1 algorithm operates based on two main mechanisms:
1. **Exploration Phase**: Simulates the rapid spread of the virus to cover a large search space.
2. **Exploitation Phase**: Uses adaptive mutation strategies to refine solutions and converge to the global optimum.

## Installation & Usage
### Requirements
- MATLAB R2022a or later

### Running the Algorithm
To execute the algorithm, simply run the corresponding main script in each directory:

#### For Single-Objective Optimization (SH5N1)
```matlab
run('SH5N1/main_SH5N1.m');
```

#### For Multi-Objective Optimization (MH5N1)
```matlab
run('MH5N1/main_MH5N1.m');
```

## File Structure
```
|-- H5N1-Algorithm/
    |-- MH5N1/
    |   |-- ToolboxMOA_LXT/        # Toolbox for multi-objective optimization
    |   |   |-- DeltaP.m
    |   |   |-- dominates.m
    |   |   |-- HandleFullArchive.m
    |   |   |-- initialization.m
    |   |   |-- RankingProcess.m
    |   |   |-- RouletteWheelSelection.m
    |   |   |-- UpdateArchive.m
    |   |-- main_MH5N1.m           # Main script for MH5N1 algorithm
    |   |-- MH5N1.m                # Core function for MH5N1
    |
    |-- SH5N1/
    |   |-- Get_F.m
    |   |-- initialization.m
    |   |-- main_SH5N1.m           # Main script for SH5N1 algorithm
    |   |-- SH5N1.m                # Core function for SH5N1
    |
    |-- README.md                  # This file
```

## Experimental Results
The H5N1 algorithm has been tested on:
- **23 benchmark functions** for single-objective optimization.
- **ZDT and CEC2009** multi-objective test problems.
- **Real-world engineering problems**, demonstrating superior performance compared to other algorithms.

For detailed results, refer to the **Paper-H5N1.pdf** file.

## Citation
If you use this algorithm in your research, please cite our paper:
> Le, T.X., Bui, T.T., & Tran, H.N. (2025). "The H5N1 algorithm: a viral-inspired optimization for solving real-world engineering problems." *Engineering Computations.* [DOI: 10.1108/EC-05-2024-0472](https://doi.org/10.1108/EC-05-2024-0472)

## Contact
- **Author**: Le Xuan Thang  
- **Email**: [lexuanthang.official@gmail.com](mailto:lexuanthang.official@gmail.com) | [lexuanthang.official@outlook.com](mailto:lexuanthang.official@outlook.com)
- **Website**: [https://lexuanthang.vn](https://lexuanthang.vn)

## License
This project is open-source and licensed under the MIT License. Feel free to modify and distribute with proper attribution.

