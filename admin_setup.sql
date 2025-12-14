INSERT INTO users (email, password, full_name, phone, role, is_active, created_at, updated_at) 
VALUES ('admin@revtickets.com', '$2a$10$K7PZ3H5LvNGsYMYxH8qd/eK2m2X2H4K5K7N2L9M3O4P5Q6R7S8T9U', 'Admin User', '9999999999', 'ADMIN', 1, NOW(), NOW()) 
ON DUPLICATE KEY UPDATE role = 'ADMIN';

SELECT user_id, email, full_name, role FROM users WHERE email = 'admin@revtickets.com';
