-- 1. Khoi tao co so du lieu va bang SensorLogs
CREATE DATABASE IF NOT EXISTS smartfactory_db;
USE smartfactory_db;

CREATE TABLE IF NOT EXISTS SensorLogs (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sensor_id INT NOT NULL,
    recorded_at DATETIME NOT NULL,
    temperature DECIMAL(5, 2),
    humidity DECIMAL(5, 2),
    status VARCHAR(20)
);

-- Tao Fat Covering Index ban dau gay qua tai Write va ton storage
CREATE INDEX idx_fat_covering ON SensorLogs(sensor_id, recorded_at, temperature, humidity, status);

-- Kiem tra dung luong hien tai
SHOW TABLE STATUS LIKE 'SensorLogs';

-- 2. Giai phap Toi uu: Xoa Fat Index va tao Lean Index
ALTER TABLE SensorLogs DROP INDEX idx_fat_covering;

-- Chi danh index cho cac cot dung de loc (WHERE / ORDER BY)
CREATE INDEX idx_lean_search ON SensorLogs(sensor_id, recorded_at);

-- 3. Kiem tra va chung minh hieu nang bang EXPLAIN
EXPLAIN SELECT temperature, humidity, status 
FROM SensorLogs 
WHERE sensor_id = 105 AND recorded_at >= '2026-06-20';
