# RevTickets System - Complete Setup & Login Guide

## ✅ System Status

| Component | Status | Details |
|-----------|--------|---------|
| **Backend** | ✅ Running | Port 8081, Spring Boot |
| **Frontend** | ✅ Running | Port 4200, Angular |
| **Database** | ✅ Connected | MySQL, revticketsnew |
| **Auth System** | ✅ Working | JWT + Role-based |
| **Admin User** | ✅ Created | admin@revtickets.com |

---

## 🔑 Login Credentials

### Admin User
```
Email: admin@revtickets.com
Password: admin@123
Role: ADMIN
```

### Create Regular User
- Go to http://localhost:4200/auth/register
- Fill in registration form
- Account will be created with CUSTOMER role
- Use to test booking and payment flows

---

## 🚀 Quick Start

### Step 1: Access Frontend
Open browser: **http://localhost:4200**

### Step 2: Login as Admin
1. Click **"Login"** in navigation
2. Enter email: `admin@revtickets.com`
3. Enter password: `admin@123`
4. Click **"Login"**
5. Should redirect to **Admin Dashboard**

### Step 3: Verify Token
Open DevTools (F12) → Application → Local Storage
- Should see `token` key with JWT value
- Should see `currentUser` with admin details

### Step 4: Access Admin Features
From admin dashboard, you can:
- ➕ **Add Movies** - Upload with poster & banner
- ➕ **Add Events** - Create events with dates/times
- ➕ **Add Venues** - Set up theaters/venues
- ➕ **Add Shows** - Assign movies to venues
- 📊 **View Dashboard** - Stats & analytics
- 👥 **Manage Users** - View all users
- 📋 **View Bookings** - All system bookings

---

## 🧪 Testing Flows

### Test 1: Add Movie (Admin)
1. Login as admin
2. Go to "Movies" → "Add Movie"
3. Fill form:
   - Title: "Test Movie"
   - Description: "Test"
   - Genre: "ACTION"
   - Release Date: Today
   - Duration: 120 minutes
   - Poster Image: Upload JPG/PNG
   - Banner Image: Upload JPG/PNG
4. Click "Add Movie"
5. Should appear in movie list
6. **If 403 Error:** Check token role in DevTools console

### Test 2: Add Show (Admin)
1. Add at least 1 movie first
2. Add at least 1 venue first
3. Go to "Shows" → "Add Show"
4. Fill form:
   - Select Movie
   - Select Venue
   - Date & Time
   - Price
5. Click "Add Show"
6. Should appear in shows list

### Test 3: Book Ticket (Regular User)
1. Logout from admin
2. Register new account
3. Go to "Home" or "Movies"
4. Select a movie with shows
5. Click "Book Tickets"
6. Select seats
7. Click "Proceed to Payment"
8. Enter payment details (test card)
9. Should show booking confirmation

### Test 4: View Booking (Regular User)
1. After booking, go to "My Bookings"
2. Should see all your bookings
3. Click booking for details

---

## 🔐 Role-Based Access

### Admin Endpoints (ADMIN role only)
```
POST /api/admin/movies        - Create movie
PUT /api/admin/movies/{id}    - Edit movie
GET /api/admin/movies         - List movies
POST /api/admin/events        - Create event
PUT /api/admin/events/{id}    - Edit event
GET /api/admin/events         - List events
POST /api/admin/venues        - Create venue
PUT /api/admin/venues/{id}    - Edit venue
GET /api/admin/venues         - List venues
POST /api/admin/shows         - Create show
PUT /api/admin/shows/{id}     - Edit show
GET /api/admin/shows          - List shows
GET /api/admin/dashboard/*    - Admin dashboard
GET /api/admin/bookings       - All bookings
GET /api/admin/users          - All users
```

### User Endpoints (Any authenticated user)
```
POST /api/bookings            - Create booking
GET /api/bookings/my-bookings - My bookings
GET /api/bookings/{id}        - Booking details
POST /api/payments/create-order - Create payment order
POST /api/payments/verify     - Verify payment
```

### Public Endpoints (No auth needed)
```
GET /api/movies               - List movies
GET /api/movies/{id}          - Movie details
GET /api/events               - List events
GET /api/shows                - List shows
GET /api/shows/{id}           - Show details
GET /api/seats/show/{id}      - Available seats
GET /api/venues               - List venues
GET /api/banners              - Get banners
GET /api/reviews              - Get reviews
```

---

## 🐛 Troubleshooting

### Issue: 403 Forbidden on Admin Endpoints

**Problem:** Logged in but getting 403 on admin features

**Solutions:**

1. **Check User Role:**
   ```javascript
   // In browser console
   const user = JSON.parse(localStorage.getItem('currentUser'));
   console.log(user.role); // Should print "ADMIN"
   ```

2. **Check Token Contains Role:**
   ```javascript
   // In browser console
   const token = localStorage.getItem('token');
   const parts = token.split('.');
   const payload = JSON.parse(atob(parts[1]));
   console.log(payload); // Look for role claim
   ```

3. **Verify Backend Role Loading:**
   - Check MySQL: `SELECT role FROM users WHERE email = 'admin@revtickets.com';`
   - Should show `ADMIN`
   - If not: Run `admin_setup.sql` again

4. **Logout and Login Again:**
   - Token might be old from before role update
   - Click "Logout"
   - Clear browser cache
   - Login again

### Issue: Images Not Displaying

**Check File Paths:**
```javascript
// Network tab should show requests like:
// http://localhost:8081/display/movie-123.jpg
// http://localhost:8081/banner/banner-456.jpg
```

**Verify Backend Static Files:**
```bash
# Check if images were saved
dir backend\public\display\
dir backend\public\banner\
```

### Issue: Payment Shows 403

**Solution:**
1. Verify user is logged in (has valid token)
2. Token should contain `CUSTOMER` or `ADMIN` role
3. Check backend logs for JWT validation errors

### Issue: "Unauthorized" (401)

**Solution:**
1. Token missing from localStorage
2. Token expired (logout and login again)
3. Browser cleared localStorage

---

## 📝 Database Users

### Created Users
```sql
-- Admin
Email: admin@revtickets.com
Password: admin@123
Role: ADMIN

-- Create additional users by registering in UI
```

### Check Database
```bash
mysql -h localhost -u root -pabc@123 revtickets

-- View all users
SELECT user_id, email, full_name, role FROM users;

-- View bookings
SELECT * FROM bookings;

-- View seats
SELECT * FROM seats LIMIT 10;
```

---

## 🔧 Configuration Files

### Backend
- **Port:** 8081
- **Database:** MySQL (localhost:3306/revticketsnew)
- **Config:** `backend/src/main/resources/application.properties`
- **JWT Secret:** Configured in application.properties
- **JWT Expiration:** 24 hours

### Frontend
- **Port:** 4200
- **API URL:** http://localhost:8081/api
- **Config:** `frontend/src/environments/environment.ts`
- **Auth Interceptor:** `frontend/src/app/core/interceptors/auth.interceptor.ts`

---

## 📊 API Testing with Postman

### Import Collection
1. Use `RevTickets_Postman_Collection.json` in project root
2. Postman → Import → Select file
3. All endpoints pre-configured

### Test Admin Endpoint
1. Login first to get token
2. Copy token from response
3. Set in Postman:
   - Headers → Authorization
   - Value: `Bearer {token}`
4. Test admin endpoint

---

## 💾 Database Reset (If Needed)

```bash
# Connect to MySQL
mysql -h localhost -u root -pabc@123 revtickets

# Drop and recreate database
DROP DATABASE revticketsnew;
CREATE DATABASE revticketsnew;

# Exit MySQL and restart backend
# Backend will recreate tables via Hibernate
```

---

## 🚢 Deployment

### Docker
```bash
docker-compose up
```

### Manual Start
```bash
# Terminal 1 - Backend
cd backend
java -jar target/revtickets-1.0.0.jar

# Terminal 2 - Frontend
cd frontend
npm start
```

---

## ✨ Key Points

- ✅ Token is JWT with role claims
- ✅ Role "ADMIN_USER" becomes "ADMIN" in SecurityConfig
- ✅ Each request includes Authorization header
- ✅ Public endpoints work without login
- ✅ Admin endpoints check `hasRole("ADMIN")`
- ✅ Database stores role as ENUM (ADMIN/CUSTOMER)
- ✅ Admin user created via `admin_setup.sql`

---

## 📞 Quick Reference

| Item | Value |
|------|-------|
| Frontend URL | http://localhost:4200 |
| Backend URL | http://localhost:8081 |
| API Base | http://localhost:8081/api |
| Admin Email | admin@revtickets.com |
| Admin Password | admin@123 |
| DB User | root |
| DB Password | abc@123 |
| DB Name | revticketsnew |

