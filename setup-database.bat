@echo off
echo RevTickets Database Setup
echo ========================

echo.
echo Step 1: Testing MySQL Connection
echo ---------------------------------
mysql -u root -p -e "SELECT 'MySQL connection successful!' as status;"

if %errorlevel% neq 0 (
    echo ERROR: Could not connect to MySQL. Please check:
    echo 1. MySQL is running
    echo 2. Root password is correct
    echo 3. MySQL is installed properly
    pause
    exit /b 1
)

echo.
echo Step 2: Creating Database
echo -------------------------
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS revticketsnew;"
mysql -u root -p -e "SHOW DATABASES LIKE 'revticketsnew';"

echo.
echo Step 3: Update application.properties
echo -------------------------------------
echo Please update the password in backend/src/main/resources/application.properties
echo Change: spring.datasource.password=yourpassword
echo To:     spring.datasource.password=YOUR_ACTUAL_MYSQL_PASSWORD

echo.
echo Setup complete! You can now start the backend with: mvn spring-boot:run
pause