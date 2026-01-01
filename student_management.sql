-- Database creation
CREATE DATABASE student_management;
USE student_management;

-- Students table
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    department VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Courses table
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(50) NOT NULL UNIQUE,
    credits INT CHECK (credits BETWEEN 1 AND 5)
);

-- Enrollments table
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_student FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_course FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
        ON DELETE CASCADE,
    UNIQUE(student_id, course_id)
);

-- Insert students
INSERT INTO students (name, email, phone, department)
VALUES
('Ravi Kumar', 'ravi@gmail.com', '9876543210', 'CSE'),
('Anitha Sharma', 'anitha@gmail.com', '9876501234', 'ECE'),
('Suresh Patel', 'suresh@gmail.com', '9123456789', 'MECH');

-- Insert courses
INSERT INTO courses (course_name, credits)
VALUES
('Database Management', 4),
('Operating Systems', 3),
('Computer Networks', 3);

-- Enroll students
INSERT INTO enrollments (student_id, course_id)
VALUES
(1,1),
(1,2),
(2,1),
(3,3);

-- View students
SELECT * FROM students;

-- Student-course join
SELECT s.name, s.department, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;

-- Update student phone
UPDATE students
SET phone = '9999999999'
WHERE student_id = 1;

-- Delete student (cascade)
DELETE FROM students WHERE student_id = 3;

-- Students per course report
SELECT c.course_name, COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- Courses per student report
SELECT s.name, COUNT(e.course_id) AS total_courses
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id;

-- View creation
CREATE VIEW student_course_view AS
SELECT 
    s.student_id,
    s.name,
    s.department,
    c.course_name,
    c.credits
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;

SELECT * FROM student_course_view;

-- Stored procedure: add student
DELIMITER //
CREATE PROCEDURE add_student (
    IN s_name VARCHAR(50),
    IN s_email VARCHAR(100),
    IN s_phone VARCHAR(15),
    IN s_dept VARCHAR(50)
)
BEGIN
    INSERT INTO students(name, email, phone, department)
    VALUES (s_name, s_email, s_phone, s_dept);
END //
DELIMITER ;

CALL add_student('Priya', 'priya@gmail.com', '9012345678', 'CSE');

-- Stored procedure: get student courses
DELIMITER //
CREATE PROCEDURE get_student_courses (IN sid INT)
BEGIN
    SELECT s.name, c.course_name
    FROM students s
    JOIN enrollments e ON s.student_id = e.student_id
    JOIN courses c ON e.course_id = c.course_id
    WHERE s.student_id = sid;
END //
DELIMITER ;

-- Trigger: prevent deleting last student
DELIMITER //
CREATE TRIGGER prevent_empty_students
BEFORE DELETE ON students
FOR EACH ROW
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM students;
    IF total <= 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete last student record';
    END IF;
END //
DELIMITER ;

-- Index for performance
CREATE INDEX idx_student_email ON students(email);
