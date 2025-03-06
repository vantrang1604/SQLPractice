# SQLPractice
Project Title: Student Registration and Fee Management System

I. Overview

This project focuses on managing student registrations, unit drops, and fee adjustments in a database system. The main objectives include:

Implementing a trigger that processes unit drops by checking due dates and applying penalties.

Updating relevant tables (Fee, Registration, Unit) based on business rules.

Handling test cases for different student registration and fee scenarios.

II. Features

Trigger for Unit Drop

Fired after updating a row in the Registration table.

Determines penalties for unit drops:

$600 for Advanced units.

$400 for Non-Advanced units.

III. Updates:

Fee table: Adds penalty to fee_amount and changes status to 'Dropped Unit Penalty'.

Registration table: Updates status to 'dropped_with_penalty' and sets the drop date.

Unit table: Decrements unit enrollment count.

Error Handling

Raises errors if:

Drop occurs before the due date.

Student is not enrolled.

Uses NEW.Fee_amount != 'CHANGE' to ensure values are correctly updated even after errors.

Business Rules (BR)

Prevents students with outstanding balances from enrolling.

Restricts students failing more than 2 units from enrolling in Advanced units.

Ensures proper fee calculations for past dues and penalties.

IV. Test Cases

A series of test cases validate the system’s functionality, covering scenarios like:

Student with no outstanding balance.

Student with unpaid current fees.

Student with unpaid previous semester fees.

Student who paid all fees.

Student unable to enroll due to outstanding balances.

Failed attempts to enroll in Advanced units due to multiple unit failures.

Successful enrollments passing all business rules.

Penalty application for dropping Non-Advanced units.

Penalty application for dropping Advanced units.

No penalty for dropping before deadlines.

Error messages for invalid data entries.

Handling null registration dates.

V. Author

Student Name: Van Trang Nguyen

VI. License

This project is for educational purposes under COMP2350 and is not intended for commercial use.
