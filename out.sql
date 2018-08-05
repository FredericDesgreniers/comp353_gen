

drop table Tasks;
drop table Regular;
drop table Manager;
drop table Contracts;
drop table SalesAssociate;
drop table Admins;
drop table Employees;
drop table Clients;

CREATE TABLE Clients(
  clientId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  clientName VARCHAR(255),
  repFirstName VARCHAR(255),
  repMiddleInital VARCHAR(5),
  repLastName VARCHAR(255),
  emailId VARCHAR(255),
  city VARCHAR(255),
  province VARCHAR(255),
  postalCode VARCHAR(255),
  password VARCHAR(20) NOT NULL
);

CREATE TABLE Employees (
  employeeId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  firstName VARCHAR(255) NOT NULL,
  lastName VARCHAR(255) NOT NULL,
  password varchar(20) NOT NULL
);

CREATE TABLE SalesAssociate (
  employeeId INT NOT NULL PRIMARY KEY REFERENCES Employees(employeeId)
);

CREATE TABLE Admins (
  employeeId INT NOT NULL PRIMARY KEY REFERENCES Employees(employeeId)
);

CREATE TABLE Contracts(
  contractId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  clientId INT NOT NULL,
  superviseBy INT NOT NULL,
  contactNumber VARCHAR(15) NOT NULL,
  annualContractValue DOUBLE NOT NULL,
  initalAmount DOUBLE NOT NULL,
  serviceStartDate DATE NOT NULL,
  serviceType ENUM('Cloud','On-premises') NOT NULL,
  contractType ENUM('Premium','Gold','Diamond','Silver') NOT NULL,
  lineOfBusiness ENUM('CloudServices', 'Development', 'Research') NOT NULL,
  satisfactionLevel INT CHECK (satisfactionLevel >=1 AND satisfactionLevel <=10),
  FOREIGN KEY (clientId) REFERENCES Clients(clientId),
  FOREIGN KEY (superviseBy) REFERENCES SalesAssociate(employeeId)
);

CREATE TABLE Manager (
  employeeId INT NOT NULL PRIMARY KEY REFERENCES Employees(employeeId),
	contractId INT NOT NULL,
  superviseBy INT NOT NULL,
	FOREIGN KEY (contractId) REFERENCES Contracts(contractId),
  FOREIGN KEY (superviseBy) REFERENCES SalesAssociate(employeeId)
);

CREATE TABLE Regular (
  employeeId INT NOT NULL PRIMARY KEY REFERENCES Employees(employeeId),
	contractId INT NOT NULL,
  manageBy INT NOT NULL,
	department ENUM('Development', 'QA', 'UI', 'Design', 'BusinessIntelligence', 'Networking') NOT NULL,
	insurance ENUM('Premium','Silver','Normal') NOT NULL,
  desiredContractType ENUM('Premium','Gold','Diamond','Silver') NOT NULL,
	FOREIGN KEY (contractId) REFERENCES Contracts(contractId),
  FOREIGN KEY (manageBy) REFERENCES Manager(employeeId)
);

CREATE TABLE Tasks(
  employeeId INT NOT NULL PRIMARY KEY REFERENCES Employees(employeeId),
  contractId INT NOT NULL,
  taskType ENUM('Set up infrastructure for client','Provisioning of resources','Assigning tasks to resources','Allocating a dedicated point of contact') NOT NULL,
  hours int default 0,
  FOREIGN KEY(contractId) REFERENCES Contracts(contractId),
  CHECK(hours >= 0)
);
INSERT INTO Employees VALUES(1, 'Alejandro', 'Vargas', 'pass');
INSERT INTO SalesAssociate VALUES(1);
INSERT INTO Clients VALUES (1, 'Etrade inc.', 'Kamren', '', 'Jackson', 'Kamren_Jackson@Etrade inc..com', 'Montreal', 'QC', 'xxxxxx', 'pass');
INSERT INTO Contracts VALUES (1, 1, 1, '5149108628', 0, 0, '2017-02-03', 'Cloud', 'Gold', 'CloudServices', 5);
INSERT INTO Employees VALUES(2, 'Celeste', 'Guerrero', 'other_pass');
INSERT INTO Manager VALUES (2, 1, 1);
INSERT INTO Employees VALUES(3, 'Lorelai', 'Schneider', 'pass');
INSERT INTO Regular VALUES (3, 1,2, 'UI', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (3, 1, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(4, 'Simone', 'Miller', 'pass');
INSERT INTO Regular VALUES (4, 1,2, 'Design', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (4, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(5, 'Jaelyn', 'Lopez', 'pass');
INSERT INTO Regular VALUES (5, 1,2, 'QA', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (5, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(6, 'Brooks', 'Shepard', 'pass');
INSERT INTO Regular VALUES (6, 1,2, 'UI', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (6, 1, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(7, 'Nikhil', 'Becker', 'pass');
INSERT INTO Regular VALUES (7, 1,2, 'Networking', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (7, 1, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(8, 'Kathleen', 'Melton', 'pass');
INSERT INTO Regular VALUES (8, 1,2, 'Development', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (8, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(9, 'Sarai', 'Hays', 'pass');
INSERT INTO Regular VALUES (9, 1,2, 'UI', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (9, 1, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(10, 'Meredith', 'Barber', 'other_pass');
INSERT INTO Manager VALUES (10, 1, 1);
INSERT INTO Employees VALUES(11, 'Wilson', 'Hancock', 'pass');
INSERT INTO Regular VALUES (11, 1,10, 'BusinessIntelligence', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (11, 1, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(12, 'Virginia', 'Franco', 'pass');
INSERT INTO Regular VALUES (12, 1,10, 'QA', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (12, 1, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(13, 'Tripp', 'Salinas', 'pass');
INSERT INTO Regular VALUES (13, 1,10, 'QA', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (13, 1, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(14, 'Kinsley', 'Logan', 'pass');
INSERT INTO Regular VALUES (14, 1,10, 'Networking', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (14, 1, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(15, 'Tabitha', 'Benjamin', 'pass');
INSERT INTO Regular VALUES (15, 1,10, 'BusinessIntelligence', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (15, 1, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(16, 'Santiago', 'Pace', 'pass');
INSERT INTO Regular VALUES (16, 1,10, 'Development', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (16, 1, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(17, 'Jerry', 'Estes', 'pass');
INSERT INTO Regular VALUES (17, 1,10, 'Networking', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (17, 1, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(18, 'Giancarlo', 'Randolph', 'other_pass');
INSERT INTO Manager VALUES (18, 1, 1);
INSERT INTO Employees VALUES(19, 'Kailee', 'Downs', 'pass');
INSERT INTO Regular VALUES (19, 1,18, 'Networking', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (19, 1, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(20, 'Joaquin', 'Le', 'pass');
INSERT INTO Regular VALUES (20, 1,18, 'Networking', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (20, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(21, 'Jaida', 'Watkins', 'pass');
INSERT INTO Regular VALUES (21, 1,18, 'Networking', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (21, 1, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(22, 'Jaylyn', 'Bridges', 'pass');
INSERT INTO Regular VALUES (22, 1,18, 'QA', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (22, 1, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(23, 'Yoselin', 'Best', 'pass');
INSERT INTO Regular VALUES (23, 1,18, 'QA', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (23, 1, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(24, 'Layla', 'Boyd', 'pass');
INSERT INTO Regular VALUES (24, 1,18, 'Development', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (24, 1, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(25, 'Mila', 'Whitney', 'pass');
INSERT INTO Regular VALUES (25, 1,18, 'Networking', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (25, 1, 'Set up infrastructure for client', 0);
INSERT INTO Contracts VALUES (2, 1, 1, '5149108628', 0, 0, '2015-10-09', 'On-premises', 'Premium', 'Research', 5);
INSERT INTO Employees VALUES(26, 'Heidy', 'Maldonado', 'other_pass');
INSERT INTO Manager VALUES (26, 2, 1);
INSERT INTO Employees VALUES(27, 'Robert', 'Villegas', 'pass');
INSERT INTO Regular VALUES (27, 2,26, 'Design', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (27, 2, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(28, 'Brodie', 'Hammond', 'pass');
INSERT INTO Regular VALUES (28, 2,26, 'UI', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (28, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(29, 'Emery', 'Rivas', 'pass');
INSERT INTO Regular VALUES (29, 2,26, 'Design', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (29, 2, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(30, 'Brianna', 'Dickson', 'pass');
INSERT INTO Regular VALUES (30, 2,26, 'Development', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (30, 2, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(31, 'Yosef', 'Rollins', 'pass');
INSERT INTO Regular VALUES (31, 2,26, 'QA', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (31, 2, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(32, 'Milagros', 'Lozano', 'pass');
INSERT INTO Regular VALUES (32, 2,26, 'QA', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (32, 2, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(33, 'Skylar', 'Griffith', 'pass');
INSERT INTO Regular VALUES (33, 2,26, 'Development', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (33, 2, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(34, 'Maximo', 'Hampton', 'other_pass');
INSERT INTO Manager VALUES (34, 2, 1);
INSERT INTO Employees VALUES(35, 'Luis', 'Benton', 'pass');
INSERT INTO Regular VALUES (35, 2,34, 'Development', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (35, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(36, 'Adrian', 'Carey', 'pass');
INSERT INTO Regular VALUES (36, 2,34, 'QA', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (36, 2, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(37, 'Micaela', 'Moreno', 'pass');
INSERT INTO Regular VALUES (37, 2,34, 'Design', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (37, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(38, 'Bailee', 'Carney', 'pass');
INSERT INTO Regular VALUES (38, 2,34, 'BusinessIntelligence', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (38, 2, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(39, 'Jabari', 'Mahoney', 'pass');
INSERT INTO Regular VALUES (39, 2,34, 'BusinessIntelligence', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (39, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(40, 'Nikolas', 'Ellison', 'other_pass');
INSERT INTO Manager VALUES (40, 2, 1);
INSERT INTO Employees VALUES(41, 'Allison', 'King', 'pass');
INSERT INTO Regular VALUES (41, 2,40, 'Networking', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (41, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(42, 'Jude', 'Ward', 'pass');
INSERT INTO Regular VALUES (42, 2,40, 'Networking', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (42, 2, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(43, 'Ryleigh', 'Riddle', 'pass');
INSERT INTO Regular VALUES (43, 2,40, 'Development', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (43, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(44, 'Kylan', 'Hinton', 'pass');
INSERT INTO Regular VALUES (44, 2,40, 'Design', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (44, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(45, 'Ansley', 'Clarke', 'pass');
INSERT INTO Regular VALUES (45, 2,40, 'BusinessIntelligence', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (45, 2, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(46, 'Yazmin', 'Murillo', 'pass');
INSERT INTO Regular VALUES (46, 2,40, 'Development', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (46, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(47, 'Eve', 'Gillespie', 'pass');
INSERT INTO Regular VALUES (47, 2,40, 'Development', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (47, 2, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(48, 'Jorge', 'Clay', 'pass');
INSERT INTO Regular VALUES (48, 2,40, 'BusinessIntelligence', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (48, 2, 'Set up infrastructure for client', 0);
INSERT INTO Clients VALUES (2, 'WeMakeWebsites', 'Brogan', '', 'Fuentes', 'Brogan_Fuentes@WeMakeWebsites.com', 'Montreal', 'QC', 'xxxxxx', 'pass');
INSERT INTO Contracts VALUES (3, 2, 1, '5149108628', 0, 0, '2017-00-02', 'On-premises', 'Silver', 'CloudServices', 5);
INSERT INTO Employees VALUES(49, 'Max', 'Grimes', 'other_pass');
INSERT INTO Manager VALUES (49, 3, 1);
INSERT INTO Employees VALUES(50, 'Nicolas', 'Sherman', 'pass');
INSERT INTO Regular VALUES (50, 3,49, 'Development', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (50, 3, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(51, 'Ariella', 'Ortiz', 'pass');
INSERT INTO Regular VALUES (51, 3,49, 'BusinessIntelligence', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (51, 3, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(52, 'Barbara', 'Solis', 'pass');
INSERT INTO Regular VALUES (52, 3,49, 'Networking', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (52, 3, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(53, 'Brynn', 'Benitez', 'pass');
INSERT INTO Regular VALUES (53, 3,49, 'QA', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (53, 3, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(54, 'Timothy', 'Holmes', 'pass');
INSERT INTO Regular VALUES (54, 3,49, 'Development', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (54, 3, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(55, 'Kyle', 'Mathis', 'pass');
INSERT INTO Regular VALUES (55, 3,49, 'Networking', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (55, 3, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(56, 'Carley', 'Flores', 'pass');
INSERT INTO Regular VALUES (56, 3,49, 'QA', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (56, 3, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(57, 'Cortez', 'Ponce', 'pass');
INSERT INTO Regular VALUES (57, 3,49, 'Design', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (57, 3, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(58, 'Jasmine', 'Jones', 'other_pass');
INSERT INTO Manager VALUES (58, 3, 1);
INSERT INTO Employees VALUES(59, 'Neveah', 'Davenport', 'pass');
INSERT INTO Regular VALUES (59, 3,58, 'Development', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (59, 3, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(60, 'Tucker', 'Pena', 'pass');
INSERT INTO Regular VALUES (60, 3,58, 'Networking', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (60, 3, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(61, 'Ann', 'Curry', 'pass');
INSERT INTO Regular VALUES (61, 3,58, 'Design', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (61, 3, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(62, 'Jillian', 'Shepherd', 'pass');
INSERT INTO Regular VALUES (62, 3,58, 'Networking', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (62, 3, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(63, 'Conner', 'Bennett', 'pass');
INSERT INTO Regular VALUES (63, 3,58, 'Networking', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (63, 3, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(64, 'Londyn', 'Harrell', 'pass');
INSERT INTO SalesAssociate VALUES(64);
INSERT INTO Clients VALUES (3, 'Cloud Solutions', 'Armani', '', 'Preston', 'Armani_Preston@Cloud Solutions.com', 'Montreal', 'QC', 'xxxxxx', 'pass');
INSERT INTO Contracts VALUES (4, 3, 64, '5149108628', 0, 0, '2018-02-03', 'Cloud', 'Premium', 'Development', 5);
INSERT INTO Employees VALUES(65, 'Marie', 'Reid', 'other_pass');
INSERT INTO Manager VALUES (65, 4, 64);
INSERT INTO Employees VALUES(66, 'River', 'Mitchell', 'pass');
INSERT INTO Regular VALUES (66, 4,65, 'Networking', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (66, 4, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(67, 'Cristal', 'Bradford', 'pass');
INSERT INTO Regular VALUES (67, 4,65, 'Development', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (67, 4, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(68, 'Lailah', 'Valentine', 'pass');
INSERT INTO Regular VALUES (68, 4,65, 'BusinessIntelligence', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (68, 4, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(69, 'Miguel', 'Owens', 'pass');
INSERT INTO Regular VALUES (69, 4,65, 'Development', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (69, 4, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(70, 'Alberto', 'Montgomery', 'pass');
INSERT INTO Regular VALUES (70, 4,65, 'UI', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (70, 4, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(71, 'Samson', 'Roth', 'pass');
INSERT INTO Regular VALUES (71, 4,65, 'Development', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (71, 4, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(72, 'Elyse', 'Collins', 'pass');
INSERT INTO Regular VALUES (72, 4,65, 'BusinessIntelligence', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (72, 4, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(73, 'Chase', 'Edwards', 'pass');
INSERT INTO Regular VALUES (73, 4,65, 'Networking', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (73, 4, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(74, 'Tamia', 'Mullins', 'other_pass');
INSERT INTO Manager VALUES (74, 4, 64);
INSERT INTO Employees VALUES(75, 'Walker', 'Spence', 'pass');
INSERT INTO Regular VALUES (75, 4,74, 'Design', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (75, 4, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(76, 'Diana', 'Elliott', 'pass');
INSERT INTO Regular VALUES (76, 4,74, 'BusinessIntelligence', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (76, 4, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(77, 'Dalia', 'Davidson', 'pass');
INSERT INTO Regular VALUES (77, 4,74, 'Networking', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (77, 4, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(78, 'Quinten', 'Larsen', 'pass');
INSERT INTO Regular VALUES (78, 4,74, 'Development', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (78, 4, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(79, 'Hadassah', 'Brandt', 'pass');
INSERT INTO Regular VALUES (79, 4,74, 'Design', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (79, 4, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(80, 'Tristin', 'Hendricks', 'pass');
INSERT INTO Regular VALUES (80, 4,74, 'UI', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (80, 4, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(81, 'Dulce', 'Benson', 'other_pass');
INSERT INTO Manager VALUES (81, 4, 64);
INSERT INTO Employees VALUES(82, 'Krish', 'Simmons', 'pass');
INSERT INTO Regular VALUES (82, 4,81, 'Networking', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (82, 4, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(83, 'Taryn', 'Graham', 'pass');
INSERT INTO Regular VALUES (83, 4,81, 'Design', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (83, 4, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(84, 'Jazlene', 'Tapia', 'pass');
INSERT INTO Regular VALUES (84, 4,81, 'UI', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (84, 4, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(85, 'Nehemiah', 'Wiley', 'pass');
INSERT INTO Regular VALUES (85, 4,81, 'Networking', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (85, 4, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(86, 'Arnav', 'Silva', 'pass');
INSERT INTO Regular VALUES (86, 4,81, 'Development', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (86, 4, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(87, 'Deven', 'Palmer', 'pass');
INSERT INTO Regular VALUES (87, 4,81, 'Development', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (87, 4, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(88, 'Sam', 'Park', 'pass');
INSERT INTO Regular VALUES (88, 4,81, 'Development', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (88, 4, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(89, 'Brayan', 'Baird', 'pass');
INSERT INTO Regular VALUES (89, 4,81, 'BusinessIntelligence', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (89, 4, 'Allocating a dedicated point of contact', 0);
INSERT INTO Contracts VALUES (5, 3, 64, '5149108628', 0, 0, '2015-06-12', 'Cloud', 'Gold', 'CloudServices', 5);
INSERT INTO Employees VALUES(90, 'Isabella', 'Robles', 'other_pass');
INSERT INTO Manager VALUES (90, 5, 64);
INSERT INTO Employees VALUES(91, 'Angie', 'Avery', 'pass');
INSERT INTO Regular VALUES (91, 5,90, 'Design', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (91, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(92, 'Madalyn', 'Stokes', 'pass');
INSERT INTO Regular VALUES (92, 5,90, 'QA', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (92, 5, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(93, 'Madyson', 'Nunez', 'pass');
INSERT INTO Regular VALUES (93, 5,90, 'QA', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (93, 5, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(94, 'Giada', 'Greene', 'pass');
INSERT INTO Regular VALUES (94, 5,90, 'UI', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (94, 5, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(95, 'Lilly', 'Stark', 'pass');
INSERT INTO Regular VALUES (95, 5,90, 'UI', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (95, 5, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(96, 'Jayvon', 'Gutierrez', 'pass');
INSERT INTO Regular VALUES (96, 5,90, 'UI', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (96, 5, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(97, 'Breanna', 'Bowman', 'pass');
INSERT INTO Regular VALUES (97, 5,90, 'Design', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (97, 5, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(98, 'Landen', 'Hardin', 'pass');
INSERT INTO Regular VALUES (98, 5,90, 'Networking', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (98, 5, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(99, 'Hayden', 'Hurst', 'other_pass');
INSERT INTO Manager VALUES (99, 5, 64);
INSERT INTO Employees VALUES(100, 'Houston', 'Barnett', 'pass');
INSERT INTO Regular VALUES (100, 5,99, 'UI', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (100, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(101, 'Marquis', 'Hooper', 'pass');
INSERT INTO Regular VALUES (101, 5,99, 'Design', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (101, 5, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(102, 'Ezekiel', 'Lewis', 'pass');
INSERT INTO Regular VALUES (102, 5,99, 'QA', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (102, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(103, 'Cristofer', 'Gilmore', 'pass');
INSERT INTO Regular VALUES (103, 5,99, 'UI', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (103, 5, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(104, 'Nora', 'Wall', 'pass');
INSERT INTO Regular VALUES (104, 5,99, 'Networking', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (104, 5, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(105, 'Fabian', 'Maxwell', 'pass');
INSERT INTO Regular VALUES (105, 5,99, 'UI', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (105, 5, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(106, 'Callum', 'Green', 'pass');
INSERT INTO Regular VALUES (106, 5,99, 'BusinessIntelligence', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (106, 5, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(107, 'Savannah', 'Finley', 'pass');
INSERT INTO SalesAssociate VALUES(107);
INSERT INTO Clients VALUES (4, 'Google', 'Carmelo', '', 'Hudson', 'Carmelo_Hudson@Google.com', 'Montreal', 'QC', 'xxxxxx', 'pass');
INSERT INTO Contracts VALUES (6, 4, 107, '5149108628', 0, 0, '2016-10-03', 'On-premises', 'Premium', 'Research', 5);
INSERT INTO Employees VALUES(108, 'Phillip', 'Duran', 'other_pass');
INSERT INTO Manager VALUES (108, 6, 107);
INSERT INTO Employees VALUES(109, 'Alfred', 'Villanueva', 'pass');
INSERT INTO Regular VALUES (109, 6,108, 'QA', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (109, 6, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(110, 'Kamari', 'Daugherty', 'pass');
INSERT INTO Regular VALUES (110, 6,108, 'BusinessIntelligence', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (110, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(111, 'Arthur', 'Leonard', 'pass');
INSERT INTO Regular VALUES (111, 6,108, 'Design', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (111, 6, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(112, 'Roman', 'Guerra', 'pass');
INSERT INTO Regular VALUES (112, 6,108, 'Networking', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (112, 6, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(113, 'Miles', 'Schmitt', 'pass');
INSERT INTO Regular VALUES (113, 6,108, 'Networking', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (113, 6, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(114, 'Maya', 'Mosley', 'pass');
INSERT INTO Regular VALUES (114, 6,108, 'Design', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (114, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(115, 'Allen', 'Floyd', 'other_pass');
INSERT INTO Manager VALUES (115, 6, 107);
INSERT INTO Employees VALUES(116, 'Raelynn', 'Burch', 'pass');
INSERT INTO Regular VALUES (116, 6,115, 'BusinessIntelligence', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (116, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(117, 'Paige', 'Grant', 'pass');
INSERT INTO Regular VALUES (117, 6,115, 'Design', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (117, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(118, 'Jamiya', 'Holland', 'pass');
INSERT INTO Regular VALUES (118, 6,115, 'UI', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (118, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(119, 'Carson', 'Solomon', 'pass');
INSERT INTO Regular VALUES (119, 6,115, 'QA', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (119, 6, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(120, 'Quentin', 'Ellis', 'pass');
INSERT INTO Regular VALUES (120, 6,115, 'QA', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (120, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(121, 'Lilia', 'Bartlett', 'pass');
INSERT INTO Regular VALUES (121, 6,115, 'UI', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (121, 6, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(122, 'Maia', 'Stephens', 'pass');
INSERT INTO Regular VALUES (122, 6,115, 'BusinessIntelligence', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (122, 6, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(123, 'Alma', 'Serrano', 'other_pass');
INSERT INTO Manager VALUES (123, 6, 107);
INSERT INTO Employees VALUES(124, 'Willie', 'Chavez', 'pass');
INSERT INTO Regular VALUES (124, 6,123, 'BusinessIntelligence', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (124, 6, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(125, 'Antony', 'Kline', 'pass');
INSERT INTO Regular VALUES (125, 6,123, 'Networking', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (125, 6, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(126, 'Irene', 'Duncan', 'pass');
INSERT INTO Regular VALUES (126, 6,123, 'Design', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (126, 6, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(127, 'Maggie', 'Henry', 'pass');
INSERT INTO Regular VALUES (127, 6,123, 'QA', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (127, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(128, 'Gregory', 'Madden', 'pass');
INSERT INTO Regular VALUES (128, 6,123, 'Design', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (128, 6, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(129, 'Danielle', 'Mcdowell', 'pass');
INSERT INTO Regular VALUES (129, 6,123, 'Networking', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (129, 6, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(130, 'Rayna', 'Montoya', 'pass');
INSERT INTO Regular VALUES (130, 6,123, 'QA', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (130, 6, 'Provisioning of resources', 0);
INSERT INTO Contracts VALUES (7, 4, 107, '5149108628', 0, 0, '2016-06-13', 'Cloud', 'Diamond', 'CloudServices', 5);
INSERT INTO Employees VALUES(131, 'Alissa', 'Douglas', 'other_pass');
INSERT INTO Manager VALUES (131, 7, 107);
INSERT INTO Employees VALUES(132, 'Kamron', 'Doyle', 'pass');
INSERT INTO Regular VALUES (132, 7,131, 'BusinessIntelligence', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (132, 7, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(133, 'Evangeline', 'Leblanc', 'pass');
INSERT INTO Regular VALUES (133, 7,131, 'Networking', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (133, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(134, 'Kelton', 'Cannon', 'pass');
INSERT INTO Regular VALUES (134, 7,131, 'UI', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (134, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(135, 'Trevin', 'Cantrell', 'pass');
INSERT INTO Regular VALUES (135, 7,131, 'Design', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (135, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(136, 'Grace', 'Shea', 'pass');
INSERT INTO Regular VALUES (136, 7,131, 'UI', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (136, 7, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(137, 'Colt', 'Mcgrath', 'pass');
INSERT INTO Regular VALUES (137, 7,131, 'Design', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (137, 7, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(138, 'Jamie', 'Burke', 'pass');
INSERT INTO Regular VALUES (138, 7,131, 'Development', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (138, 7, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(139, 'Regina', 'Delacruz', 'other_pass');
INSERT INTO Manager VALUES (139, 7, 107);
INSERT INTO Employees VALUES(140, 'Jaelynn', 'Dodson', 'pass');
INSERT INTO Regular VALUES (140, 7,139, 'UI', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (140, 7, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(141, 'Collin', 'George', 'pass');
INSERT INTO Regular VALUES (141, 7,139, 'Development', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (141, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(142, 'Savanna', 'Hobbs', 'pass');
INSERT INTO Regular VALUES (142, 7,139, 'Design', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (142, 7, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(143, 'Vance', 'Ross', 'pass');
INSERT INTO Regular VALUES (143, 7,139, 'Design', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (143, 7, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(144, 'Tiara', 'Castaneda', 'pass');
INSERT INTO Regular VALUES (144, 7,139, 'BusinessIntelligence', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (144, 7, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(145, 'Makai', 'Adkins', 'pass');
INSERT INTO Regular VALUES (145, 7,139, 'Design', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (145, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(146, 'Krystal', 'Walton', 'pass');
INSERT INTO Regular VALUES (146, 7,139, 'Design', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (146, 7, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(147, 'Georgia', 'Trevino', 'other_pass');
INSERT INTO Manager VALUES (147, 7, 107);
INSERT INTO Employees VALUES(148, 'Brandon', 'Kidd', 'pass');
INSERT INTO Regular VALUES (148, 7,147, 'Design', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (148, 7, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(149, 'Kieran', 'Dougherty', 'pass');
INSERT INTO Regular VALUES (149, 7,147, 'BusinessIntelligence', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (149, 7, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(150, 'Kasey', 'Powell', 'pass');
INSERT INTO Regular VALUES (150, 7,147, 'QA', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (150, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(151, 'Lane', 'Dawson', 'pass');
INSERT INTO Regular VALUES (151, 7,147, 'QA', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (151, 7, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(152, 'Addison', 'Waller', 'pass');
INSERT INTO Regular VALUES (152, 7,147, 'Development', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (152, 7, 'Provisioning of resources', 0);
INSERT INTO Clients VALUES (5, 'Facebook', 'Tony', '', 'Gamble', 'Tony_Gamble@Facebook.com', 'Montreal', 'QC', 'xxxxxx', 'pass');
INSERT INTO Contracts VALUES (8, 5, 107, '5149108628', 0, 0, '2015-07-22', 'Cloud', 'Silver', 'Research', 5);
INSERT INTO Employees VALUES(153, 'Jesse', 'Sellers', 'other_pass');
INSERT INTO Manager VALUES (153, 8, 107);
INSERT INTO Employees VALUES(154, 'Libby', 'Frost', 'pass');
INSERT INTO Regular VALUES (154, 8,153, 'QA', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (154, 8, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(155, 'Jensen', 'Kane', 'pass');
INSERT INTO Regular VALUES (155, 8,153, 'Development', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (155, 8, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(156, 'Harry', 'Cruz', 'pass');
INSERT INTO Regular VALUES (156, 8,153, 'Design', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (156, 8, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(157, 'Luciana', 'Peck', 'pass');
INSERT INTO Regular VALUES (157, 8,153, 'Networking', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (157, 8, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(158, 'Norah', 'Clark', 'pass');
INSERT INTO Regular VALUES (158, 8,153, 'Design', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (158, 8, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(159, 'Adison', 'Drake', 'pass');
INSERT INTO Regular VALUES (159, 8,153, 'Networking', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (159, 8, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(160, 'Konnor', 'Shelton', 'pass');
INSERT INTO Regular VALUES (160, 8,153, 'UI', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (160, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(161, 'Frida', 'Wells', 'pass');
INSERT INTO Regular VALUES (161, 8,153, 'Development', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (161, 8, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(162, 'Ronan', 'Beck', 'other_pass');
INSERT INTO Manager VALUES (162, 8, 107);
INSERT INTO Employees VALUES(163, 'Alaina', 'Acevedo', 'pass');
INSERT INTO Regular VALUES (163, 8,162, 'UI', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (163, 8, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(164, 'Caylee', 'Robinson', 'pass');
INSERT INTO Regular VALUES (164, 8,162, 'UI', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (164, 8, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(165, 'Micah', 'Hurley', 'pass');
INSERT INTO Regular VALUES (165, 8,162, 'UI', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (165, 8, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(166, 'Elliott', 'Griffin', 'pass');
INSERT INTO Regular VALUES (166, 8,162, 'Networking', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (166, 8, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(167, 'Sheldon', 'Gates', 'pass');
INSERT INTO Regular VALUES (167, 8,162, 'Networking', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (167, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(168, 'Marley', 'Anderson', 'pass');
INSERT INTO Regular VALUES (168, 8,162, 'Design', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (168, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(169, 'Leslie', 'Garza', 'pass');
INSERT INTO SalesAssociate VALUES(169);
INSERT INTO Clients VALUES (6, 'Twitterm', 'Nelson', '', 'Boyle', 'Nelson_Boyle@Twitterm.com', 'Montreal', 'QC', 'xxxxxx', 'pass');
INSERT INTO Contracts VALUES (9, 6, 169, '5149108628', 0, 0, '2017-10-22', 'On-premises', 'Diamond', 'CloudServices', 5);
INSERT INTO Employees VALUES(170, 'Izabella', 'Porter', 'other_pass');
INSERT INTO Manager VALUES (170, 9, 169);
INSERT INTO Employees VALUES(171, 'Linda', 'Valdez', 'pass');
INSERT INTO Regular VALUES (171, 9,170, 'BusinessIntelligence', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (171, 9, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(172, 'Salvatore', 'Tyler', 'pass');
INSERT INTO Regular VALUES (172, 9,170, 'Networking', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (172, 9, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(173, 'Lillie', 'Tanner', 'pass');
INSERT INTO Regular VALUES (173, 9,170, 'Development', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (173, 9, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(174, 'Marley', 'Diaz', 'pass');
INSERT INTO Regular VALUES (174, 9,170, 'UI', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (174, 9, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(175, 'Kayden', 'Gordon', 'pass');
INSERT INTO Regular VALUES (175, 9,170, 'Networking', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (175, 9, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(176, 'Nico', 'Whitehead', 'pass');
INSERT INTO Regular VALUES (176, 9,170, 'UI', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (176, 9, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(177, 'Briana', 'Cole', 'pass');
INSERT INTO Regular VALUES (177, 9,170, 'Networking', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (177, 9, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(178, 'Ashly', 'Pineda', 'other_pass');
INSERT INTO Manager VALUES (178, 9, 169);
INSERT INTO Employees VALUES(179, 'Evie', 'Gill', 'pass');
INSERT INTO Regular VALUES (179, 9,178, 'UI', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (179, 9, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(180, 'Gaven', 'Christian', 'pass');
INSERT INTO Regular VALUES (180, 9,178, 'Networking', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (180, 9, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(181, 'Raquel', 'Cabrera', 'pass');
INSERT INTO Regular VALUES (181, 9,178, 'Design', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (181, 9, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(182, 'Avery', 'Woodward', 'pass');
INSERT INTO Regular VALUES (182, 9,178, 'UI', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (182, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(183, 'Hugh', 'Pruitt', 'pass');
INSERT INTO Regular VALUES (183, 9,178, 'QA', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (183, 9, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(184, 'Frankie', 'Ford', 'pass');
INSERT INTO Regular VALUES (184, 9,178, 'Development', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (184, 9, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(185, 'Hallie', 'Rush', 'pass');
INSERT INTO Regular VALUES (185, 9,178, 'BusinessIntelligence', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (185, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(186, 'Mallory', 'Mcclain', 'other_pass');
INSERT INTO Manager VALUES (186, 9, 169);
INSERT INTO Employees VALUES(187, 'Lucille', 'Mueller', 'pass');
INSERT INTO Regular VALUES (187, 9,186, 'QA', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (187, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(188, 'Madden', 'Moss', 'pass');
INSERT INTO Regular VALUES (188, 9,186, 'Development', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (188, 9, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(189, 'Mary', 'Thomas', 'pass');
INSERT INTO Regular VALUES (189, 9,186, 'Development', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (189, 9, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(190, 'Leland', 'Little', 'pass');
INSERT INTO Regular VALUES (190, 9,186, 'QA', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (190, 9, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(191, 'Nash', 'Lester', 'pass');
INSERT INTO Regular VALUES (191, 9,186, 'Networking', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (191, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(192, 'Karli', 'Werner', 'pass');
INSERT INTO Regular VALUES (192, 9,186, 'Networking', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (192, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(193, 'Kaliyah', 'Yang', 'pass');
INSERT INTO Regular VALUES (193, 9,186, 'UI', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (193, 9, 'Assigning tasks to resources', 0);
