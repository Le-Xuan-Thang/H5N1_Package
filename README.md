# H5N1 Algorithm v1.0.0

This is the official source code for the H5N1 algorithm, designed to solve single-objective and multi-objective optimization problems in engineering.

## Overview
The H5N1 algorithm is a novel viral-inspired optimization algorithm for solving both single-objective and multi-objective optimization problems. This package provides MATLAB implementations of both variants:
- Single-objective H5N1 (SH5N1)
- Multi-objective H5N1 (MH5N1)

## Version Information
- Current version: 1.0.0
- Release date: March 13, 2024
- Status: Stable release
- License: MIT License

## Directory Structure
```
.
├── algorithms/
│   ├── single/                    # Single-objective H5N1 algorithm
│   │   ├── SH5N1.m               # Main implementation
│   │   ├── main_SH5N1.m          # Main execution file
│   │   ├── Get_F.m               # Objective function calculation
│   │   └── initialization.m       # Population initialization
│   └── multi/                     # Multi-objective H5N1 algorithm
│       ├── MH5N1.m               # Main implementation
│       ├── main_MH5N1.m          # Main execution file
│       └── initialization.m       # Population initialization
├── utils/
│   ├── archive/                   # Archive management
│   │   ├── UpdateArchive.m       # Archive update
│   │   ├── HandleFullArchive.m   # Full archive handling
│   │   └── RankingProcess.m      # Ranking calculation
│   ├── selection/                 # Selection methods
│   │   ├── RouletteWheelSelection.m  # Roulette wheel selection
│   │   └── dominates.m           # Dominance check
│   ├── benchmark/                 # Benchmark functions
│   │   ├── ZDT.m                 # ZDT test function
│   │   ├── xboundary.m           # x boundary handling
│   │   ├── xyboundary.m          # xy boundary handling
│   │   └── Get_problem.m         # Test problem retrieval
│   └── metrics/                   # Performance metrics
│       └── IGD.m                 # Inverted Generational Distance
├── README.md
├── LICENSE
└── CHANGELOG.md
```

## Features
- Single-objective optimization (SH5N1)
- Multi-objective optimization (MH5N1)
- Benchmark functions:
  - ZDT test suite (ZDT1, ZDT2, ZDT3)
  - UF test problems (UF5, UF6, UF9)
- Utility functions for:
  - Archive management
  - Selection mechanisms
  - Performance metrics
  - Boundary handling

## Requirements
- MATLAB R2022a or later
- Optimization Toolbox
- Global Optimization Toolbox

## Installation
1. Download or clone this repository
2. Add the root directory and all subdirectories to your MATLAB path:
```matlab
addpath(genpath('path_to_h5n1'));
```
3. Run the example scripts to verify installation

## Usage
### Single-objective Optimization
```matlab
% Example usage of SH5N1
[best_solution, best_fitness] = SH5N1(problem_params);
```

### Multi-objective Optimization
```matlab
% Example usage of MH5N1
[pareto_front, pareto_set] = MH5N1(problem_params);
```

### Running Example Scripts
1. For Single-objective Algorithm (SH5N1):
   - Open `algorithms/single/main_SH5N1.m`
   - Run this file in MATLAB

2. For Multi-objective Algorithm (MH5N1):
   - Open `algorithms/multi/main_MH5N1.m`
   - Run this file in MATLAB

## Documentation
Detailed documentation is available for all functions. Use MATLAB's help command:
```matlab
help function_name
```

## Citation
If you use this algorithm in your research, please cite:
```
@article{le2025h5n1,
  title={The H5N1 algorithm: a viral-inspired optimization for solving real-world engineering problems},
  author={Le, T.X. and Bui, T.T. and Tran, H.N.},
  journal={Engineering Computations},
  year={2025},
  doi={10.1108/EC-05-2024-0472}
}
```

## Contact
- Author: Le Xuan Thang
- Email: 
  - lexuanthang.official@gmail.com
  - lexuanthang.official@outlook.com
- Website: https://lexuanthang.vn

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Changelog
See [CHANGELOG.md](CHANGELOG.md) for a list of changes in each version.

