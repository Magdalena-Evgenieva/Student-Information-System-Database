drop database if exists BD_studnet_database;
create database BD_studnet_database;
USE  BD_studnet_database;

CREATE TABLE PersonalData(
   id INT AUTO_INCREMENT PRIMARY KEY ,
	egn VARCHAR(10) NOT NULL UNIQUE ,
	address VARCHAR(255) NOT NULL ,
	phone VARCHAR(20) NULL DEFAULT NULL 
);

CREATE TABLE Faculty(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	name VARCHAR(255) NOT NULL 
);

CREATE TABLE Specialty(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	name VARCHAR(255) NOT NULL ,
    faculty_id INT NOT NULL ,
    CONSTRAINT FOREIGN KEY (faculty_id) 
		REFERENCES Faculty(id)
);


CREATE TABLE EduForm(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	name VARCHAR(255) NOT NULL ,
    isActive tinyint NOT NULL
);

CREATE TABLE SpecialtyEduForm(
	id INT AUTO_INCREMENT PRIMARY KEY ,
    specialty_id INT NOT NULL ,
    CONSTRAINT FOREIGN KEY (specialty_id) 
		REFERENCES Specialty(id),
    eduForm_id INT NOT NULL ,
    CONSTRAINT FOREIGN KEY (eduForm_id) 
		REFERENCES EduForm(id)
);

CREATE TABLE Teacher(
	id INT AUTO_INCREMENT PRIMARY KEY ,
    name VARCHAR(255) NOT NULL,
	acadPosition VARCHAR(255) NOT NULL ,
    scienceDegree VARCHAR(255) NOT NULL ,
    faculty_id INT NOT NULL ,
    CONSTRAINT FOREIGN KEY (faculty_id) 
		REFERENCES Faculty(id)
);

CREATE TABLE Descipline(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	name VARCHAR(255) NOT NULL ,
    practiceHours TIME ,
    lectureHours TIME ,
    dayOfPractice ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') ,
    dayOfLecture ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'),
    isOptional tinyint NOT NULL,
    teacher_id INT NOT NULL ,
    CONSTRAINT FOREIGN KEY (teacher_id) 
		REFERENCES Teacher(id),
         specialty_id INT NOT NULL ,
    CONSTRAINT FOREIGN KEY (specialty_id) 
		REFERENCES Specialty(id)
);

CREATE TABLE Student(
	id INT AUTO_INCREMENT PRIMARY KEY ,
    name  VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    faculty_number VARCHAR(10) NOT NULL UNIQUE,
    IsActive tinyint NOT NULL,
    semester INT CHECK (semester>=1 AND semester<=8) ,
    personalData_id INT NOT NULL ,
    CONSTRAINT FOREIGN KEY (personalData_id) 
		REFERENCES PersonalData(id),
     specialtyEduForm_id INT NOT NULL ,
    CONSTRAINT FOREIGN KEY (specialtyEduForm_id) 
		REFERENCES SpecialtyEduForm(id)
);

CREATE TABLE Grades(
	id INT AUTO_INCREMENT PRIMARY KEY ,
    student_id INT NOT NULL ,
	lastChange date,
	grade INT CHECK (grade>1 AND grade<=6) ,
    CONSTRAINT FOREIGN KEY (student_id) 
		REFERENCES Student(id),
    descipline_id INT NOT NULL ,
    CONSTRAINT FOREIGN KEY (descipline_id) 
		REFERENCES Descipline(id)
);

INSERT INTO PersonalData (egn, address, phone) 
VALUES 	('0001150045', 'Sofia-Mladost 1', '0893452120') ,
		('0510104512', 'Sofia-Liylin', '0894123456') ,
		('0005052154', 'Petrich', '0897852412') ,
		('0580104542', 'Burgas', '0894123457') ,
		('9510104547', 'Blagoevgrad', '0894123442') ,
		('9411104547', 'Varna', '0874526235');
        
INSERT INTO Faculty (name)
VALUES 	('FKST') ,
		('MTF') ,
        ('EF'),
        ('FET'),
		('FA');
        
INSERT INTO Specialty (name,faculty_id)
VALUES 	('ITI',1) ,
		('KSI',1) ,
        ('A',5),
        ('M',2),
		('IL',2);
        
INSERT INTO EduForm (name,isActive)
VALUES 	('regular learning',1) ,
		('distance learning',1),
        ('online learning',0);

INSERT INTO SpecialtyEduForm (specialty_id,eduForm_id)
VALUES 	(1,1),
		(1,2),
        (1,3),
        (2,1),
		(3,1),
        (3,2),
        (4,1),
		(5,1),
        (5,2);


INSERT INTO Teacher (name, acadPosition, scienceDegree,faculty_id) 
VALUES 	('Todor Petrov', 'lector', 'profesor',1),
		('Ivan Toshev', 'lector', 'profesor',1),
		('Maria Georgieva', 'lector', 'profesor',2),
		('Petur Ivanov', 'assistant', 'docent',3) ,
		('Karina Nakova', 'assistant', 'docent',4) ,
		('Iveta Grozdeva', 'assistant', 'docent',5);
        
INSERT INTO Descipline (name, practiceHours, lectureHours,dayOfPractice, dayOfLecture ,isOptional, teacher_id, specialty_id ) 
VALUES 	( 'Mathematic',NULL,'12:30:00',NULL,'Monday', 1, 1,5 ) ,
		('PIK', '09:30:00', '09:30:00', 'Monday', 'Wednesday', 1, 3,1 ) ,
		('DB', '09:30:00', '09:00:00','Wednesday','Friday',1, 2, 2) ,
		('Mechanic', '09:30:00', NULL,'Friday',NULL,1,6,2) ,
		('English', '09:30:00', '08:00:00','Friday','Wednesday',1,4,3);   
        
INSERT INTO student (name, password, faculty_number, IsActive,semester,personalData_id,specialtyEduForm_id) 
VALUES 	('Iliyan Ivanov','123pas', '9401150045', 1 , '1', 1 , 1) ,
		('Ivan Iliev Georgiev','1234', '9510104512', 1 , '4', 2 , 1) ,
		('Elena Petrova Petrova', '12345','9505052154', 1 , '5', 3 , 1 ) ,
		('Ivan Iliev Iliev', '12','9510104542', 1 , '7', 4 , 1 ) ,
		('Maria Hristova Dimova', '123456','9510104547', 1 , '5', 5 , 2 ) ,
		('Antoaneta Ivanova Georgieva','pass123', '9411104547', 1 , '1', 6 , 1 );
        
INSERT INTO Grades (descipline_id, student_id, lastChange, grade) 
VALUES 	(1,1,'	2020-1-11','5' ) ,
		(5, 2, '2020-1-11', '6' ) ,
		(3, 4, '2020-09-30','3') ,
		(2, 5, '2020-09-20','4'),
		(1, 3, '2021-1-13','2'),
        (2,1,'	2020-1-11','3' ) ,
		(4, 2, '2020-1-11', '4' ) ,
		(1, 4, '2020-09-30','4') ,
		(5, 5, '2020-09-20','2'),
		(3, 3, '2021-1-13','5'); 
        
 
SELECT DISTINCT teacher.name AS teacher_name , student.name as student_name
FROM Faculty
INNER JOIN Specialty ON Faculty.id= Specialty.faculty_id
INNER JOIN SpecialtyEduForm ON Specialty.id=SpecialtyEduForm.specialty_id
INNER JOIN student ON specialtyeduform.id=student.specialtyeduform_id
INNER JOIN teacher ON faculty.id=teacher.faculty_id;

SELECT DISTINCT Descipline.name,
Descipline.practiceHours,
Descipline.lectureHours,
Descipline.dayOfLecture,
descipline.dayOfPractice,
Descipline.isOptional,
Descipline.teacher_id,
teacher.name as teacher_name
FROM Descipline LEFT OUTER JOIN teacher
ON Descipline.teacher_id = teacher.id;

SELECT student.id, student.name AS student_name, grades.grade, AVG(grade)
 from student
 inner join grades on grades.student_id = student.id
 group by student.id
 ORDER by AVG(grade) DESC,student.name;
 
select student.id, student.name AS student_name, descipline.name, MAX(grades.grade) AS max_grade
from student
inner join grades ON grades.student_id=student.id
inner join descipline ON descipline.id=grades.descipline_id
group by student.name
order by MAX(grade) DESC, student.name, descipline.name;

 
 
        
        