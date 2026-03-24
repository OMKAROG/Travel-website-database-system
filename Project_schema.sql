CREATE DATABASE tourism_system_jkl;
USE tourism_system_jkl;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('user','admin') DEFAULT 'user',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE destinations (
    dest_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    region ENUM('Jammu','Kashmir','Ladakh') NOT NULL,
    description TEXT,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    best_season VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE hotels (
    hotel_id INT AUTO_INCREMENT PRIMARY KEY,
    dest_id INT NOT NULL,
    name VARCHAR(150) NOT NULL,
    address VARCHAR(255),
    rating DECIMAL(2,1),
    description TEXT,
    contact_phone VARCHAR(30),
    FOREIGN KEY (dest_id) REFERENCES destinations(dest_id) ON DELETE CASCADE
);

CREATE TABLE rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_id INT NOT NULL,
    room_type ENUM('Standard','Deluxe','Suite','Tent') NOT NULL,
    capacity INT NOT NULL,
    room_number VARCHAR(20),
    FOREIGN KEY (hotel_id, room_type, capacity)
        REFERENCES room_types(hotel_id, room_type, capacity)
        ON DELETE CASCADE
);

CREATE TABLE room_types (
    hotel_id INT NOT NULL,
    room_type ENUM('Standard','Deluxe','Suite','Tent') NOT NULL,
    capacity INT NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (hotel_id, room_type, capacity),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id) ON DELETE CASCADE
);


CREATE TABLE transport (
    transport_id INT AUTO_INCREMENT PRIMARY KEY,
    region ENUM('Jammu','Kashmir','Ladakh') NOT NULL,
    vehicle_type ENUM('Bus','Taxi','Jeep','Mini-Coach','Helicopter'),
    vehicle_no VARCHAR(50),
    start_dest_id INT,
    end_dest_id INT,
    departure_time DATETIME,
    arrival_time DATETIME,
    price_per_km DECIMAL(6,2),
    total_distance_km DECIMAL(8,2),
    available_seats INT,
    FOREIGN KEY (start_dest_id) REFERENCES destinations(dest_id),
    FOREIGN KEY (end_dest_id) REFERENCES destinations(dest_id)
);

CREATE TABLE transport_stops (
    stop_id INT PRIMARY KEY,
    transport_id INT NOT NULL,
    stop_order INT NOT NULL,
    dest_id INT NOT NULL,
    distance_from_start DECIMAL(8,2),
    arrival_time TIME,
    departure_time TIME,
    FOREIGN KEY (transport_id) REFERENCES transport(transport_id) ON DELETE CASCADE,
    FOREIGN KEY (dest_id) REFERENCES destinations(dest_id)
);

CREATE TABLE tour_packages (
    package_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    region ENUM('Jammu','Kashmir','Ladakh'),
    duration_days INT,
    price DECIMAL(12,2),
    description TEXT,
    inclusions TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE package_destinations (
    package_id INT,
    dest_id INT,
    PRIMARY KEY (package_id, dest_id),
    FOREIGN KEY (package_id) REFERENCES tour_packages(package_id) ON DELETE CASCADE,
    FOREIGN KEY (dest_id) REFERENCES destinations(dest_id) ON DELETE CASCADE
);

CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    package_id INT,
    total_amount DECIMAL(12,2),
    status ENUM('pending','confirmed','cancelled') DEFAULT 'pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (package_id) REFERENCES tour_packages(package_id)
);

CREATE TABLE hotel_bookings (
    hotel_booking_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    hotel_id INT NOT NULL,
    room_id INT,
    check_in DATE,
    check_out DATE,
    price DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

CREATE TABLE transport_bookings (
    transport_booking_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    transport_id INT NOT NULL,
    from_stop_id INT NOT NULL,
    to_stop_id INT NOT NULL,
    travel_date DATE,
    seat_no VARCHAR(10),
    calculated_fare DECIMAL(10,2),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (transport_id) REFERENCES transport(transport_id) ON DELETE CASCADE,
    FOREIGN KEY (from_stop_id) REFERENCES transport_stops(stop_id),
    FOREIGN KEY (to_stop_id) REFERENCES transport_stops(stop_id)
);

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    amount DECIMAL(12,2),
    method ENUM('card','netbanking','upi','cash'),
    status ENUM('initiated','success','failed') DEFAULT 'initiated',
    transaction_ref VARCHAR(150),
    paid_at DATETIME,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE
);

CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    entity ENUM('destination','hotel','transport','package'),
    entity_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE amenities (
    amenity_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE hotel_amenities (
    hotel_id INT NOT NULL,
    amenity_id INT NOT NULL,
    PRIMARY KEY (hotel_id, amenity_id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id) ON DELETE CASCADE,
    FOREIGN KEY (amenity_id) REFERENCES amenities(amenity_id) ON DELETE CASCADE
);

CREATE TABLE images (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    entity ENUM('destination','hotel','room','transport','package') NOT NULL,
    entity_id INT NOT NULL,
    url VARCHAR(500) NOT NULL,
    caption VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
