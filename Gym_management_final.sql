-- Drop the existing database if it exists
drop database if exists gym_database;

-- Create the new database
create database gym_database;

-- Use the new database
use gym_database;

-- Create the staff table
create table staff (
    staffID varchar(255) primary key,
    income decimal(10, 2) not null check (income >= 0),
    position varchar(255) not null,
    hire_date date not null,
    workers_name varchar(255) not null,
    contact_information varchar(255) not null unique,
    employment varchar(255) not null
);

-- Create the inventory_table
create table inventory_table (
    inventoryID int primary key auto_increment,
    item_name varchar(255) not null,
    status varchar(255) not null,
    quantity int not null check (quantity >= 0),
    purchase_date date not null
);

-- Create the gym_equipment_table
create table gym_equipment_table (
    inventoryID int,
    status varchar(255) not null,
    last_maintenance_date date not null,
    foreign key (inventoryID) references inventory_table(inventoryID) on delete cascade on update cascade
);

-- Create the class_schedules table
create table class_schedules (
    classID varchar(255) primary key,
    staffID varchar(255),
    programID int,
    class_name varchar(255) not null,
    day_of_week varchar(50) not null,
    start_time time not null,
    end_time time not null,
    foreign key (staffID) references staff(staffID) on delete set null on update cascade
);

-- Create the training_programs table
create table training_programs (
    programID int primary key auto_increment,
    classID int,
    program_name varchar(255) not null,
    duration varchar(255) not null,
    description varchar(255) not null,
    foreign key (classID) references class_schedules(classID) on delete set null on update cascade
);

-- Create the members table
create table members (
    memberID varchar(255) primary key,
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

-- Create the attendance table
create table attendance (
    attendanceID int primary key auto_increment,
    personID varchar(255) not null,
    person_type varchar(50) not null check (person_type in ('member', 'staff','visitor')),
    arrival_time time not null,
    departure_time time not null,
    date date not null,
    foreign key (personID) references members(memberID) on delete cascade on update cascade,
    foreign key (personID) references staff(staffID) on delete cascade on update cascade,
    foreign key (personID) references visitor_table(visitorID) on delete cascade on update cascade
);

-- Create the damage table
create table damage (
    damageID int primary key auto_increment,
    personID varchar(255),
    person_type varchar(50) not null check (person_type in ('member', 'staff','visitor')),
    inventoryID int,
    damage_type varchar(255) not null,
    cost decimal(10, 2) not null check (cost >= 0),
    damage_date date not null,
    foreign key (personID) references members(memberID) on delete cascade on update cascade,
    foreign key (personID) references staff(staffID) on delete cascade on update cascade,
    foreign key (personID) references visitor_table(visitorID) on delete cascade on update cascade,
    foreign key (inventoryID) references inventory_table(inventoryID) on delete set null on update cascade
);

-- Create the feedback table
create table feedback (
    feedbackID int primary key auto_increment,
    personID varchar(255) not null,
    person_type varchar(50) not null check (person_type in ('member', 'staff','visitor')),
    feedback text not null,
    date date not null,
    foreign key (personID) references members(memberID) on delete cascade on update cascade,
    foreign key (personID) references visitor_table(visitorID) on delete cascade on update cascade,
    foreign key (personID) references staff(staffID) on delete cascade on update cascade
);

-- Create the booking table
create table booking (
    bookingID int primary key auto_increment,
    memberID varchar(255) not null,
    staffID varchar(255) not null,
    booking_date date not null,
    duration varchar(255) not null,
    booking_time time not null,
    foreign key (memberID) references members(memberID) on delete cascade on update cascade,
    foreign key (staffID) references staff(staffID) on delete cascade on update cascade
);

-- Create the visitor_table
create table visitor_table (
    visitorID int primary key auto_increment,
    visitor_name varchar(255) not null,
    purpose_of_visit varchar(255) not null,
    attendanceID int,
    contact_information varchar(255) not null unique,
	foreign key (attendanceID) references attendance(attendanceID) on delete cascade on update cascade,
);

-- Create the payment table
create table payment (
    paymentID int primary key auto_increment,
    personID varchar(255) not null,
    amount decimal(10, 2) not null check (amount >= 0),
    payment_date date not null,
    reason_for_payment varchar(255) not null,
    foreign key (personID) references members(memberID) on delete cascade on update cascade,
	foreign key (personID) references staff(staffID) on delete cascade on update cascade,
	foreign key (personID) references visitor_table(visitorID) on delete cascade on update cascade
);

-- Create the class_attendance table
create table class_attendance (
    class_attendanceID int primary key auto_increment,
    memberID varchar(255) not null,
    visitorID varchar(255) not null,
    classID varchar(255) not null,
    attendance_date date not null,
    foreign key (memberID) references members(memberID) on delete cascade on update cascade,
    foreign key (classID) references class_schedules(classID) on delete cascade on update cascade,
    foreign key (visitorID) references visitor_table(visitorID) on delete cascade on update cascade
);
