USE xil402;

### Database for our final project
### Jeff Li, Yaolin

### Create cunstomer table
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    gender ENUM('M', 'F', 'O') NOT NULL,
    date_of_birth DATE NOT NULL,
    join_date DATE NOT NULL,
    membership_type ENUM('Bronze', 'Silver', 'Gold', 'Platinum') NOT NULL
) ENGINE = InnoDB;

INSERT INTO Customers (name, email, phone, gender, date_of_birth, join_date, membership_type)
VALUES 
('John Doe', 'john.doe@example.com', '555-111-1234', 'M', '1990-01-01', '2023-01-01', 'Gold'),
('Jane Smith', 'jane.smith@example.com', '555-111-2345', 'F', '1995-05-15', '2023-02-10', 'Silver'),
('Alice Johnson', 'alice.johnson@example.com', '555-111-3456', 'F', '1998-09-30', '2023-03-05', 'Bronze'),
('Bob Williams', 'bob.williams@example.com', '555-111-4567', 'M', '1993-06-20', '2023-01-15', 'Platinum'),
('Charlie Brown', 'charlie.brown@example.com', '555-111-5678', 'M', '2000-12-25', '2023-02-25', 'Gold');

### Create position table
CREATE TABLE IF NOT EXISTS Positions (
    position_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
) ENGINE = InnoDB;

INSERT INTO Positions (name)
VALUES 
('Personal Trainer'),
('Fitness Instructor'),
('Yoga Instructor'),
('Pilates Instructor'),
('Nutritionist');

### Create employees table
CREATE TABLE IF NOT EXISTS Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    gender ENUM('M', 'F', 'O') NOT NULL,
    date_of_birth DATE NOT NULL,
    hire_date DATE NOT NULL,
    position INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY fk_employees_position (position) REFERENCES Positions(position_id)
) ENGINE = InnoDB;

INSERT INTO Employees (name, email, phone, gender, date_of_birth, hire_date, position, salary)
VALUES 
('Emily Adams', 'emily.adams@example.com', '555-222-1234', 'F', '1988-04-10', '2020-01-15', 1, 45000),
('Oliver Clark', 'oliver.clark@example.com', '555-222-2345', 'M', '1990-11-21', '2019-06-01', 2, 40000),
('Sophia Turner', 'sophia.turner@example.com', '555-222-3456', 'F', '1985-08-30', '2018-03-20', 3, 50000),
('Liam Johnson', 'liam.johnson@example.com', '555-222-4567', 'M', '1992-01-25', '2021-07-01', 4, 48000),
('Isabella Anderson', 'isabella.anderson@example.com', '555-222-5678', 'F', '1987-12-15', '2019-10-01', 5, 47000);

### Create services table
CREATE TABLE IF NOT EXISTS Services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    price_per_session DECIMAL(10, 2) NOT NULL
) ENGINE = InnoDB;

INSERT INTO Services (name, description, price_per_session)
VALUES 
('Personal Training', 'One-on-one personal training sessions with a certified personal trainer.', 60),
('Group Fitness', 'Group fitness classes, including cardio, strength, and flexibility training.', 25),
('Yoga Class', 'Group yoga classes led by a certified yoga instructor.', 20),
('Pilates Class', 'Group Pilates classes led by a certified Pilates instructor.', 20),
('Nutrition Consultation', 'One-on-one nutrition consultation with a certified nutritionist.', 80);

### Create schedule table
CREATE TABLE IF NOT EXISTS Schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    service_id INT NOT NULL,
    employee_id INT NOT NULL,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    FOREIGN KEY fk_schedule_services (service_id) REFERENCES Services(service_id),
    FOREIGN KEY fk_schedule_employees (employee_id) REFERENCES Employees(employee_id)
) ENGINE = InnoDB;

INSERT INTO Schedule (service_id, employee_id, day_of_week, start_time, end_time)
VALUES 
(1, 1, 'Monday', '08:00:00', '09:00:00'),
(2, 2, 'Tuesday', '10:00:00', '11:00:00'),
(3, 3, 'Wednesday', '18:00:00', '19:00:00'),
(4, 4, 'Thursday', '16:00:00', '17:00:00'),
(5, 5, 'Friday', '14:00:00', '15:00:00');

### Create transaction table
CREATE TABLE IF NOT EXISTS Gym_transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    service_id INT NOT NULL,
    employee_id INT NOT NULL,
    transaction_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY fk_gym_transactions_customers (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY fk_gym_transactions_services (service_id) REFERENCES Services(service_id),
    FOREIGN KEY fk_gym_transactions_employees (employee_id) REFERENCES Employees(employee_id)
) ENGINE = InnoDB;

INSERT INTO Gym_transactions (customer_id, service_id, employee_id, transaction_date, amount)
VALUES 
(1, 1, 1, '2023-01-15', 60),
(2, 2, 2, '2023-02-12', 25),
(3, 3, 3, '2023-03-07', 20),
(4, 4, 4, '2023-01-18', 20),
(5, 5, 5, '2023-02-28', 80);

### Create payments table
CREATE TABLE IF NOT EXISTS Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY fk_payments_transactions (transaction_id) REFERENCES Gym_transactions(transaction_id)
) ENGINE = InnoDB;

INSERT INTO Payments (transaction_id, payment_date, amount)
VALUES 
(1, '2023-03-15', 60),
(2, '2023-03-17', 25),
(3, '2023-03-20', 20),
(4, '2023-03-22', 20),
(5, '2023-03-25', 80);

### Create membership table
CREATE TABLE IF NOT EXISTS Membership (
    membership_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('Active', 'Inactive', 'Expired', 'Cancelled') NOT NULL,
    FOREIGN KEY fk_membership_customers (customer_id) REFERENCES Customers(customer_id)
) ENGINE = InnoDB;

INSERT INTO Membership (customer_id, start_date, end_date, status)
VALUES 
(1, '2023-01-01', '2023-12-31', 'Active'),
(2, '2023-02-01', '2023-02-28', 'Expired'),
(3, '2023-01-15', '2023-07-14', 'Active'),
(4, '2023-03-01', '2023-03-31', 'Expired'),
(5, '2023-03-01', '2024-02-28', 'Active');

### Create invocies table
CREATE TABLE IF NOT EXISTS Invoices (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('Unpaid', 'Paid', 'Overdue', 'Cancelled') NOT NULL,
    FOREIGN KEY fk_invoices_customers (customer_id) REFERENCES Customers(customer_id)
) ENGINE = InnoDB;

INSERT INTO Invoices (customer_id, issue_date, due_date, total_amount, status)
VALUES 
(1, '2023-01-15', '2023-02-14', 60, 'Paid'),
(2, '2023-02-12', '2023-03-14', 25, 'Paid'),
(3, '2023-03-07', '2023-04-06', 20, 'Unpaid'),
(4, '2023-01-18', '2023-02-17', 20, 'Paid'),
(5, '2023-02-28', '2023-03-30', 80, 'Overdue');

### Create payment methods table
CREATE TABLE IF NOT EXISTS Payment_methods (
    payment_method_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
) ENGINE = InnoDB;

INSERT INTO Payment_methods (name)
VALUES 
('Credit Card'),
('Debit Card'),
('Cash'),
('Bank Transfer'),
('Mobile Payment');


ALTER TABLE Payments
ADD COLUMN payment_method_id INT,
ADD FOREIGN KEY (payment_method_id) REFERENCES Payment_methods(payment_method_id);

### SP for make new transction, if successful, commit; if not, rollback.

DELIMITER //

CREATE PROCEDURE MakeNewTransaction(IN p_customer_id INT, IN p_service_id INT, IN p_employee_id INT, IN p_transaction_date DATE, IN p_amount DECIMAL(10,2))
BEGIN
  DECLARE error_occurred BOOLEAN DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
    SET error_occurred = TRUE;
  END;

  START TRANSACTION;

    INSERT INTO Gym_transactions (customer_id, service_id, employee_id, transaction_date, amount)
    VALUES (p_customer_id, p_service_id, p_employee_id, p_transaction_date, p_amount);

  IF error_occurred THEN
    ROLLBACK;
    SELECT 'An error occurred. Transaction rolled back.' AS ErrorMessage;
  ELSE
    COMMIT;
    SELECT 'Transaction successfully committed.' AS SuccessMessage;
  END IF;
END//

DELIMITER ;

