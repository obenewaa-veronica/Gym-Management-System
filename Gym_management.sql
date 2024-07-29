-- drop the existing database if it exists
drop database if exists gym_database;

-- create the new database
create database gym_database;

-- use the new database
use gym_database;

-- create the staff table
create table staff (
    staffID int primary key auto_increment,
    income decimal(10, 2) not null check (income >= 0),
    position varchar(255) not null,
    hire_date date not null,
    workers_name varchar(255) not null,
    contact_information varchar(255) not null unique,
    employment varchar(255) not null
);

-- create the inventory_table
create table inventory_table (
    inventoryID int primary key auto_increment,
    item_name varchar(255) not null,
    status varchar(255) not null,
    quantity int not null check (quantity >= 0),
    purchase_date date not null
);

-- create the gym_equipment_table
create table gym_equipment_table (
    inventoryID int,
    status varchar(255) not null,
    last_maintenance_date date not null,
    foreign key (inventoryID) references inventory_table(inventoryID) on delete cascade on update cascade
);

-- create the class_schedules table
create table class_schedules (
    classID int primary key auto_increment,
    staffID int,
    programID int,
    class_name varchar(255) not null,
    day_of_week varchar(50) not null,
    start_time time not null,
    end_time time not null,
    foreign key (staffID) references staff(staffID) on delete set null on update cascade
);

-- create the training_programs table
create table training_programs (
    programID int primary key auto_increment,
    classID int,
    program_name varchar(255) not null,
    duration varchar(255) not null,
    description varchar(255) not null,
    foreign key (classID) references class_schedules(classID) on delete set null on update cascade
);

-- create the member table
create table members (
    memberID int primary key auto_increment,
    programID int,
    last_name varchar(255) not null,
    first_name varchar(255) not null,
    mtype_price decimal(10, 2) not null check (mtype_price >= 0),
    start_date date not null,
    end_date date not null,
    contact_information varchar(255) not null unique,
    membership_type varchar(255) not null,
    foreign key (programID) references training_programs(programID) on delete set null on update cascade
);


-- create the member_attendance table
create table member_attendance (
    attendanceID int primary key auto_increment,
    memberID int not null,
    arrival_time time not null,
    departure_time time not null,
    date date not null,
    foreign key (memberID) references members(memberID) on delete cascade on update cascade
);

-- create the member_damage_table
create table member_damage_table (
    damageID int primary key auto_increment,
    memberID int,
    inventoryID int,
    cost decimal(10, 2) not null check (cost >= 0),
    damage_type varchar(255) not null,
    damage_date date not null,
    foreign key (memberID) references members(memberID) on delete cascade on update cascade,
    foreign key (inventoryID) references inventory_table(inventoryID) on delete set null on update cascade
);

-- create the staff_attendance table
create table staff_attendance (
    attendanceID int primary key auto_increment,
    staffID int not null,
    arrival_time time not null,
    departure_time time not null,
    date date not null,
    foreign key (staffID) references staff(staffID) on delete cascade on update cascade
);

-- create the staff_feedback table
create table staff_feedback (
    feedbackID int primary key auto_increment,
    staffID int not null,
    feedback text not null,
    date date not null,
    foreign key (staffID) references staff(staffID) on delete cascade on update cascade
);

-- create the staff_damage_table
create table staff_damage_table (
    damageID int primary key auto_increment,
    staffID int ,
    inventoryID int,
    damage_type varchar(255) not null,
    cost decimal(10, 2) not null check (cost >= 0),
    damage_date date not null,
    foreign key (staffID) references staff(staffID) on delete cascade on update cascade,
    foreign key (inventoryID) references inventory_table(inventoryID) on delete set null on update cascade
);

-- create the booking table
create table booking (
    bookingID int primary key auto_increment,
    memberID int not null,
    staffID int not null,
    booking_date date not null,
    duration varchar(255) not null,
    booking_time time not null,
    foreign key (memberID) references members(memberID) on delete cascade on update cascade,
    foreign key (staffID) references staff(staffID) on delete cascade on update cascade
);

-- create the visitor_table
create table visitor_table (
    visitorID int primary key auto_increment,
    programID int,
    visitor_name varchar(255) not null,
    purpose_of_visit varchar(255) not null,
    sign_in time not null,
    sign_out time not null,
    contact_information varchar(255) not null unique,
    foreign key (programID) references training_programs(programID) on delete set null on update cascade
);

-- create the member_feedback table
create table member_feedback (
    feedbackID int primary key auto_increment,
    memberID int not null,
    feedback text not null,
    date date not null,
    foreign key (memberID) references members(memberID) on delete cascade on update cascade
);

insert into staff (income, position, hire_date, workers_name, contact_information, employment) values
(3000.00, 'Trainer', '2023-01-15', 'Kwame Mensah', 'kwame.mensah@example.com', 'Full-time'),
(2500.00, 'Receptionist', '2023-02-01', 'Akua Asante', 'akua.asante@example.com', 'Part-time'),
(3500.00, 'Manager', '2023-03-20', 'Kojo Owusu', 'kojo.owusu@example.com', 'Full-time'),
(2800.00, 'Cleaner', '2023-04-10', 'Adwoa Boateng', 'adwoa.boateng@example.com', 'Full-time'),
(3200.00, 'Assistant Trainer', '2023-05-05', 'Kofi Addo', 'kofi.addo@example.com', 'Part-time');


insert into inventory_table (item_name, status, quantity, purchase_date) values
('Treadmill', 'Good', 5, '2022-11-15'),
('Dumbbells', 'Good', 20, '2022-12-10'),
('Exercise Bike', 'Under Maintenance', 2, '2022-10-05'),
('Elliptical Machine', 'Good', 3, '2022-11-20'),
('Yoga Mats', 'Good', 15, '2022-12-15');

insert into class_schedules (staffID, programID, class_name, day_of_week, start_time, end_time) values
(1, NULL, 'Yoga', 'Monday', '09:00:00', '10:00:00'),
(1, NULL, 'Pilates', 'Wednesday', '10:00:00', '11:00:00'),
(2, NULL, 'Spinning', 'Friday', '08:00:00', '09:00:00'),
(3, NULL, 'Cardio', 'Tuesday', '07:00:00', '08:00:00'),
(4, NULL, 'Zumba', 'Thursday', '17:00:00', '18:00:00');


insert into members (programID, last_name, first_name, mtype_price, start_date, end_date, contact_information, membership_type) values
(NULL, 'Amankwah', 'Kwasi', 50.00, '2023-04-01', '2023-09-30', 'kwasi.amankwah@example.com', 'Monthly'),
(NULL, 'Boateng', 'Ama', 150.00, '2023-03-01', '2023-03-31', 'ama.boateng@example.com', 'Annual'),
(NULL, 'Adjei', 'Kofi', 75.00, '2023-05-01', '2023-10-31', 'kofi.adjei@example.com', 'Semi-Annual'),
(NULL, 'Boadu', 'Esi', 100.00, '2023-06-01', '2023-12-01', 'esi.boadu@example.com', 'Quarterly'),
(NULL, 'Darko', 'Kwaku', 60.00, '2023-07-01', '2023-12-31', 'kwaku.darko@example.com', 'Monthly');


insert into training_programs (classID, program_name, duration, description) values
(1, 'Weight Loss Program', '3 Months', 'A program focused on weight loss.'),
(2, 'Strength Training', '6 Months', 'A program focused on building strength.'),
(3, 'Cardio Fitness', '1 Month', 'A program focused on improving cardio fitness.'),
(4, 'Flexibility Training', '2 Months', 'A program to enhance flexibility.'),
(5, 'Endurance Program', '4 Months', 'A program to build endurance.');


insert into member_attendance (memberID, arrival_time, departure_time, date) values
(1, '08:00:00', '09:00:00', '2023-06-01'),
(2, '10:00:00', '11:00:00', '2023-06-02'),
(3, '09:00:00', '10:00:00', '2023-06-03'),
(4, '07:00:00', '08:00:00', '2023-06-04'),
(5, '09:30:00', '10:30:00', '2023-06-05'),
(2, '10:00:00', '11:00:00', '2023-06-07');


insert into gym_equipment_table (inventoryID, status, last_maintenance_date) values
(1, 'Good', '2023-01-01'),
(2, 'Good', '2023-01-01'),
(3, 'Under Maintenance', '2023-02-10'),
(4, 'Good', '2023-03-01'),
(5, 'Good', '2023-04-01'),
(1, 'Needs Replacement', '2023-05-01'),
(2, 'Good', '2023-06-01'),
(3, 'Under Maintenance', '2023-07-01'),
(4, 'Good', '2023-08-01'),
(5, 'Good', '2023-09-01');

insert into member_damage_table (memberID, inventoryID, cost, damage_type, damage_date) values
(1, 1, 100.00, 'Broken Screen', '2023-05-01'),
(2, 2, 50.00, 'Loose Handle', '2023-05-02'),
(3, 3, 200.00, 'Mechanical Issue', '2023-05-03'),
(4, 4, 75.00, 'Frayed Wires', '2023-06-01'),
(5, 5, 30.00, 'Scratched Surface', '2023-06-02'),
(1, 1, 120.00, 'Belt Tear', '2023-07-01'),
(2, 2, 60.00, 'Bent Frame', '2023-07-02'),
(3, 3, 220.00, 'Engine Problem', '2023-07-03'),
(4, 4, 80.00, 'Broken Pedal', '2023-08-01'),
(5, 5, 40.00, 'Cracked Display', '2023-08-02');

insert into staff_damage_table (staffID, inventoryID, damage_type, cost, damage_date) values
(1, 1, 'Torn Belt', 150.00, '2023-05-01'),
(2, 2, 'Broken Dumbbell', 75.00, '2023-05-02'),
(3, 3, 'Malfunctioning Bike', 250.00, '2023-05-03'),
(4, 4, 'Loose Nuts', 30.00, '2023-06-01'),
(5, 5, 'Worn Out Cushion', 45.00, '2023-06-02'),
(1, 1, 'Misaligned Display', 180.00, '2023-07-01'),
(2, 2, 'Rusty Parts', 85.00, '2023-07-02'),
(3, 3, 'Broken Pedal', 270.00, '2023-07-03'),
(4, 4, 'Damaged Frame', 100.00, '2023-08-01'),
(5, 5, 'Discolored Padding', 55.00, '2023-08-02');

-- Insert into training_programs (updating the classID to match the corresponding class schedules)
insert into training_programs (classID, program_name, duration, description) values
(1, 'Weight Loss Program', '3 Months', 'A program focused on weight loss.'),
(2, 'Strength Training', '6 Months', 'A program focused on building strength.'),
(3, 'Cardio Fitness', '1 Month', 'A program focused on improving cardio fitness.'),
(4, 'Flexibility Training', '2 Months', 'A program to enhance flexibility.'),
(5, 'Endurance Program', '4 Months', 'A program to build endurance.');

-- Insert into member_feedback
insert into member_feedback (memberID, feedback, date) values
(1, 'Great atmosphere, loved the yoga classes!', '2023-07-01'),
(2, 'The trainers are very knowledgeable!', '2023-07-02'),
(3, 'I enjoyed the strength training sessions.', '2023-07-03'),
(4, 'Very good facilities, but need more machines.', '2023-07-04'),
(5, 'The cardio classes are challenging but fun!', '2023-07-05');

-- Insert into staff_feedback
insert into staff_feedback (staffID, feedback, date) values
(1, 'Members are responsive and engaging during classes.', '2023-07-01'),
(2, 'The front desk has been very busy lately.', '2023-07-02'),
(3, 'The gym is maintaining good standards.', '2023-07-03'),
(4, 'Need more supplies for cleaning.', '2023-07-04'),
(5, 'The schedule is well organized.', '2023-07-05');

-- Insert into booking
insert into booking (memberID, staffID, booking_date, duration, booking_time) values
(1, 1, '2023-07-10', '1 hour', '10:00:00'),
(2, 2, '2023-07-11', '30 minutes', '11:00:00'),
(3, 3, '2023-07-12', '1 hour', '12:00:00'),
(4, 4, '2023-07-13', '45 minutes', '13:00:00'),
(5, 5, '2023-07-14', '1 hour', '14:00:00');

-- Insert into visitor_table
insert into visitor_table (programID, visitor_name, purpose_of_visit, sign_in, sign_out, contact_information) values
(1, 'John Doe', 'Inquiry about programs', '09:00:00', '10:00:00', 'john.doe@example.com'),
(2, 'Jane Smith', 'Tour of facilities', '10:30:00', '11:30:00', 'jane.smith@example.com'),
(3, 'Michael Brown', 'Joining a fitness class', '12:00:00', '13:00:00', 'michael.brown@example.com'),
(4, 'Sarah Johnson', 'Discuss personal training', '14:00:00', '15:00:00', 'sarah.johnson@example.com'),
(5, 'Emily Davis', 'Check out yoga class', '16:00:00', '17:00:00', 'emily.davis@example.com');




#The gym management system needs to display a tutor's daily schedule,
# including the number of bookings per class, and inform customers of 
#available slots to prevent double bookings.
Select
booking.booking_time, 
members.memberID, 
concat(members.first_name, ' ', members.last_name) AS Full_name,
staff.staffID AS tutorID,
staff.workers_name AS tutor_name,
class_schedules.class_name,
training_programs.program_name
From booking
Join members on booking.memberID = members.memberID
Join class_schedules on booking.staffID = class_schedules.staffID
Join staff on class_schedules.staffID = staff.staffID
Join training_programs on class_schedules.programID = training_programs.programID
Where booking.booking_date = booking_date; 




Select 
training_programs.program_name,
Count(booking.bookingID) As Total_bookings,
GROUP_CONCAT(concat(members.first_name, ' ', members.last_name, ' (', booking.booking_time, ')') ORDER BY members.first_name, members.last_name ASC) As members,
GROUP_CONCAT(staff.workers_name ORDER BY staff.workers_name ASC) AS tutors
From booking
Join members on booking.memberID = members.memberID
Join class_schedules on booking.staffID = class_schedules.staffID
Join training_programs on class_schedules.programID = training_programs.programID
Join staff on class_schedules.staffID = staff.staffID
GROUP BY training_programs.program_name;



#The gym needs a monthly report on equipment damage to track costs, 
# identify high-damage periods, and optimize maintenance.
Select 
    DATE_FORMAT(d.damage_date, '%Y-%m') As months, 
    i.item_name, 
    Count(d.damageID) As damage_count,
    Sum(d.cost) As total_cost
From inventory_table i
Join (
    Select 
        inventoryID, 
        damageID, 
        cost, 
        damage_date 
    From member_damage_table
    Union All
    Select 
        inventoryID, 
        damageID, 
        cost, 
        damage_date 
    From staff_damage_table
) d on i.inventoryID = d.inventoryID
GROUP BY months, i.item_name
ORDER BY months, damage_count DESC;


#The gym management wants to identify members with the highest attendance 
#to recognize active members and tailor rewards programs."
 Select
    m.memberID,
    m.first_name,
    m.last_name,
    COUNT(ma.date) As attendance_count
From 
    members m
Join 
    member_attendance ma on m.memberID = ma.memberID
Where 
    ma.date between '2023-01-01' and '2023-07-30' 
GROUP BY 
    m.memberID, m.first_name, m.last_name
ORDER BY 
    attendance_count DESC;
   
   
   
   
SELECT 
    i.item_name AS equipment_type,
    HOUR(ma.arrival_time) AS hour_of_day,
    COUNT(*) AS usage_count
FROM 
    inventory_table i
JOIN gym_equipment_table ge ON i.inventoryID = ge.inventoryID
JOIN member_attendance ma ON DATE(ma.date) = DATE(ge.last_maintenance_date)
GROUP BY 
    i.item_name, HOUR(ma.arrival_time)
ORDER BY 
    usage_count DESC, hour_of_day;

-- Query to get the most popular equipment types by day of the week
SELECT 
    i.item_name AS equipment_type,
    DAYNAME(ma.date) AS day_of_week,
    COUNT(*) AS usage_count
FROM 
    inventory_table i
JOIN gym_equipment_table ge ON i.inventoryID = ge.inventoryID
JOIN member_attendance ma ON DATE(ma.date) = DATE(ge.last_maintenance_date)
GROUP BY 
    i.item_name, DAYNAME(ma.date)
ORDER BY 
    usage_count DESC, day_of_week;


#The gym management aims to assess staff performance
# through class counts and feedback to evaluate engagement
# and pinpoint improvement areas
SELECT 
    s.workers_name,
    COUNT(DISTINCT cs.classID) AS classes_conducted,
    COUNT(DISTINCT sf.feedbackID) AS total_feedback_given
FROM 
    staff s
LEFT JOIN 
    class_schedules cs ON s.staffID = cs.staffID
LEFT JOIN 
    staff_feedback sf ON s.staffID = sf.staffID
GROUP BY 
    s.workers_name
ORDER BY 
    classes_conducted DESC;




