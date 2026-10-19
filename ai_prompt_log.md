# Nhật Ký Tra Cứu AI (AI Prompt Log)

### Prompt 1: Bản chất của Write Penalty trong hệ thống IoT
- **Câu hỏi:** "Tại sao Covering Index lại là thảm họa đối với hệ thống cảm biến IoT ghi hàng chục nghìn bản ghi mỗi giây?"
- **Kết quả:** Vì mỗi lần chèn mới, engine InnoDB buộc phải chèn và tái cân bằng trang (page split/rebalance) trên cây B-Tree của Secondary Index. Với số lượng cột lớn và dữ liệu liên tục thay đổi, chi phí I/O ghi đĩa tăng theo cấp số nhân.

### Prompt 2: Ước tính kích thước byte của các trường
- **Câu hỏi:** "Tính dung lượng byte lưu trữ của các kiểu dữ liệu DECIMAL(5,2), VARCHAR(20), DATETIME trong Index node?"
- **Kết quả:** `DATETIME` tốn 5 bytes, `DECIMAL(5,2)` tốn 3 bytes, `VARCHAR(20)` có thể tốn từ 21 đến 80+ bytes (tùy charset utf8mb4). Loại bỏ các cột này khỏi index giúp mỗi node B-Tree chứa được nhiều key hơn, giảm độ sâu của cây và tiết kiệm bộ nhớ đệm Buffer Pool.
