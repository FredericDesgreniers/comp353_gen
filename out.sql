
	drop table Tasks;
	drop table Regular;
	drop table Manager;
	drop table Admin;
	drop table SalesAssociate;
	drop table Supervisor;
	drop table Employees;
	drop table Contracts;
	drop table Clients;

	CREATE TABLE Clients(
		clientId INT NOT NULL AUTO_INCREMENT,
	clientName VARCHAR(255),
	repFirstName VARCHAR(255),
	repMiddleInital VARCHAR(5),
	repLastName VARCHAR(255),
	emailId VARCHAR(255),
	city VARCHAR(255),
	province VARCHAR(255),
	postalCode VARCHAR(255),
	password VARCHAR(20) NOT NULL,
	PRIMARY KEY (clientId)
	);

	CREATE TABLE Contracts(
		contractId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	clientId INT NOT NULL,
	FOREIGN KEY(clientId) REFERENCES Clients(clientId),
	contactNumber VARCHAR(15) NOT NULL,
	annualContractValue DOUBLE NOT NULL,
	initalAmount DOUBLE NOT NULL,
	serviceStartDate DATE NOT NULL,
	serviceType ENUM('Cloud','On-premises') NOT NULL,
	contractType ENUM('Premium','Gold','Diamond','Silver') NOT NULL,
	lineOfBusiness ENUM('CloudServices', 'Development', 'Research') NOT NULL,
	satisfactionLevel INT CHECK (satisfactionLevel >=1 AND satisfactionLevel <=10)
	);




	CREATE TABLE Employees (
		employeeId INT NOT NULL AUTO_INCREMENT,
	firstName VARCHAR(255) NOT NULL,
	lastName VARCHAR(255) NOT NULL,
	password varchar(20) NOT NULL,
	PRIMARY KEY (employeeId)
	);

	CREATE TABLE Supervisor (
		employeeId INT NOT NULL PRIMARY KEY REFERENCES Employees(employeeId),
	contractId INT NOT NULL REFERENCES Contracts(contractId)
	);

	CREATE TABLE SalesAssociate (
		employeeId INT NOT NULL PRIMARY KEY REFERENCES Employees(employeeId)
	);

	CREATE TABLE Admin (
		employeeId INT NOT NULL PRIMARY KEY REFERENCES Employees(employeeId)
	);


	CREATE TABLE Manager (
		employeeId INT NOT NULL PRIMARY KEY REFERENCES Employees(employeeId),
	contractId INT NOT NULL,
	manageBy INT NOT NULL,
	FOREIGN KEY (contractId) REFERENCES Contracts(contractId),
	FOREIGN KEY (manageBy) REFERENCES Supervisor(employeeId)
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
	FOREIGN KEY(contractId) REFERENCES Contracts(contractId),
	taskType ENUM('Set up infrastructure for client','Provisioning of resources','Assigning tasks to resources','Allocating a dedicated point of contact') NOT NULL,
	hours int  default 0,
	CHECK(hours >= 0)
	);INSERT INTO Employees VALUES(1, 'Alejandro', 'Vargas', 'pass');
INSERT INTO SalesAssociate VALUES(1);
INSERT INTO Clients VALUES (1, 'Etrade inc.', 'Kamren', '', 'Jackson', 'Kamren_Jackson@Etrade inc..com', 'Montreal', 'QC', 'xxxxxx', 'pass');
INSERT INTO Contracts VALUES (1, 1, '5149108628', 0, 0, '2017-02-07', 'Cloud', 'Silver', 'Research', 5);
INSERT INTO Employees VALUES(2, 'Celeste', 'Guerrero', 'pass123');
INSERT INTO Supervisor VALUES (2, 1);
INSERT INTO Employees VALUES(3, 'Lorelai', 'Schneider', 'other_pass');
INSERT INTO Manager VALUES (3, 1, 2);
INSERT INTO Employees VALUES(4, 'Simone', 'Miller', 'pass');
INSERT INTO Regular VALUES (4, 1,3, 'BusinessIntelligence', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (4, 1, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(5, 'Jaelyn', 'Lopez', 'pass');
INSERT INTO Regular VALUES (5, 1,3, 'UI', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (5, 1, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(6, 'Brooks', 'Shepard', 'pass');
INSERT INTO Regular VALUES (6, 1,3, 'Networking', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (6, 1, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(7, 'Nikhil', 'Becker', 'pass');
INSERT INTO Regular VALUES (7, 1,3, 'BusinessIntelligence', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (7, 1, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(8, 'Kathleen', 'Melton', 'pass');
INSERT INTO Regular VALUES (8, 1,3, 'Networking', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (8, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(9, 'Sarai', 'Hays', 'other_pass');
INSERT INTO Manager VALUES (9, 1, 2);
INSERT INTO Employees VALUES(10, 'Meredith', 'Barber', 'pass');
INSERT INTO Regular VALUES (10, 1,9, 'UI', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (10, 1, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(11, 'Wilson', 'Hancock', 'pass');
INSERT INTO Regular VALUES (11, 1,9, 'Networking', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (11, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(12, 'Virginia', 'Franco', 'pass');
INSERT INTO Regular VALUES (12, 1,9, 'Development', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (12, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(13, 'Tripp', 'Salinas', 'pass');
INSERT INTO Regular VALUES (13, 1,9, 'BusinessIntelligence', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (13, 1, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(14, 'Kinsley', 'Logan', 'pass');
INSERT INTO Regular VALUES (14, 1,9, 'Design', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (14, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(15, 'Tabitha', 'Benjamin', 'pass');
INSERT INTO Regular VALUES (15, 1,9, 'Networking', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (15, 1, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(16, 'Santiago', 'Pace', 'pass');
INSERT INTO Regular VALUES (16, 1,9, 'UI', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (16, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(17, 'Jerry', 'Estes', 'pass');
INSERT INTO Regular VALUES (17, 1,9, 'Design', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (17, 1, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(18, 'Giancarlo', 'Randolph', 'other_pass');
INSERT INTO Manager VALUES (18, 1, 2);
INSERT INTO Employees VALUES(19, 'Kailee', 'Downs', 'pass');
INSERT INTO Regular VALUES (19, 1,18, 'BusinessIntelligence', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (19, 1, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(20, 'Joaquin', 'Le', 'pass');
INSERT INTO Regular VALUES (20, 1,18, 'UI', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (20, 1, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(21, 'Jaida', 'Watkins', 'pass');
INSERT INTO Regular VALUES (21, 1,18, 'QA', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (21, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(22, 'Jaylyn', 'Bridges', 'pass');
INSERT INTO Regular VALUES (22, 1,18, 'UI', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (22, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(23, 'Yoselin', 'Best', 'pass');
INSERT INTO Regular VALUES (23, 1,18, 'Networking', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (23, 1, 'Assigning tasks to resources', 0);
INSERT INTO Clients VALUES (2, 'WeMakeWebsites', 'Layla', '', 'Boyd', 'Layla_Boyd@WeMakeWebsites.com', 'Montreal', 'QC', 'xxxxxx', 'pass');
INSERT INTO Contracts VALUES (2, 2, '5149108628', 0, 0, '2018-04-12', 'Cloud', 'Diamond', 'Development', 5);
INSERT INTO Employees VALUES(24, 'Mila', 'Whitney', 'pass123');
INSERT INTO Supervisor VALUES (24, 2);
INSERT INTO Employees VALUES(25, 'Heidy', 'Maldonado', 'other_pass');
INSERT INTO Manager VALUES (25, 2, 24);
INSERT INTO Employees VALUES(26, 'Robert', 'Villegas', 'pass');
INSERT INTO Regular VALUES (26, 2,25, 'Networking', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (26, 2, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(27, 'Brodie', 'Hammond', 'pass');
INSERT INTO Regular VALUES (27, 2,25, 'BusinessIntelligence', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (27, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(28, 'Emery', 'Rivas', 'pass');
INSERT INTO Regular VALUES (28, 2,25, 'Development', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (28, 2, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(29, 'Brianna', 'Dickson', 'pass');
INSERT INTO Regular VALUES (29, 2,25, 'Development', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (29, 2, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(30, 'Yosef', 'Rollins', 'pass');
INSERT INTO Regular VALUES (30, 2,25, 'Networking', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (30, 2, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(31, 'Milagros', 'Lozano', 'pass');
INSERT INTO Regular VALUES (31, 2,25, 'UI', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (31, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(32, 'Skylar', 'Griffith', 'pass');
INSERT INTO Regular VALUES (32, 2,25, 'QA', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (32, 2, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(33, 'Maximo', 'Hampton', 'pass');
INSERT INTO Regular VALUES (33, 2,25, 'Design', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (33, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(34, 'Luis', 'Benton', 'other_pass');
INSERT INTO Manager VALUES (34, 2, 24);
INSERT INTO Employees VALUES(35, 'Adrian', 'Carey', 'pass');
INSERT INTO Regular VALUES (35, 2,34, 'Design', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (35, 2, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(36, 'Micaela', 'Moreno', 'pass');
INSERT INTO Regular VALUES (36, 2,34, 'Networking', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (36, 2, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(37, 'Bailee', 'Carney', 'pass');
INSERT INTO Regular VALUES (37, 2,34, 'QA', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (37, 2, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(38, 'Jabari', 'Mahoney', 'pass');
INSERT INTO Regular VALUES (38, 2,34, 'BusinessIntelligence', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (38, 2, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(39, 'Nikolas', 'Ellison', 'pass');
INSERT INTO Regular VALUES (39, 2,34, 'QA', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (39, 2, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(40, 'Allison', 'King', 'pass');
INSERT INTO Regular VALUES (40, 2,34, 'Development', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (40, 2, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(41, 'Jude', 'Ward', 'pass');
INSERT INTO Regular VALUES (41, 2,34, 'QA', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (41, 2, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(42, 'Ryleigh', 'Riddle', 'other_pass');
INSERT INTO Manager VALUES (42, 2, 24);
INSERT INTO Employees VALUES(43, 'Kylan', 'Hinton', 'pass');
INSERT INTO Regular VALUES (43, 2,42, 'UI', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (43, 2, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(44, 'Ansley', 'Clarke', 'pass');
INSERT INTO Regular VALUES (44, 2,42, 'Networking', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (44, 2, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(45, 'Yazmin', 'Murillo', 'pass');
INSERT INTO Regular VALUES (45, 2,42, 'Design', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (45, 2, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(46, 'Eve', 'Gillespie', 'pass');
INSERT INTO Regular VALUES (46, 2,42, 'Networking', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (46, 2, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(47, 'Jorge', 'Clay', 'pass');
INSERT INTO Regular VALUES (47, 2,42, 'QA', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (47, 2, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(48, 'Brogan', 'Fuentes', 'pass');
INSERT INTO Regular VALUES (48, 2,42, 'UI', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (48, 2, 'Allocating a dedicated point of contact', 0);
INSERT INTO Contracts VALUES (3, 2, '5149108628', 0, 0, '2015-06-14', 'On-premises', 'Silver', 'Research', 5);
INSERT INTO Employees VALUES(49, 'Max', 'Grimes', 'pass123');
INSERT INTO Supervisor VALUES (49, 3);
INSERT INTO Employees VALUES(50, 'Nicolas', 'Sherman', 'other_pass');
INSERT INTO Manager VALUES (50, 3, 49);
INSERT INTO Employees VALUES(51, 'Ariella', 'Ortiz', 'pass');
INSERT INTO Regular VALUES (51, 3,50, 'UI', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (51, 3, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(52, 'Barbara', 'Solis', 'pass');
INSERT INTO Regular VALUES (52, 3,50, 'Design', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (52, 3, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(53, 'Brynn', 'Benitez', 'pass');
INSERT INTO Regular VALUES (53, 3,50, 'QA', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (53, 3, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(54, 'Timothy', 'Holmes', 'pass');
INSERT INTO Regular VALUES (54, 3,50, 'BusinessIntelligence', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (54, 3, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(55, 'Kyle', 'Mathis', 'pass');
INSERT INTO Regular VALUES (55, 3,50, 'Development', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (55, 3, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(56, 'Carley', 'Flores', 'pass');
INSERT INTO Regular VALUES (56, 3,50, 'Design', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (56, 3, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(57, 'Cortez', 'Ponce', 'pass');
INSERT INTO Regular VALUES (57, 3,50, 'QA', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (57, 3, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(58, 'Jasmine', 'Jones', 'pass');
INSERT INTO Regular VALUES (58, 3,50, 'Networking', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (58, 3, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(59, 'Neveah', 'Davenport', 'other_pass');
INSERT INTO Manager VALUES (59, 3, 49);
INSERT INTO Employees VALUES(60, 'Tucker', 'Pena', 'pass');
INSERT INTO Regular VALUES (60, 3,59, 'Design', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (60, 3, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(61, 'Ann', 'Curry', 'pass');
INSERT INTO Regular VALUES (61, 3,59, 'Development', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (61, 3, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(62, 'Jillian', 'Shepherd', 'pass');
INSERT INTO Regular VALUES (62, 3,59, 'QA', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (62, 3, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(63, 'Conner', 'Bennett', 'pass');
INSERT INTO Regular VALUES (63, 3,59, 'UI', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (63, 3, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(64, 'Londyn', 'Harrell', 'pass');
INSERT INTO Regular VALUES (64, 3,59, 'Networking', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (64, 3, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(65, 'Armani', 'Preston', 'pass');
INSERT INTO Regular VALUES (65, 3,59, 'Design', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (65, 3, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(66, 'Marie', 'Reid', 'pass');
INSERT INTO SalesAssociate VALUES(66);
INSERT INTO Clients VALUES (3, 'Cloud Solutions', 'River', '', 'Mitchell', 'River_Mitchell@Cloud Solutions.com', 'Montreal', 'QC', 'xxxxxx', 'pass');
INSERT INTO Contracts VALUES (4, 3, '5149108628', 0, 0, '2015-05-13', 'On-premises', 'Gold', 'Development', 5);
INSERT INTO Employees VALUES(67, 'Cristal', 'Bradford', 'pass123');
INSERT INTO Supervisor VALUES (67, 4);
INSERT INTO Employees VALUES(68, 'Lailah', 'Valentine', 'other_pass');
INSERT INTO Manager VALUES (68, 4, 67);
INSERT INTO Employees VALUES(69, 'Miguel', 'Owens', 'pass');
INSERT INTO Regular VALUES (69, 4,68, 'QA', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (69, 4, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(70, 'Alberto', 'Montgomery', 'pass');
INSERT INTO Regular VALUES (70, 4,68, 'Development', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (70, 4, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(71, 'Samson', 'Roth', 'pass');
INSERT INTO Regular VALUES (71, 4,68, 'BusinessIntelligence', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (71, 4, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(72, 'Elyse', 'Collins', 'pass');
INSERT INTO Regular VALUES (72, 4,68, 'Networking', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (72, 4, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(73, 'Chase', 'Edwards', 'pass');
INSERT INTO Regular VALUES (73, 4,68, 'QA', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (73, 4, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(74, 'Tamia', 'Mullins', 'other_pass');
INSERT INTO Manager VALUES (74, 4, 67);
INSERT INTO Employees VALUES(75, 'Walker', 'Spence', 'pass');
INSERT INTO Regular VALUES (75, 4,74, 'UI', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (75, 4, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(76, 'Diana', 'Elliott', 'pass');
INSERT INTO Regular VALUES (76, 4,74, 'Networking', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (76, 4, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(77, 'Dalia', 'Davidson', 'pass');
INSERT INTO Regular VALUES (77, 4,74, 'QA', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (77, 4, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(78, 'Quinten', 'Larsen', 'pass');
INSERT INTO Regular VALUES (78, 4,74, 'BusinessIntelligence', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (78, 4, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(79, 'Hadassah', 'Brandt', 'pass');
INSERT INTO Regular VALUES (79, 4,74, 'UI', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (79, 4, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(80, 'Tristin', 'Hendricks', 'pass');
INSERT INTO Regular VALUES (80, 4,74, 'BusinessIntelligence', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (80, 4, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(81, 'Dulce', 'Benson', 'pass');
INSERT INTO Regular VALUES (81, 4,74, 'BusinessIntelligence', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (81, 4, 'Set up infrastructure for client', 0);
INSERT INTO Contracts VALUES (5, 3, '5149108628', 0, 0, '2015-08-08', 'On-premises', 'Gold', 'Research', 5);
INSERT INTO Employees VALUES(82, 'Krish', 'Simmons', 'pass123');
INSERT INTO Supervisor VALUES (82, 5);
INSERT INTO Employees VALUES(83, 'Taryn', 'Graham', 'other_pass');
INSERT INTO Manager VALUES (83, 5, 82);
INSERT INTO Employees VALUES(84, 'Jazlene', 'Tapia', 'pass');
INSERT INTO Regular VALUES (84, 5,83, 'Design', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (84, 5, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(85, 'Nehemiah', 'Wiley', 'pass');
INSERT INTO Regular VALUES (85, 5,83, 'Networking', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (85, 5, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(86, 'Arnav', 'Silva', 'pass');
INSERT INTO Regular VALUES (86, 5,83, 'QA', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (86, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(87, 'Deven', 'Palmer', 'pass');
INSERT INTO Regular VALUES (87, 5,83, 'QA', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (87, 5, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(88, 'Sam', 'Park', 'pass');
INSERT INTO Regular VALUES (88, 5,83, 'BusinessIntelligence', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (88, 5, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(89, 'Brayan', 'Baird', 'pass');
INSERT INTO Regular VALUES (89, 5,83, 'Design', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (89, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(90, 'Isabella', 'Robles', 'other_pass');
INSERT INTO Manager VALUES (90, 5, 82);
INSERT INTO Employees VALUES(91, 'Angie', 'Avery', 'pass');
INSERT INTO Regular VALUES (91, 5,90, 'Networking', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (91, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(92, 'Madalyn', 'Stokes', 'pass');
INSERT INTO Regular VALUES (92, 5,90, 'Development', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (92, 5, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(93, 'Madyson', 'Nunez', 'pass');
INSERT INTO Regular VALUES (93, 5,90, 'Networking', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (93, 5, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(94, 'Giada', 'Greene', 'pass');
INSERT INTO Regular VALUES (94, 5,90, 'BusinessIntelligence', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (94, 5, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(95, 'Lilly', 'Stark', 'pass');
INSERT INTO Regular VALUES (95, 5,90, 'Design', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (95, 5, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(96, 'Jayvon', 'Gutierrez', 'pass');
INSERT INTO SalesAssociate VALUES(96);
INSERT INTO Clients VALUES (4, 'Google', 'Breanna', '', 'Bowman', 'Breanna_Bowman@Google.com', 'Montreal', 'QC', 'xxxxxx', 'pass');
INSERT INTO Contracts VALUES (6, 4, '5149108628', 0, 0, '2015-04-01', 'On-premises', 'Diamond', 'CloudServices', 5);
INSERT INTO Employees VALUES(97, 'Landen', 'Hardin', 'pass123');
INSERT INTO Supervisor VALUES (97, 6);
INSERT INTO Employees VALUES(98, 'Hayden', 'Hurst', 'other_pass');
INSERT INTO Manager VALUES (98, 6, 97);
INSERT INTO Employees VALUES(99, 'Houston', 'Barnett', 'pass');
INSERT INTO Regular VALUES (99, 6,98, 'BusinessIntelligence', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (99, 6, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(100, 'Marquis', 'Hooper', 'pass');
INSERT INTO Regular VALUES (100, 6,98, 'BusinessIntelligence', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (100, 6, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(101, 'Ezekiel', 'Lewis', 'pass');
INSERT INTO Regular VALUES (101, 6,98, 'Design', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (101, 6, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(102, 'Cristofer', 'Gilmore', 'pass');
INSERT INTO Regular VALUES (102, 6,98, 'Development', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (102, 6, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(103, 'Nora', 'Wall', 'pass');
INSERT INTO Regular VALUES (103, 6,98, 'Design', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (103, 6, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(104, 'Fabian', 'Maxwell', 'other_pass');
INSERT INTO Manager VALUES (104, 6, 97);
INSERT INTO Employees VALUES(105, 'Callum', 'Green', 'pass');
INSERT INTO Regular VALUES (105, 6,104, 'QA', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (105, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(106, 'Savannah', 'Finley', 'pass');
INSERT INTO Regular VALUES (106, 6,104, 'Development', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (106, 6, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(107, 'Carmelo', 'Hudson', 'pass');
INSERT INTO Regular VALUES (107, 6,104, 'BusinessIntelligence', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (107, 6, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(108, 'Phillip', 'Duran', 'pass');
INSERT INTO Regular VALUES (108, 6,104, 'Development', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (108, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(109, 'Alfred', 'Villanueva', 'pass');
INSERT INTO Regular VALUES (109, 6,104, 'Networking', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (109, 6, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(110, 'Kamari', 'Daugherty', 'pass');
INSERT INTO Regular VALUES (110, 6,104, 'BusinessIntelligence', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (110, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(111, 'Arthur', 'Leonard', 'pass');
INSERT INTO Regular VALUES (111, 6,104, 'BusinessIntelligence', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (111, 6, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(112, 'Roman', 'Guerra', 'pass');
INSERT INTO Regular VALUES (112, 6,104, 'Development', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (112, 6, 'Set up infrastructure for client', 0);
INSERT INTO Contracts VALUES (7, 4, '5149108628', 0, 0, '2015-05-08', 'On-premises', 'Premium', 'CloudServices', 5);
INSERT INTO Employees VALUES(113, 'Miles', 'Schmitt', 'pass123');
INSERT INTO Supervisor VALUES (113, 7);
INSERT INTO Employees VALUES(114, 'Maya', 'Mosley', 'other_pass');
INSERT INTO Manager VALUES (114, 7, 113);
INSERT INTO Employees VALUES(115, 'Allen', 'Floyd', 'pass');
INSERT INTO Regular VALUES (115, 7,114, 'Development', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (115, 7, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(116, 'Raelynn', 'Burch', 'pass');
INSERT INTO Regular VALUES (116, 7,114, 'Design', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (116, 7, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(117, 'Paige', 'Grant', 'pass');
INSERT INTO Regular VALUES (117, 7,114, 'Networking', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (117, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(118, 'Jamiya', 'Holland', 'pass');
INSERT INTO Regular VALUES (118, 7,114, 'Development', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (118, 7, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(119, 'Carson', 'Solomon', 'pass');
INSERT INTO Regular VALUES (119, 7,114, 'Design', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (119, 7, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(120, 'Quentin', 'Ellis', 'pass');
INSERT INTO Regular VALUES (120, 7,114, 'QA', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (120, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(121, 'Lilia', 'Bartlett', 'pass');
INSERT INTO Regular VALUES (121, 7,114, 'Networking', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (121, 7, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(122, 'Maia', 'Stephens', 'other_pass');
INSERT INTO Manager VALUES (122, 7, 113);
INSERT INTO Employees VALUES(123, 'Alma', 'Serrano', 'pass');
INSERT INTO Regular VALUES (123, 7,122, 'Development', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (123, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(124, 'Willie', 'Chavez', 'pass');
INSERT INTO Regular VALUES (124, 7,122, 'Development', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (124, 7, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(125, 'Antony', 'Kline', 'pass');
INSERT INTO Regular VALUES (125, 7,122, 'Networking', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (125, 7, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(126, 'Irene', 'Duncan', 'pass');
INSERT INTO Regular VALUES (126, 7,122, 'Development', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (126, 7, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(127, 'Maggie', 'Henry', 'pass');
INSERT INTO Regular VALUES (127, 7,122, 'Design', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (127, 7, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(128, 'Gregory', 'Madden', 'other_pass');
INSERT INTO Manager VALUES (128, 7, 113);
INSERT INTO Employees VALUES(129, 'Danielle', 'Mcdowell', 'pass');
INSERT INTO Regular VALUES (129, 7,128, 'UI', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (129, 7, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(130, 'Rayna', 'Montoya', 'pass');
INSERT INTO Regular VALUES (130, 7,128, 'Design', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (130, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(131, 'Alissa', 'Douglas', 'pass');
INSERT INTO Regular VALUES (131, 7,128, 'Design', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (131, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(132, 'Kamron', 'Doyle', 'pass');
INSERT INTO Regular VALUES (132, 7,128, 'UI', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (132, 7, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(133, 'Evangeline', 'Leblanc', 'pass');
INSERT INTO Regular VALUES (133, 7,128, 'Networking', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (133, 7, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(134, 'Kelton', 'Cannon', 'pass');
INSERT INTO SalesAssociate VALUES(134);
INSERT INTO Clients VALUES (5, 'Facebook', 'Trevin', '', 'Cantrell', 'Trevin_Cantrell@Facebook.com', 'Montreal', 'QC', 'xxxxxx', 'pass');
INSERT INTO Contracts VALUES (8, 5, '5149108628', 0, 0, '2018-10-26', 'Cloud', 'Diamond', 'CloudServices', 5);
INSERT INTO Employees VALUES(135, 'Grace', 'Shea', 'pass123');
INSERT INTO Supervisor VALUES (135, 8);
INSERT INTO Employees VALUES(136, 'Colt', 'Mcgrath', 'other_pass');
INSERT INTO Manager VALUES (136, 8, 135);
INSERT INTO Employees VALUES(137, 'Jamie', 'Burke', 'pass');
INSERT INTO Regular VALUES (137, 8,136, 'Development', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (137, 8, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(138, 'Regina', 'Delacruz', 'pass');
INSERT INTO Regular VALUES (138, 8,136, 'Design', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (138, 8, 'Provisioning of resources', 0);
INSERT INTO Employees VALUES(139, 'Jaelynn', 'Dodson', 'pass');
INSERT INTO Regular VALUES (139, 8,136, 'BusinessIntelligence', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (139, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(140, 'Collin', 'George', 'pass');
INSERT INTO Regular VALUES (140, 8,136, 'Networking', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (140, 8, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(141, 'Savanna', 'Hobbs', 'pass');
INSERT INTO Regular VALUES (141, 8,136, 'QA', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (141, 8, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(142, 'Vance', 'Ross', 'pass');
INSERT INTO Regular VALUES (142, 8,136, 'Development', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (142, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(143, 'Tiara', 'Castaneda', 'pass');
INSERT INTO Regular VALUES (143, 8,136, 'Development', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (143, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(144, 'Makai', 'Adkins', 'other_pass');
INSERT INTO Manager VALUES (144, 8, 135);
INSERT INTO Employees VALUES(145, 'Krystal', 'Walton', 'pass');
INSERT INTO Regular VALUES (145, 8,144, 'BusinessIntelligence', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (145, 8, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(146, 'Georgia', 'Trevino', 'pass');
INSERT INTO Regular VALUES (146, 8,144, 'UI', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (146, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(147, 'Brandon', 'Kidd', 'pass');
INSERT INTO Regular VALUES (147, 8,144, 'Networking', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (147, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(148, 'Kieran', 'Dougherty', 'pass');
INSERT INTO Regular VALUES (148, 8,144, 'UI', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (148, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(149, 'Kasey', 'Powell', 'pass');
INSERT INTO Regular VALUES (149, 8,144, 'Design', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (149, 8, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(150, 'Lane', 'Dawson', 'pass');
INSERT INTO Regular VALUES (150, 8,144, 'Development', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (150, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(151, 'Addison', 'Waller', 'pass');
INSERT INTO Regular VALUES (151, 8,144, 'UI', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (151, 8, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(152, 'Tony', 'Gamble', 'pass');
INSERT INTO Regular VALUES (152, 8,144, 'Development', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (152, 8, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(153, 'Jesse', 'Sellers', 'other_pass');
INSERT INTO Manager VALUES (153, 8, 135);
INSERT INTO Employees VALUES(154, 'Libby', 'Frost', 'pass');
INSERT INTO Regular VALUES (154, 8,153, 'Networking', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (154, 8, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(155, 'Jensen', 'Kane', 'pass');
INSERT INTO Regular VALUES (155, 8,153, 'BusinessIntelligence', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (155, 8, 'Assigning tasks to resources', 0);
INSERT INTO Employees VALUES(156, 'Harry', 'Cruz', 'pass');
INSERT INTO Regular VALUES (156, 8,153, 'Networking', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (156, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(157, 'Luciana', 'Peck', 'pass');
INSERT INTO Regular VALUES (157, 8,153, 'BusinessIntelligence', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (157, 8, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(158, 'Norah', 'Clark', 'pass');
INSERT INTO Regular VALUES (158, 8,153, 'Design', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (158, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(159, 'Adison', 'Drake', 'pass');
INSERT INTO Regular VALUES (159, 8,153, 'UI', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (159, 8, 'Allocating a dedicated point of contact', 0);
INSERT INTO Employees VALUES(160, 'Konnor', 'Shelton', 'pass');
INSERT INTO Regular VALUES (160, 8,153, 'Development', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (160, 8, 'Provisioning of resources', 0);
