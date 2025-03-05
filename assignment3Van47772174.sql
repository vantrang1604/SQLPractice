-- use your unit code followed by your student ID number. 
-- For example, if you are enrolled in COMP2350, and your student ID number is 123456
-- then, replace XXX with COMP2350_123456
-- UnitCode: COMP2350
-- Assignment#: 3
-- StudentID Number: 47772174
-- Student Name: Van Trang Nguyen
-- Tutor's Name: Louie Coughill
-- Workshop Date/Time: Tuesday 09AM - 11AM
drop database if exists COMP2350_47772174;
create database COMP2350_47772174; 
use COMP2350_47772174;
-- Create table for storing student information
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    is_current ENUM('YES', 'NO') DEFAULT 'YES'
);

-- Create table for storing courses information
CREATE TABLE Unit (
    unit_code VARCHAR(15) PRIMARY KEY,
    unit_name VARCHAR(100),
    is_advanced ENUM('YES', 'NO') DEFAULT 'NO',
    enrollment INT DEFAULT 0,
    registration_date DATE
);

-- Create table for storing registrations (student-unit relationship)   
-- Update on 03/10/2024: added new column no_penlty_deadline. See ilearn announcement on 03/10/2024
-- Update on 07/10/2024: added new columns droped_out_date and status. 
CREATE TABLE Registration (
    student_id INT,
    unit_code VARCHAR(15),
    semester varchar(15),
    registration_date DATE,
    no_penalty_deadline DATE, 
    dropped_out_date DATE,
    status ENUM('active', 'dropped_with_penalty', 'dropped_without_penalty') DEFAULT 'active',  -- Newly added column
    PRIMARY KEY (student_id, unit_code, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (unit_code) REFERENCES Unit(unit_code)
);


-- Create table for storing student grades
-- Update on 07/10/2024: added new column status.
CREATE TABLE UnitGrade (
    student_id INT,
    unit_code VARCHAR(15),
    semester VARCHAR(15),
    marks DECIMAL(5, 2),
    status ENUM('active', 'dropped') DEFAULT 'active', 
    PRIMARY KEY (student_id, unit_code, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (unit_code) REFERENCES Unit(unit_code)
);

-- Create table for storing fee information
CREATE TABLE Fee (
    student_id INT,
    semester varchar(15),
    fee_amount DECIMAL(10, 2),
    status ENUM('paid', 'unpaid') DEFAULT 'unpaid',
    description VARCHAR(255),
    PRIMARY KEY (student_id, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);


-- Insert data into Student table
INSERT INTO Student (student_id, student_name, is_current) VALUES
(10001, 'Alice Smith', 'YES'),
(10002, 'Bob Johnson', 'YES'),
(10003, 'Charlie Brown', 'NO'),
(10004, 'David Wilson', 'YES'),
(10005, 'Emily Davis', 'NO'),
(10006, 'Frank Miller', 'YES'),
(10007, 'Grace Hall', 'YES'),
(10008, 'Hannah Lewis', 'YES'),
(10009, 'Ian Walker', 'NO'),
(10010, 'Julia Young', 'YES'),
(10011, 'Kevin Harris', 'YES'),
(10012, 'Lily Martin', 'YES'),
(10013, 'Mason White', 'NO'),
(10014, 'Nina Clark', 'YES'),
(10015, 'Oliver King', 'YES'),
(10016, 'Paul Scott', 'YES'),
(10017, 'Quinn Green', 'NO'),
(10018, 'Rachel Adams', 'YES'),
(10019, 'Samuel Turner', 'YES'),
(10020, 'Tina Baker', 'YES');

-- Insert data into Unit table
INSERT INTO Unit (unit_code, unit_name, is_advanced, enrollment, registration_date) VALUES
('IT101', 'Introduction to Programming', 'NO', 40, '2023-02-20'),
('IT102', 'Data Structures', 'NO', 35, '2023-02-20'),
('IT103', 'Database Systems', 'NO', 30, '2023-02-20'),
('IT401', 'Advanced Algorithms', 'YES', 20, '2023-02-20'),
('IT402', 'Machine Learning', 'YES', 25, '2023-02-20'),
('IT403', 'AI in Business', 'YES', 15, '2023-02-20'),
('IT404', 'Cybersecurity', 'YES', 18, '2023-02-20'),
('IT105', 'Operating Systems', 'NO', 30, '2023-02-20'),
('IT106', 'Web Development', 'NO', 28, '2023-02-20'),
('IT405', 'Cloud Computing', 'YES', 12, '2023-02-20');

-- Insert data into Registration table. 
-- Update on 07/10/2024: added data for new columns, droped_out_date and status. Also, updated no_penalty_deadline data
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) VALUES
(10001, 'IT101', '2023S1', '2023-01-15', '2023-02-12', NULL, 'active'), 
(10001, 'IT102', '2023S1', '2023-01-15', '2023-02-12', NULL, 'active'), 
(10002, 'IT103', '2023S1', '2023-01-16', '2023-02-13', NULL, 'active'), 
(10002, 'IT105', '2023S1', '2023-01-16', '2023-02-13', '2023-02-10', 'dropped_without_penalty'), 
(10003, 'IT101', '2023S1', '2023-01-17', '2023-02-12', '2023-02-15', 'dropped_with_penalty'), 
(10003, 'IT401', '2023S1', '2023-01-17', '2023-02-14', NULL, 'active'), 
(10004, 'IT402', '2023S1', '2023-01-18', '2023-02-15', NULL, 'active'), 
(10004, 'IT403', '2023S1', '2023-01-18', '2023-02-15', NULL, 'active'), 
(10005, 'IT404', '2023S1', '2023-01-19', '2023-02-16', NULL, 'active'), 
(10005, 'IT102', '2023S1', '2023-01-19', '2023-02-12', '2023-02-20', 'dropped_with_penalty'), 
(10006, 'IT401', '2023S2', '2023-06-10', '2023-07-08', NULL, 'active'), 
(10006, 'IT105', '2023S2', '2023-06-10', '2023-07-08', NULL, 'active'), 
(10007, 'IT402', '2023S2', '2023-06-11', '2023-07-09', NULL, 'active'), 
(10007, 'IT101', '2023S2', '2023-06-11', '2023-07-09', NULL, 'active'), 
(10008, 'IT403', '2023S2', '2023-06-12', '2023-07-10', NULL, 'active'), 
(10008, 'IT102', '2023S2', '2023-06-12', '2023-07-10', '2023-07-15', 'dropped_with_penalty'), 
(10009, 'IT404', '2023S2', '2023-06-13', '2023-07-11', NULL, 'active'), 
(10009, 'IT103', '2023S2', '2023-06-13', '2023-07-11', NULL, 'active'), 
(10010, 'IT401', '2023S2', '2023-06-14', '2023-07-08', NULL, 'active'), 
(10010, 'IT405', '2023S2', '2023-06-14', '2023-07-08', NULL, 'active'), 
(10011, 'IT101', '2024S1', '2024-01-10', '2024-02-10', NULL, 'active'), 
(10011, 'IT402', '2024S1', '2024-01-10', '2024-02-07', NULL, 'active'), 
(10012, 'IT403', '2024S1', '2024-01-11', '2024-02-11', '2024-02-10', 'dropped_with_penalty'), 
(10012, 'IT102', '2024S1', '2024-01-11', '2024-02-11', NULL, 'active'), 
(10013, 'IT105', '2024S1', '2024-01-12', '2024-02-09', NULL, 'active'), 
(10013, 'IT404', '2024S1', '2024-01-12', '2024-02-09', NULL, 'active'), 
(10014, 'IT101', '2024S1', '2024-01-13', '2024-02-10', '2024-02-12', 'dropped_with_penalty'), 
(10014, 'IT405', '2024S1', '2024-01-13', '2024-02-10', NULL, 'active'), 
(10015, 'IT102', '2024S1', '2024-01-14', '2024-02-11', '2024-02-01', 'dropped_without_penalty'), 
(10015, 'IT403', '2024S1', '2024-01-14', '2024-02-11', NULL, 'active'), 
(10016, 'IT401', '2024S1', '2024-01-15', '2024-02-07', NULL, 'active'), 
(10016, 'IT103', '2024S1', '2024-01-15', '2024-02-12', '2024-02-10', 'dropped_without_penalty'), 
(10017, 'IT102', '2024S2', '2024-06-01', '2024-06-29', NULL, 'active'), 
(10017, 'IT404', '2024S2', '2024-06-01', '2024-06-29', NULL, 'active'), 
(10018, 'IT101', '2024S2', '2024-06-02', '2024-06-30', NULL, 'active'), 
(10018, 'IT401', '2024S2', '2024-06-02', '2024-06-30', NULL, 'active'), 
(10019, 'IT105', '2024S2', '2024-06-03', '2024-07-01', NULL, 'active'), 
(10019, 'IT402', '2024S2', '2024-06-03', '2024-07-01', NULL, 'active'), 
(10020, 'IT403', '2024S2', '2024-06-04', '2024-07-02', NULL, 'active'), 
(10020, 'IT101', '2024S2', '2024-06-04', '2024-06-30', NULL, 'active');


-- Insert data into UnitGrade table with semester, marks, and status (active or dropped)
-- Update on 07/10/2024: added data for new column status and updated marks for dropped units
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status) VALUES
(10001, 'IT101', '2023S1', 75.00, 'active'),
(10001, 'IT102', '2023S1', 65.00, 'active'),
(10002, 'IT103', '2023S1', 85.50, 'active'),
(10002, 'IT105', '2023S1', NULL, 'dropped'),
(10003, 'IT101', '2023S1', NULL, 'dropped'),
(10003, 'IT401', '2023S1', NULL, 'dropped'),
(10004, 'IT402', '2023S1', 55.00, 'active'),
(10004, 'IT403', '2023S1', 92.00, 'active'),
(10005, 'IT404', '2023S1', 50.00, 'active'), 
(10005, 'IT102', '2023S1', NULL, 'dropped'),
(10006, 'IT401', '2023S2', 47.00, 'active'),  
(10006, 'IT105', '2023S2', 60.00, 'active'),
(10007, 'IT402', '2023S2', 88.00, 'active'),
(10007, 'IT101', '2023S2', 30.00, 'active'), 
(10008, 'IT403', '2023S2', 90.00, 'active'),
(10008, 'IT102', '2023S2', NULL, 'dropped'), 
(10009, 'IT404', '2023S2', 40.00, 'active'),
(10009, 'IT103', '2023S2', 55.00, 'active'),
(10010, 'IT401', '2023S2', 85.00, 'active'),
(10010, 'IT405', '2023S2', 32.00, 'active'), 
(10011, 'IT101', '2024S1', 75.00, 'active'),
(10011, 'IT402', '2024S1', 65.00, 'active'),
(10012, 'IT403', '2024S1', NULL, 'dropped'), 
(10012, 'IT102', '2024S1', 70.00, 'active'),
(10013, 'IT105', '2024S1', 85.00, 'active'),
(10013, 'IT404', '2024S1', 48.00, 'active'),
(10014, 'IT101', '2024S1', NULL, 'dropped'), 
(10014, 'IT405', '2024S1', 88.00, 'active'),
(10015, 'IT102', '2024S1', NULL, 'dropped'), 
(10015, 'IT403', '2024S1', 90.00, 'active'),
(10016, 'IT401', '2024S1', 75.00, 'active'),
(10016, 'IT103', '2024S1', NULL, 'dropped'),  
(10017, 'IT102', '2024S2', 70.00, 'active'),
(10017, 'IT404', '2024S2', 68.00, 'active'),
(10018, 'IT101', '2024S2', 60.00, 'active'),
(10018, 'IT401', '2024S2', 80.00, 'active'),
(10019, 'IT105', '2024S2', 82.00, 'active'),
(10019, 'IT402', '2024S2', 90.00, 'active'),
(10020, 'IT403', '2024S2', 94.00, 'active'),
(10020, 'IT101', '2024S2', 78.00, 'active');


-- Insert data into Fee table
-- Update on 07/10/2024: updated data for fee_amount column 
INSERT INTO Fee (student_id, semester, fee_amount, status, description) VALUES
(10001, '2023S1', 6500.00, 'PAID', 'Tuition Fee'),
(10001, '2023S2', 7500.00, 'UNPAID', 'Tuition Fee'),
(10002, '2023S1', 8500.00, 'PAID', 'Tuition Fee'),
(10002, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10003, '2023S1', 7500.00, 'UNPAID', 'Tuition Fee'),
(10003, '2023S2', 7500.00, 'UNPAID', 'Tuition Fee'),
(10004, '2023S1', 8500.00, 'PAID', 'Tuition Fee'),
(10004, '2023S2', 7500.00, 'PAID', 'Tuition Fee'),
(10005, '2023S1', 6500.00, 'UNPAID', 'Tuition Fee'),
(10005, '2023S2', 6500.00, 'PAID', 'Late Unit Enrollment Fee'),
(10006, '2023S2', 7500.00, 'PAID', 'Tuition Fee'),
(10006, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10007, '2023S2', 7500.00, 'UNPAID', 'Tution Fee'),
(10007, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10008, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10008, '2024S1', 8500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10009, '2023S2', 6500.00, 'UNPAID', 'Tuition Fee'),
(10009, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10010, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10010, '2024S1', 8500.00, 'PAID', 'Tuition Fee'),
(10011, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10011, '2024S2', 7500.00, 'UNPAID', 'Tution Fee'),
(10012, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10012, '2024S2', 6500.00, 'PAID', 'Tuition Fee'),
(10013, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10013, '2024S2', 7500.00, 'UNPAID', 'Late Unit Enrollment Fee'),
(10014, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10014, '2024S2', 8500.00, 'PAID', 'Dropped Unit Penalty'),
(10015, '2024S1', 7500.00, 'UNPAID', 'Tuition Fee'),
(10015, '2024S2', 6500.00, 'UNPAID', 'Tution Fee'),
(10016, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10016, '2024S2', 7500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10017, '2024S2', 7500.00, 'PAID', 'Tuition Fee'),
(10017, '2023S2', 6500.00, 'UNPAID', 'Late Unit Enrollment Fee'),
(10018, '2024S2', 7500.00, 'PAID', 'Tuition Fee'),
(10018, '2023S2', 6500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10019, '2024S2', 8500.00, 'PAID', 'Tuition Fee'),
(10019, '2023S2', 7500.00, 'PAID', 'Tution Fee'),
(10020, '2024S2', 7500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10020, '2023S2', 8500.00, 'PAID', 'Tuition Fee');

-- Task 5:
-- Insert into Student table:
INSERT INTO Student (student_id, student_name, is_current) VALUES
(10100, 'Daniel Nguyen', 'YES'),
(10101, 'Vanessa Nguyen', 'YES'),
(10102, 'Natalie Tran', 'NO'),
(10103, 'Jenny Hoang', 'NO'),
(10104, 'Hanny Ha', 'YES'),
(10105, 'Amelia Ng', 'YES'),
(10106, 'Emily Geng', 'YES'),
(10107, 'Jane Huynh', 'NO');
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status) VALUES
(10100, 'IT101', '2023S1', 35.00, 'active'),
(10100, 'IT102', '2024S1', 45.00, 'active'),
(10100, 'IT103', '2024S2', 33.50, 'active'),
(10101, 'IT103', '2024S2', 95.50, 'active'),
(10102, 'IT102', '2024S1', 93.50, 'active'),
(10102, 'IT101', '2023S1', NULL, 'dropped'),
(10103, 'IT103', '2023S1', 56.00, 'active'),
(10103, 'IT102', '2024S1', 86.00, 'active'),
(10104, 'IT401', '2024S2', NULL, 'dropped'),
(10104, 'IT102', '2024S1', 84.00, 'active'),
(10105, 'IT401', '2022S2', 44.00, 'active'),
(10106, 'IT102', '2024S1', null, 'active'),
(10107, 'IT106', '2023S2', 96.00, 'active');
INSERT INTO Fee (student_id, semester, fee_amount, status, description) VALUES
(10100, '2023S1', 3000.00, 'PAID', 'Tuition Fee'),
(10100, '2024S1', 3000.00, 'PAID', 'Tuition Fee'),
(10100, '2024S2', 3500.00, 'PAID', 'Late Unit Enrolment Fee'),
(10101, '2024S2', 3000.00, 'UNPAID', 'Tuition Fee'),
(10102, '2024S1', 3000.00, 'UNPAID', 'Late Unit Enrollment Fee'),
(10102, '2023S1', 3400.00, 'PAID', 'Dropped Unit Penalty'),
(10103, '2023S1', 3000.00, 'UNPAID', 'Tuition Fee'),
(10103, '2024S1', 3000.00, 'UNPAID', 'Tuition Fee'),
(10104, '2024S2', 4000.00, 'PAID', 'Tuition Fee'),
(10104, '2024S1', 3000.00, 'UNPAID', 'Tuition Fee'),
(10105, '2022S2', 4000.00, 'UNPAID', 'Tuition Fee'),
(10106, '2024S1', 3000.00, 'UNPAID', 'Tuition Fee'),
(10107, '2023S2', 3000.00, 'PAID', 'Tuition Fee');
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) VALUES
(10100,'IT101','2023S1','2023-01-10','2023-02-09',NULL,'active'),
(10100,'IT102','2024S1','2024-01-10','2024-02-09',NULL,'active'),
(10100,'IT103','2024S2','2024-06-11','2024-07-11',NULL,'active'),
(10101,'IT103','2024S2','2024-06-12','2024-07-12',NULL,'active'),
(10102,'IT102','2024S1','2024-01-10','2024-02-09',NULL,'active'),
(10102,'IT101','2023S1','2023-01-10','2023-02-09','2023-02-12','dropped_with_penalty'),
(10103,'IT103','2023S1','2023-01-10','2024-02-09',NULL,'active'),
(10103,'IT102','2024S1','2024-01-10','2024-02-09',NULL,'active'),
(10104,'IT401','2024S2','2024-06-10','2024-07-10','2024-07-04','dropped_without_penalty'),
(10104,'IT102','2024S1','2024-01-10','2024-02-09',NULL,'active'),
(10105,'IT401','2022S2','2022-06-10','2022-07-10',NULL,'active'),
(10106,'IT102','2024S1','2024-01-13','2024-02-12', NULL, 'active'),
(10107,'IT106','2023S2', '2023-06-11', '2023-07-11', NULL, 'active');

drop function if exists TotalFee;
-- Task 2
DELIMITER //
CREATE function TotalFee(stuid int)
returns numeric
deterministic
 BEGIN 
	declare total numeric default 0;
	declare stuExists text default "FALSE";
	-- Check whether the student exists in the database or not
    SELECT DISTINCT student_id 
    into stuExists
	from Fee f 
	where stuid = f.student_id;
    -- If the student exist, sum all the fee where status is 'UNPAID'
	if stuExists != "FALSE" then 
		select sum(fee_amount) into total
		from Fee f
		where f.student_id = stuid
        and status = 'UNPAID'
        group by (student_id);
		return total;
    else 
		-- If student doesn't exist, return 0
		return 0;
        end if;
END //
DELIMITER ;

-- TASK 3 
drop procedure if exists BRules;
DELIMITER //
CREATE PROCEDURE BRules (
    IN stuID INT(10),
    IN unitID VARCHAR(15),
    IN registrationDate DATE,
    IN isAdvancedLevel ENUM('YES', 'NO'),
    IN dropDate DATE,
    IN sem VARCHAR(10),
    IN feeamount INT,
    IN action ENUM ('ENROL','DROP'))
BEGIN 
    DECLARE failedunits INT DEFAULT 0;
    DECLARE advanced_units INT DEFAULT 0;
    DECLARE penalty_units INT DEFAULT 0;
    DECLARE DueDate DATE;
    DECLARE dropPenalty DECIMAL(10, 2) DEFAULT 0;
    DECLARE descrip1 varchar (100) DEFAULT 'Tuition Fee';
	DECLARE descrip2 varchar (100) DEFAULT 'active';
    DECLARE check_date DATE default null;
    DECLARE recordExists INT DEFAULT 0;
    SET DueDate = date_add(registrationDate,INTERVAL 30 DAY);
    -- Check whether the student has registered/ or trying to register
    IF registrationDate IS NULL 
    THEN 
    SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'An error since no registration date has been found';
    END IF;
    -- For enrolling students
	IF action = 'ENROL'
    THEN
    -- Enforce BR2 (Check whether they have any outstanding balance)
        IF TotalFee(stuID) > 0 THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This student cannot enroll in any unit due to outstanding fees';
        ELSE
	-- Enforce BR6 (Passed BR2 already, no outstanding balance has been found, check if they failed in more than two units
		-- Count number of failed units (Assumption: Failed is when marks < 50)
		SELECT COUNT(unit_code) INTO failedunits
		FROM UnitGrade u 
		WHERE u.student_id = stuID        
		AND (marks < 50.00);
        -- Check if the students can enrol in advanced unit
        IF (failedunits >= 2) AND (isAdvancedLevel = 'YES') THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This student cannot enroll in any advanced level';
		END IF;
		END IF;
		
        -- Change the number of students enrolling for the unit 
		UPDATE Unit 
        SET enrollment = enrollment + 1
        WHERE unit_code = unitID;
        
        -- Get new record for student
		INSERT INTO Fee (student_id, semester, fee_amount, status, description) 
        VALUES (stuID, sem, feeAmount, 'UNPAID', descrip1);
        
		INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, status)
        VALUES (stuID, unitID, sem, registrationDate, DueDate, descrip2);
		SELECT 'This student has successfully enrolled.' AS message;
        
	ELSE
    -- Validate the information passed, whether this registration already existed for dropping 
	SELECT COUNT(*) INTO recordExists
	FROM Registration
	WHERE student_id = stuID
	AND unit_code = unitID
	AND semester = sem;

-- If the record does not exist, raise an error
	IF recordExists = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'The registration record does not exist for the given student, unit, and semester';
	END IF;
    -- Enforce BR4
    -- Check the date to apply the penalty
    IF dropDate > DueDate THEN
        IF isAdvancedLevel = 'YES' THEN
            SET dropPenalty = 600.00;
        ELSE
            SET dropPenalty = 400.00;
        END IF;
        
        -- Automatically apply the penalty fee
        UPDATE Fee
        SET fee_amount = fee_amount + dropPenalty, status = 'UNPAID', description = 'Dropped Unit Penalty'
        where student_id = stuID
        and semester = sem;
        
        -- UPDATE the relevant table with drop date and status
        UPDATE Registration
        SET status = 'dropped_with_penalty', dropped_out_date = dropDate
        where student_id = stuID
        and unit_code = unitID
		and semester = sem;
        
        SELECT 'This student has dropped successfully but with penalty' as message;
	ELSE
		-- Update relevant table when successfully dropped
		UPDATE Registration
        SET status = 'dropped_without_penalty', dropped_out_date = dropDate
        where student_id = stuID
        and unit_code = unitID
		and semester = sem;
        SELECT 'This student has dropped successfully without penalty' as message;
	END IF;
    -- Change the number of students enrolling in the unit, since 1 already dropped
    UPDATE Unit 
    SET enrollment = enrollment - 1
    WHERE unit_code = unitID;
    END IF;
END //
DELIMITER ;


-- TEST CASE (data is already insert before implementing any function or procedure for task 5):
Select TotalFee(10105);
Select TotalFee(10103);
Select TotalFee(10104);
Select TotalFee(10107);
Call BRules (10102, 'IT404', '2024-09-12', 'YES', null, '2024S2', 4000.00, 'ENROL');
Call BRules (10100, 'IT405', '2024-09-15', 'YES', null, '2025S1', 4000.00, 'ENROL');
Call Brules (10101, 'IT103', '2024-10-23', 'NO', '2024-12-26', '2024S2', 3000.00, 'DROP');
Call BRules (10105, 'IT401', '2022-06-10', 'YES', '2022-07-18', '2022S2', 4000.00, 'DROP');
Call BRules (10106, 'IT102', '2024-01-10', 'NO', '2024-01-21', '2024S1', 3000.00, 'DROP');
Call BRules (10104, 'IT401', '2022-06-10', 'YES', '2022-07-18', '2022S2', 4000.00, 'DROP');
Call BRules (10102, 'IT405', null, 'YES', '2022-07-18', '2022S2', 4000.00, 'DROP');
Call BRules (10107,'IT404', '2025-01-12', 'YES', NULL, '2025S1', 4000.00, 'ENROL');

-- Used to validate different test cases, just change the condition for each corresponding cases.
Select distinct r.student_id, r.unit_code, r.semester, r.registration_date, r.status, r.no_penalty_deadline, r.dropped_out_date, f.description
From Registration r 
join Student s 
on s.student_id = r.student_id 
join Fee f 
on f.student_id = s.student_id
where r.student_id = 10107
and r.semester = '2025S1';







