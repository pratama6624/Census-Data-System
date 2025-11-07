# Panduan Instalasi

## 1. Clone Project
```bash
git clone https://github.com/pratama6624/Census-Data-System.git
```

## 2. Install Dependensi
```bash
composer install
```

## 3. Konfigurasi File Environment (env)
```bash
cp env .env
```
```bash
app.baseURL = 'http://localhost:8080/'

database.default.hostname = localhost
database.default.database = census_data_system
database.default.username = root
database.default.password =
database.default.DBDriver = MySQLi

JWT_SECRET_KEY = 'secret key'
JWT_EXPIRE_DAYS = 5
```
_Note : Jika koneksi ke database gagal rubah hostname ke 127.0.0.1 (Case study on macOS)_

## 4. Setup Database
Buat nama database secara manual
```bash
CREATE DATABASE uts_sensus CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

## 5. Jalankan Database Migration & Seeder
Untuk mengisi data dummy secara otomatis
```bash
php spark migrate
php spark db:seed DatabaseSeeder
```

## 6. Jalankan Server
```bash
php spark serve
```

# DONE