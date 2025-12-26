# RevTickets Troubleshooting Guide

## Current Issues Found and Solutions

### 1. Backend Not Starting - MySQL Authentication Error

**Error:** `Access denied for user 'root'@'localhost' (using password: NO)`

**Root Cause:** The MySQL password is empty in application.properties but MySQL requires authentication.

**Solution:**
1. Find your MySQL root password
2. Update `backend/src/main/resources/application.properties`:
   ```properties
   spring.datasource.password=YOUR_ACTUAL_MYSQL_PASSWORD
   ```

**To find/reset MySQL password:**
```bash
# Stop MySQL service
net stop mysql

# Start MySQL without password
mysqld --skip-grant-tables

# In another terminal, connect and reset password
mysql -u root
USE mysql;
UPDATE user SET authentication_string=PASSWORD('newpassword') WHERE User='root';
FLUSH PRIVILEGES;
exit;

# Restart MySQL normally
net start mysql
```

### 2. CORS Configuration

**Status:** ✅ CORS is properly configured in WebConfig.java

The backend already includes proper CORS configuration:
- Allows localhost:4200 (Angular dev server)
- Allows localhost:3000, localhost:5173 (other dev servers)
- Allows production IP: 13.127.100.123
- Supports all HTTP methods and headers

### 3. Frontend-Backend Integration

**Status:** ✅ Frontend is properly configured

The frontend environment files are correctly set:
- Development: `http://localhost:8081/api`
- Production: `/api` (relative URL)

## Step-by-Step Startup Process

### 1. Start MySQL
```bash
net start mysql
```

### 2. Verify Database Connection
```bash
mysql -u root -p
CREATE DATABASE IF NOT EXISTS revticketsnew;
exit;
```

### 3. Update Backend Configuration
Edit `backend/src/main/resources/application.properties`:
```properties
spring.datasource.password=YOUR_MYSQL_PASSWORD
```

### 4. Start Backend
```bash
cd backend
mvn spring-boot:run
```

**Expected output:** Server should start on port 8081 without errors

### 5. Start Frontend
```bash
cd frontend
npm install
ng serve
```

**Expected output:** Angular dev server on port 4200

## Verification Steps

### Backend Health Check
```bash
curl http://localhost:8081/api/health
```

### Frontend-Backend Connection Test
1. Open browser: http://localhost:4200
2. Check browser console for any CORS errors
3. Try to login/register to test API calls

## Common Issues and Solutions

### Issue: Port 8081 already in use
**Solution:** 
```bash
netstat -ano | findstr :8081
taskkill /PID <PID_NUMBER> /F
```

### Issue: MongoDB Connection Error
**Solution:** Start MongoDB service:
```bash
net start mongodb
```

### Issue: Redis Connection Error
**Solution:** Start Redis service or disable Redis in application.properties:
```properties
# Comment out Redis configuration
# spring.data.redis.host=localhost
```

### Issue: Frontend can't connect to backend
**Check:**
1. Backend is running on port 8081
2. No firewall blocking the connection
3. Environment.ts has correct API URL
4. CORS headers in browser network tab

## Database Schema Issues

If you encounter table/schema issues:

1. **Reset Database:**
   ```sql
   DROP DATABASE revticketsnew;
   CREATE DATABASE revticketsnew;
   ```

2. **Use provided SQL scripts:**
   ```bash
   mysql -u root -p revticketsnew < database_schema.sql
   ```

## Performance Optimization

### Backend
- Increase JVM heap size: `-Xmx2g -Xms1g`
- Enable connection pooling (already configured)

### Frontend
- Use production build: `ng build --prod`
- Enable gzip compression in nginx

## Monitoring and Logs

### Backend Logs
- Location: Console output or configure file logging
- Debug level: Set `logging.level.com.revature.revtickets=DEBUG`

### Frontend Logs
- Browser Developer Tools > Console
- Network tab for API call monitoring

## Contact Information

For additional support:
- Check application logs first
- Verify all services are running
- Test individual components separately