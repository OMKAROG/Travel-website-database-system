# Travel-website-database-system
# Tourism Management Database System (Jammu, Kashmir & Ladakh)

This project is a relational database system designed for a tourism and travel booking platform covering Jammu, Kashmir, and Ladakh regions.

## 📌 Overview
The system manages users, destinations, hotels, transport, tour packages, bookings, and payments in an integrated way. It is designed using MySQL with proper normalization and relational constraints.

## 🛠️ Technologies Used
- MySQL
- SQL (DDL & DML)

## 🧩 Database Features

### 👤 User Management
- Stores user details with roles (user/admin)
- Secure password storage using hash

### 🌍 Destinations
- Covers Jammu, Kashmir, Ladakh
- Includes geographic data (latitude, longitude)
- Seasonal information

### 🏨 Hotel System
- Hotels linked to destinations
- Room types and pricing structure
- Amenities support

### 🚗 Transport System
- Multiple transport types (Bus, Taxi, Helicopter, etc.)
- Route tracking with stops
- Distance-based pricing

### 📦 Tour Packages
- Multi-destination packages
- Pricing and inclusions

### 📅 Booking System
- Central booking table
- Supports:
  - Hotel bookings
  - Transport bookings
  - Package bookings

### 💳 Payments
- Multiple payment methods (UPI, Card, Netbanking, Cash)
- Transaction tracking

### ⭐ Reviews System
- Users can review:
  - Destinations
  - Hotels
  - Transport
  - Packages

### 🖼️ Media Support
- Image storage for different entities

---

## 🗄️ Database Schema

The database includes the following main tables:

- Users
- Destinations
- Hotels
- Rooms & Room Types
- Transport & Transport Stops
- Tour Packages
- Bookings
- Hotel Bookings
- Transport Bookings
- Payments
- Reviews
- Amenities
- Images

---

## 🔗 Relationships

- One user → many bookings
- One destination → many hotels
- One hotel → many rooms
- One booking → multiple services (hotel + transport)
- Many-to-many: packages ↔ destinations

---

## ▶️ How to Run

1. Open MySQL
2. Import the SQL file:

```sql
SOURCE tourism_system.sql;
