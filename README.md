# H5N1 Algorithm Package

This is the official source code for the H5N1 algorithm, designed to solve single-objective and multi-objective optimization problems in engineering.

## Directory Structure

```
H5N1_Package/
├── algorithms/
│   ├── single/                    # Single-objective H5N1 algorithm
│   │   ├── SH5N1.m               # Main implementation
│   │   ├── main_SH5N1.m          # Main execution file
│   │   ├── Get_F.m               # Objective function calculation
│   │   └── initialization.m       # Population initialization
│   │
│   └── multi/                     # Multi-objective H5N1 algorithm
│       ├── MH5N1.m               # Main implementation
│       ├── main_MH5N1.m          # Main execution file
│       └── initialization.m       # Population initialization
│
└── utils/
    ├── archive/                   # Archive management
    │   ├── UpdateArchive.m       # Archive update
    │   ├── HandleFullArchive.m   # Full archive handling
    │   └── RankingProcess.m      # Ranking calculation
    │
    ├── selection/                 # Selection methods
    │   ├── RouletteWheelSelection.m  # Roulette wheel selection
    │   └── dominates.m           # Dominance check
    │
    ├── benchmark/                 # Benchmark functions
    │   ├── ZDT.m                 # ZDT test function
    │   ├── xboundary.m           # x boundary handling
    │   ├── xyboundary.m          # xy boundary handling
    │   └── Get_problem.m         # Test problem retrieval
    │
    └── metrics/                   # Performance metrics
        └── IGD.m                 # Inverted Generational Distance
```

## Installation and Usage

1. Clone this repository to your machine
2. Open MATLAB
3. Navigate to the H5N1_Package directory

### Running Single-objective Algorithm (SH5N1)
1. Open `algorithms/single/main_SH5N1.m`
2. Run this file in MATLAB

### Running Multi-objective Algorithm (MH5N1)
1. Open `algorithms/multi/main_MH5N1.m`
2. Run this file in MATLAB

## Requirements
- MATLAB (R2022a or later)
- Optimization Toolbox
- Global Optimization Toolbox

## Author
- **Author:** Le Xuan Thang
- **Email:** 
  - lexuanthang.official@gmail.com
  - lexuanthang.official@outlook.com
- **Website:** https://lexuanthang.vn

## Citation
If you use this code in your research, please cite:

Le, T.X., Bui, T.T. and Tran, H.N. (2025), "The H5N1 algorithm: a viral-inspired optimization for solving real-world engineering problems", Engineering Computations

DOI: https://doi.org/10.1108/EC-05-2024-0472

