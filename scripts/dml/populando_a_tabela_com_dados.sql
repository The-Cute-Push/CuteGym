INSERT INTO [address] ([street], [location], [number], [reference], [city], [state], [country])
VALUES 
('123 Main St', 'Downtown', 101, 'Near Central Park', 'Vancouver', 'BC', 'Canada'),
('456 Elm St', 'Uptown', 202, 'Next to Library', 'Vancouver', 'BC', 'Canada'),
('789 Oak St', 'Suburbs', 303, 'Opposite Mall', 'Vancouver', 'BC', 'Canada'),
('321 Pine St', 'Midtown', 404, 'Beside Museum', 'Toronto', 'ON', 'Canada'),
('654 Maple St', 'Downtown', 505, 'Near City Hall', 'Toronto', 'ON', 'Canada'),
('987 Birch St', 'Eastside', 606, 'Close to School', 'Montreal', 'QC', 'Canada'),
('147 Cedar St', 'Westside', 707, 'Near Stadium', 'Calgary', 'AB', 'Canada'),
('258 Spruce St', 'Northside', 808, 'Behind Hospital', 'Ottawa', 'ON', 'Canada'),
('369 Fir St', 'Southside', 909, 'Near River', 'Edmonton', 'AB', 'Canada'),
('159 Ash St', 'Central', 111, 'Near Market', 'Winnipeg', 'MB', 'Canada');

INSERT INTO [phone] ([nr_phone])
VALUES 
('123-456-7890'),
('234-567-8901'),
('345-678-9012'),
('456-789-0123'),
('567-890-1234'),
('678-901-2345'),
('789-012-3456'),
('890-123-4567'),
('901-234-5678'),
('012-345-6789');

INSERT INTO [user_types] ([name], [description])
VALUES 
('Admin', 'Administrator with full access'),
('Instructor', 'Instructor with limited access'),
('Member', 'Regular member with basic access'),
('Receptionist', 'Handles front desk and scheduling'),
('Manager', 'Oversees operations'),
('Trainer', 'Personal training responsibilities'),
('Nutritionist', 'Provides dietary guidance'),
('Cleaner', 'Responsible for cleaning duties'),
('Technician', 'Maintains gym equipment'),
('Marketing', 'Handles promotional tasks');

INSERT INTO [users] ([nm_user], [email], [password_hash], [active], [dt_creation], [dt_birth], [specialty], [id_phone], [id_address], [id_user_type])
VALUES 
('John Doe', 'john.doe@example.com', 'hash1', 1, '2023-01-01', '1990-01-01', 'Yoga', 1, 1, 2),
('Jane Smith', 'jane.smith@example.com', 'hash2', 1, '2023-01-02', '1985-02-02', 'Pilates', 2, 2, 2),
('Alice Johnson', 'alice.johnson@example.com', 'hash3', 1, '2023-01-03', '1995-03-03', 'Cardio', 3, 3, 3),
('Bob Brown', 'bob.brown@example.com', 'hash4', 1, '2023-01-04', '1988-04-04', 'Weights', 4, 4, 2),
('Carol White', 'carol.white@example.com', 'hash5', 1, '2023-01-05', '1992-05-05', 'Stretching', 5, 5, 3),
('David Green', 'david.green@example.com', 'hash6', 1, '2023-01-06', '1983-06-06', 'Crossfit', 6, 6, 2),
('Eva Black', 'eva.black@example.com', 'hash7', 1, '2023-01-07', '1991-07-07', 'HIIT', 7, 7, 3),
('Frank Blue', 'frank.blue@example.com', 'hash8', 1, '2023-01-08', '1989-08-08', 'Spinning', 8, 8, 2),
('Grace Pink', 'grace.pink@example.com', 'hash9', 1, '2023-01-09', '1993-09-09', 'Zumba', 9, 9, 3),
('Henry Grey', 'henry.grey@example.com', 'hash10', 1, '2023-01-10', '1987-10-10', 'Boxing', 10, 10, 2);

INSERT INTO [modalities] ([name], [description])
VALUES 
('Yoga', 'A practice of physical, mental, and spiritual disciplines'),
('Pilates', 'A physical fitness system developed in the early 20th century'),
('Cardio', 'Exercises that increase heart rate and improve cardiovascular health'),
('Crossfit', 'High-intensity functional training'),
('HIIT', 'High-intensity interval training'),
('Zumba', 'Dance-based aerobic workout'),
('Spinning', 'Stationary cycling workouts'),
('Strength Training', 'Muscle building workouts'),
('Boxing', 'Combat sport and workout'),
('Stretching', 'Flexibility and muscle relaxation exercises');

INSERT INTO [plans] ([name], [description], [price], [duration_mnth])
VALUES 
('Basic Plan', 'Access to gym facilities and group classes', 50.00, 1),
('Premium Plan', 'Access to gym facilities, group classes, and personal training', 100.00, 1),
('Annual Plan', 'Access to gym facilities and group classes for a year', 500.00, 12),
('Student Plan', 'Discounted plan for students', 30.00, 1),
('Family Plan', 'Shared access for up to 4 family members', 180.00, 1),
('Senior Plan', 'Special rates for seniors', 40.00, 1),
('Weekend Plan', 'Gym access on weekends only', 25.00, 1),
('VIP Plan', 'All-inclusive access with perks', 200.00, 1),
('Trial Plan', '7-day free trial', 0.00, 1),
('Corporate Plan', 'Discounted plan for companies', 400.00, 12);

-- Certifique-se de n�o duplicar registros se j� executou antes
INSERT INTO [instructor_modalities] ([id_instructor], [id_modalities])
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO [plan_modalities] ([id_plan], [id_modalities])
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO [subscriptions] ([id_plan], [id_user], [active], [dt_start], [dt_end])
VALUES 
(1, 1, 1, '2023-01-01', NULL),
(2, 2, 1, '2023-01-02', NULL),
(3, 3, 1, '2023-01-03', '2025-03-15'),
(4, 4, 1, '2023-01-04', NULL),
(5, 5, 1, '2023-01-05', '2025-03-15'),
(6, 6, 1, '2023-01-06', NULL),
(7, 7, 1, '2023-01-07', '2024-04-05'),
(8, 8, 1, '2023-01-08', NULL),
(9, 9, 1, '2023-01-09', '2023-05-01'),
(10, 10, 1, '2023-01-10', NULL);

INSERT INTO [payment_method] ([name_method])
VALUES 
('Credit Card'),
('Debit Card'),
('PayPal'),
('PIX'),
('Cash'),
('Bank Transfer'),
('Crypto'),
('Google Pay'),
('Apple Pay'),
('Voucher');

INSERT INTO [payments] ([id_subscriptions], [dt_payment], [price], [id_method])
VALUES 
(1, '2023-01-01', 50.00, 1),
(2, '2023-01-02', 100.00, 2),
(3, '2023-01-03', 500.00, 3),
(4, '2023-01-04', 30.00, 4),
(5, '2023-01-05', 180.00, 5),
(6, '2023-01-06', 40.00, 6),
(7, '2023-01-07', 25.00, 7),
(8, '2023-01-08', 200.00, 8),
(9, '2023-01-09', 0.00, 9),
(10, '2023-01-10', 400.00, 10);

INSERT INTO [classes] ([id_modalities], [id_instructor], [dt_hour_class])
VALUES 
(1, 1, '2023-01-01 10:00:00'),
(2, 2, '2023-01-02 11:00:00'),
(3, 3, '2023-01-03 12:00:00'),
(4, 4, '2023-01-04 13:00:00'),
(5, 5, '2023-01-05 14:00:00'),
(6, 6, '2023-01-06 15:00:00'),
(7, 7, '2023-01-07 16:00:00'),
(8, 8, '2023-01-08 17:00:00'),
(9, 9, '2023-01-09 18:00:00'),
(10, 10, '2023-01-10 19:00:00');