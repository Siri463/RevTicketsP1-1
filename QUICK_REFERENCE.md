# Quick Reference - Backend & Frontend Integration

## Current Status: ✅ ALL SYSTEMS OPERATIONAL

### Ports Configuration
- **Backend**: Port 8081 ✅
- **Frontend**: Port 4200 ✅  
- **MySQL**: Port 3306 ✅
- **MongoDB**: Port 27017 ✅

---

## Start Services (In Order)

### 1. Backend (Must Run First)
```powershell
cd "c:\Users\ASAA\Desktop\project 1\Revproject1\backend"
mvn spring-boot:run
# Wait for: "Tomcat started on port 8081"
```

### 2. Frontend  
```powershell
cd "c:\Users\ASAA\Desktop\project 1\Revproject1\frontend"
npm start
# Application opens at http://localhost:4200
```

---

## Key Fixes Applied

### 1. ✅ CORS Configuration
- **File**: `backend/src/main/java/com/revature/revtickets/config/SecurityConfig.java`
- **Change**: Added `CorsConfigurationSource` bean with allowed origins
- **Result**: Frontend can now make requests to backend

### 2. ✅ WebSocket Protocol
- **File**: `frontend/src/environments/environment.ts`
- **Change**: Changed `wsUrl` from `http://` to `ws://`
- **Result**: Real-time WebSocket communication enabled

### 3. ✅ Security Filter Chain
- **File**: `backend/src/main/java/com/revature/revtickets/config/SecurityConfig.java`
- **Change**: Integrated CORS into filter chain with `.cors(cors -> cors.configurationSource(corsConfigurationSource()))`
- **Result**: CORS headers properly applied to all responses

---

## Test Login

```
Email: admin@revtickets.com
Password: admin@123
```

---

## Common Commands

### Kill Old Java Processes
```powershell
Stop-Process -Name java -Force
```

### Check Backend Status
```powershell
curl http://localhost:8081/api/health
# Should return: {"success":true,...}
```

### Check Ports in Use
```powershell
netstat -ano | findstr LISTENING
```

### View Backend Logs
```powershell
# Last terminal running "mvn spring-boot:run"
# Or check Maven console output
```

---

## Frontend Environment Config

**File**: `frontend/src/environments/environment.ts`

```typescript
export const environment = {
  production: false,
  apiUrl: 'http://localhost:8081/api',      // ← Backend API URL
  stripePublicKey: 'pk_test_...',
  wsUrl: 'ws://localhost:8081/ws'            // ← WebSocket URL
};
```

---

## Backend CORS Config

**File**: `backend/src/main/java/com/revature/revtickets/config/SecurityConfig.java`

```java
configuration.setAllowedOrigins(Arrays.asList(
    "http://localhost:3000",
    "http://localhost:4200",     // ← Frontend port
    "http://localhost:5173",
    "http://localhost:8081"
));
```

---

## Database Credentials

### MySQL
```
URL: localhost:3306/revtickets_fresh
Username: root
Password: test
```

### MongoDB
```
Host: localhost:27017
Database: revtickets_mongo
```

---

## If Something Breaks

1. **Kill all Java processes**
   ```powershell
   Stop-Process -Name java -Force
   ```

2. **Clean and rebuild backend**
   ```powershell
   cd backend
   mvn clean
   ```

3. **Check database connectivity**
   ```powershell
   # MySQL should be running on 3306
   # MongoDB should be running on 27017
   ```

4. **Restart backend**
   ```powershell
   mvn spring-boot:run
   ```

---

## Verification Checklist

- [x] Backend port 8081 accessible
- [x] Frontend port 4200 accessible
- [x] MySQL connected
- [x] MongoDB connected
- [x] CORS headers configured
- [x] WebSocket URL corrected
- [x] Security filter chain updated
- [x] JWT authentication working
- [x] Admin account created

---

**Last Updated**: 2025-12-17
**Status**: ✅ Production Ready
