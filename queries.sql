-- 1. Users Table
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password TEXT NOT NULL,
  phone VARCHAR(20) NOT NULL,
  role VARCHAR(20) NOT NULL DEFAULT 'Customer' CHECK (role IN ('Customer', 'Admin'))
);

-- 2. Vehicles Table
CREATE TABLE vehicles (
  vehicle_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  type VARCHAR(20) NOT NULL CHECK (type IN ('car', 'bike', 'truck')),
  model VARCHAR(30),
  registration_number VARCHAR(40) UNIQUE,
  rental_price INTEGER,
  status VARCHAR(20) DEFAULT 'available' CHECK (status IN ('available', 'rented', 'maintenance'))
);

-- 3. Bookings Table
CREATE TABLE bookings (
  booking_id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(user_id),
  vehicle_id INTEGER REFERENCES vehicles(vehicle_id),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'completed', 'cancelled')),
  total_cost INTEGER,
  CONSTRAINT check_dates CHECK (end_date > start_date)
);

-- Insert Users
INSERT INTO users (name, email, password, phone, role) VALUES
('Alice', 'alice@example.com', 'secure_pass_1', '1234567890', 'Customer'),
('Bob', 'bob@example.com', 'secure_pass_2', '0987654321', 'Admin'),
('Charlie', 'charlie@example.com', 'secure_pass_3', '1122334455', 'Customer');

-- Insert Vehicles
INSERT INTO vehicles (name, type, model, registration_number, rental_price, status) VALUES
('Toyota Corolla', 'car', '2022', 'ABC-123', 50, 'available'),
('Honda Civic', 'car', '2021', 'DEF-456', 60, 'rented'),
('Yamaha R15', 'bike', '2023', 'GHI-789', 30, 'available'),
('Ford F-150', 'truck', '2020', 'JKL-012', 100, 'maintenance');

-- Insert Bookings
INSERT INTO bookings (user_id, vehicle_id, start_date, end_date, status, total_cost) VALUES
(1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
(1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
(3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
(1, 1, '2023-12-10', '2023-12-12', 'pending', 100);


-- Query 1: Join users, vehicles, and bookings (Inner Join)
SELECT 
    b.booking_id, 
    u.name AS customer_name, 
    v.name AS vehicle_name, 
    b.start_date, 
    b.end_date, 
    b.status
FROM bookings AS b
INNER JOIN users AS u ON b.user_id = u.user_id
INNER JOIN vehicles AS v ON b.vehicle_id = v.vehicle_id
ORDER BY b.booking_id ASC;

-- Query 2: Find all vehicles that have never been booked
SELECT 
    v.vehicle_id, 
    v.name, 
    v.type, 
    v.model, 
    v.registration_number, 
    v.rental_price, 
    v.status
FROM vehicles AS v
WHERE NOT EXISTS (
    SELECT * 
    FROM bookings AS b 
    WHERE b.vehicle_id = v.vehicle_id
);

-- Query 3: Retrieve available cars
SELECT 
    vehicle_id, 
    name, 
    type, 
    model, 
    registration_number, 
    rental_price, 
    status
FROM vehicles
WHERE type = 'car' AND status = 'available';

-- Query 4: Total bookings per vehicle with more than 2 bookings
SELECT 
    v.name AS vehicle_name, 
    COUNT(*) AS total_bookings
FROM vehicles AS v
INNER JOIN bookings AS b ON v.vehicle_id = b.vehicle_id
GROUP BY v.name
HAVING COUNT(*) > 2;
