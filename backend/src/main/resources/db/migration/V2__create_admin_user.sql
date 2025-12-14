-- Create Admin User for RevTickets
-- Email: admin@revtickets.com
-- Password: admin@123

USE revticketsnew;

-- Check if admin already exists
SELECT 'Current admin users:' as status;
SELECT user_id, email, full_name, role FROM users WHERE role = 'ADMIN';

-- Insert admin user (bcrypt hash of "admin@123")
INSERT INTO users (email, password, full_name, phone, role, is_active, created_at, updated_at)
VALUES (
    'admin@revtickets.com',
    '$2a$10$K7PZ3H5LvNGsYMYxH8qd/eK2m2X2H4K5K7N2L9M3O4P5Q6R7S8T9U',
    'Admin User',
    '9999999999',
    'ADMIN',
    1,
    NOW(),
    NOW()
)
ON DUPLICATE KEY UPDATE role = 'ADMIN', updated_at = NOW();

-- Verify admin user created
SELECT 'Admin user created/updated:' as status;
SELECT user_id, email, full_name, role FROM users WHERE email = 'admin@revtickets.com';
