# 🎓 Student Management System (MySQL)

## 📌 Project Overview
This project is a **pure MySQL-based Student Management System** designed to manage students, courses, and their enrollments.  
It demonstrates practical usage of **SQL fundamentals and advanced concepts** such as joins, constraints, views, stored procedures, triggers, and indexing.

This project is suitable for:
- SQL practice
- College mini-project
- Resume and interview discussion

---

## 🛠 Technologies Used
- **Database:** MySQL  
- **Language:** SQL  

---

## 🗂 Database Design

### 1️⃣ Students Table
Stores student information.
- student_id (Primary Key)
- name
- email (Unique)
- phone
- department
- created_at

---

### 2️⃣ Courses Table
Stores course details.
- course_id (Primary Key)
- course_name (Unique)
- credits (1–5)

---

### 3️⃣ Enrollments Table
Handles many-to-many relationship between students and courses.
- enrollment_id (Primary Key)
- student_id (Foreign Key)
- course_id (Foreign Key)
- enrollment_date

---

## 🔑 Features Implemented
- Normalized relational database design
- Primary and foreign key constraints
- Many-to-many relationship
- CRUD operations
- INNER JOIN and LEFT JOIN queries
- Aggregate functions and reports
- Views for simplified data access
- Stored procedures for reusable logic
- Triggers for data safety
- Indexing for performance optimization

---

## 📂 Project Structure
