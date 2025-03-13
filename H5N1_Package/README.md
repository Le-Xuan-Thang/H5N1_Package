# H5N1 Algorithm Package

Đây là mã nguồn chính thức cho thuật toán H5N1, được thiết kế để giải quyết các bài toán tối ưu đơn mục tiêu và đa mục tiêu trong kỹ thuật.

## Cấu trúc Thư mục

```
H5N1_Package/
├── algorithms/
│   ├── single/                    # Thuật toán H5N1 đơn mục tiêu
│   │   ├── SH5N1.m               # Triển khai chính
│   │   ├── main_SH5N1.m          # File chạy chính
│   │   ├── Get_F.m               # Hàm tính toán mục tiêu
│   │   └── initialization.m       # Khởi tạo quần thể
│   │
│   └── multi/                     # Thuật toán H5N1 đa mục tiêu
│       ├── MH5N1.m               # Triển khai chính
│       ├── main_MH5N1.m          # File chạy chính
│       └── initialization.m       # Khởi tạo quần thể
│
└── utils/
    ├── archive/                   # Quản lý kho lưu trữ
    │   ├── UpdateArchive.m       # Cập nhật kho lưu trữ
    │   ├── HandleFullArchive.m   # Xử lý kho lưu trữ đầy
    │   └── RankingProcess.m      # Tính toán xếp hạng
    │
    ├── selection/                 # Các phương pháp chọn lọc
    │   ├── RouletteWheelSelection.m  # Chọn lọc bánh xe roulette
    │   └── dominates.m           # Kiểm tra quan hệ trội
    │
    ├── benchmark/                 # Các hàm benchmark
    │   ├── ZDT.m                 # Hàm test ZDT
    │   ├── xboundary.m           # Xử lý biên x
    │   ├── xyboundary.m          # Xử lý biên xy
    │   └── Get_problem.m         # Lấy bài toán test
    │
    └── metrics/                   # Các metrics đánh giá
        └── IGD.m                 # Inverted Generational Distance
```

## Cài đặt và Sử dụng

1. Clone repository này về máy của bạn
2. Mở MATLAB
3. Điều hướng đến thư mục H5N1_Package

### Chạy thuật toán đơn mục tiêu (SH5N1)
1. Mở file `algorithms/single/main_SH5N1.m`
2. Chạy file này trong MATLAB

### Chạy thuật toán đa mục tiêu (MH5N1)
1. Mở file `algorithms/multi/main_MH5N1.m`
2. Chạy file này trong MATLAB

## Yêu Cầu
- MATLAB (R2022a trở lên)
- Optimization Toolbox
- Global Optimization Toolbox

## Tác giả
- **Tác giả:** Lê Xuân Thắng
- **Email:** 
  - lexuanthang.official@gmail.com
  - lexuanthang.official@outlook.com
- **Website:** https://lexuanthang.vn

## Trích dẫn
Nếu bạn sử dụng mã nguồn này trong nghiên cứu của mình, vui lòng trích dẫn:

Le, T.X., Bui, T.T. and Tran, H.N. (2025), "The H5N1 algorithm: a viral-inspired optimization for solving real-world engineering problems", Engineering Computations

DOI: https://doi.org/10.1108/EC-05-2024-0472

