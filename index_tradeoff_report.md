# Báo Cáo Đánh Đổi Hiệu Năng & Chi Phí Lưu Trữ (SmartFactory)

## 1. Vấn đề của Covering Index (Fat Index)
- Cảm biến IoT đẩy dữ liệu ghi liên tục (Write-heavy). Việc đưa toàn bộ các cột `temperature`, `humidity`, `status` vào `idx_fat_covering` khiến mỗi câu lệnh `INSERT` phải cập nhật lại cây B-Tree cồng kềnh, gây ra hiện tượng Write Penalty và nghẽn hàng đợi (bottleneck).
- Dung lượng `Index_length` phình to gấp nhiều lần `Data_length`, gây tốn kém chi phí lưu trữ SSD trên Cloud.

## 2. Giải pháp Lean Index & Đánh đổi
- Thay thế bằng `idx_lean_search(sensor_id, recorded_at)`: Chỉ đánh chỉ mục trên các cột điều kiện lọc `WHERE`.
- **Đánh đổi:** 
  - Truy vấn `SELECT` mất trạng thái `Using index` và phải lookup ngược về Clustered Index (Primary Key) để lấy các cột còn lại, độ trễ tăng nhẹ ở mức mili-giây không đáng kể.
  - Ngược lại, tốc độ `INSERT` tăng vọt gấp nhiều lần, loại bỏ nghẽn luồng ghi cảm biến và tiết kiệm hơn 70% dung lượng lưu trữ chỉ mục.
