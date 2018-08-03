
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
INSERT INTO Contracts VALUES (1, 1, '5149108628', 0, 0, '2017-01-01', 'On-premises', 'Diamond', 'CloudServices', 5);
INSERT INTO Employees VALUES(2, 'Celeste', 'Guerrero', 'pass123');
INSERT INTO Supervisor VALUES (2, 1);
INSERT INTO Employees VALUES(3, 'Lorelai', 'Schneider', 'other_pass');
INSERT INTO Manager VALUES (3, 1, 2);
INSERT INTO Employees VALUES(4, 'Simone', 'Miller', 'pass');
INSERT INTO Regular VALUES (4, 1,3, 'QA', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (4, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(5, 'Jaelyn', 'Lopez', 'pass');
INSERT INTO Regular VALUES (5, 1,3, 'Networking', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (5, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(6, 'Brooks', 'Shepard', 'pass');
INSERT INTO Regular VALUES (6, 1,3, 'QA', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (6, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(7, 'Nikhil', 'Becker', 'pass');
INSERT INTO Regular VALUES (7, 1,3, 'Networking', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (7, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(8, 'Kathleen', 'Melton', 'pass');
INSERT INTO Regular VALUES (8, 1,3, 'UI', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (8, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(9, 'Sarai', 'Hays', 'other_pass');
INSERT INTO Manager VALUES (9, 1, 2);
INSERT INTO Employees VALUES(10, 'Meredith', 'Barber', 'pass');
INSERT INTO Regular VALUES (10, 1,9, 'BusinessIntelligence', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (10, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(11, 'Wilson', 'Hancock', 'pass');
INSERT INTO Regular VALUES (11, 1,9, 'Networking', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (11, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(12, 'Virginia', 'Franco', 'pass');
INSERT INTO Regular VALUES (12, 1,9, 'BusinessIntelligence', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (12, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(13, 'Tripp', 'Salinas', 'pass');
INSERT INTO Regular VALUES (13, 1,9, 'Networking', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (13, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(14, 'Kinsley', 'Logan', 'pass');
INSERT INTO Regular VALUES (14, 1,9, 'Networking', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (14, 1, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(15, 'Tabitha', 'Benjamin', 'pass');
INSERT INTO SalesAssociate VALUES(15);
INSERT INTO Clients VALUES (2, 'WeMakeWebsites', 'Santiago', '', 'Pace', 'Santiago_Pace@WeMakeWebsites.com', 'Montreal', 'QC', 'xxxxxx', 'pass');
INSERT INTO Contracts VALUES (2, 2, '5149108628', 0, 0, '2017-01-01', 'On-premises', 'Gold', 'Research', 5);
INSERT INTO Employees VALUES(16, 'Jerry', 'Estes', 'pass123');
INSERT INTO Supervisor VALUES (16, 2);
INSERT INTO Employees VALUES(17, 'Giancarlo', 'Randolph', 'other_pass');
INSERT INTO Manager VALUES (17, 2, 16);
INSERT INTO Employees VALUES(18, 'Kailee', 'Downs', 'pass');
INSERT INTO Regular VALUES (18, 2,17, 'Networking', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (18, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(19, 'Joaquin', 'Le', 'pass');
INSERT INTO Regular VALUES (19, 2,17, 'UI', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (19, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(20, 'Jaida', 'Watkins', 'pass');
INSERT INTO Regular VALUES (20, 2,17, 'Networking', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (20, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(21, 'Jaylyn', 'Bridges', 'pass');
INSERT INTO Regular VALUES (21, 2,17, 'UI', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (21, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(22, 'Yoselin', 'Best', 'pass');
INSERT INTO Regular VALUES (22, 2,17, 'Design', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (22, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(23, 'Layla', 'Boyd', 'pass');
INSERT INTO Regular VALUES (23, 2,17, 'BusinessIntelligence', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (23, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(24, 'Mila', 'Whitney', 'other_pass');
INSERT INTO Manager VALUES (24, 2, 16);
INSERT INTO Employees VALUES(25, 'Heidy', 'Maldonado', 'pass');
INSERT INTO Regular VALUES (25, 2,24, 'Design', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (25, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(26, 'Robert', 'Villegas', 'pass');
INSERT INTO Regular VALUES (26, 2,24, 'BusinessIntelligence', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (26, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(27, 'Brodie', 'Hammond', 'pass');
INSERT INTO Regular VALUES (27, 2,24, 'Design', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (27, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(28, 'Emery', 'Rivas', 'pass');
INSERT INTO Regular VALUES (28, 2,24, 'Networking', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (28, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(29, 'Brianna', 'Dickson', 'pass');
INSERT INTO Regular VALUES (29, 2,24, 'UI', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (29, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(30, 'Yosef', 'Rollins', 'pass');
INSERT INTO Regular VALUES (30, 2,24, 'QA', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (30, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(31, 'Milagros', 'Lozano', 'pass');
INSERT INTO Regular VALUES (31, 2,24, 'Development', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (31, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(32, 'Skylar', 'Griffith', 'pass');
INSERT INTO Regular VALUES (32, 2,24, 'UI', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (32, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(33, 'Maximo', 'Hampton', 'other_pass');
INSERT INTO Manager VALUES (33, 2, 16);
INSERT INTO Employees VALUES(34, 'Luis', 'Benton', 'pass');
INSERT INTO Regular VALUES (34, 2,33, 'Development', 'Silver', 'Gold');
INSERT INTO Tasks VALUES (34, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(35, 'Adrian', 'Carey', 'pass');
INSERT INTO Regular VALUES (35, 2,33, 'QA', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (35, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(36, 'Micaela', 'Moreno', 'pass');
INSERT INTO Regular VALUES (36, 2,33, 'BusinessIntelligence', 'Premium', 'Gold');
INSERT INTO Tasks VALUES (36, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(37, 'Bailee', 'Carney', 'pass');
INSERT INTO Regular VALUES (37, 2,33, 'QA', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (37, 2, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(38, 'Jabari', 'Mahoney', 'pass');
INSERT INTO Regular VALUES (38, 2,33, 'Design', 'Normal', 'Gold');
INSERT INTO Tasks VALUES (38, 2, 'Set up infrastructure for client', 0);
INSERT INTO Contracts VALUES (3, 2, '5149108628', 0, 0, '2017-01-01', 'On-premises', 'Premium', 'CloudServices', 5);
INSERT INTO Employees VALUES(39, 'Nikolas', 'Ellison', 'pass123');
INSERT INTO Supervisor VALUES (39, 3);
INSERT INTO Employees VALUES(40, 'Allison', 'King', 'other_pass');
INSERT INTO Manager VALUES (40, 3, 39);
INSERT INTO Employees VALUES(41, 'Jude', 'Ward', 'pass');
INSERT INTO Regular VALUES (41, 3,40, 'Development', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (41, 3, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(42, 'Ryleigh', 'Riddle', 'pass');
INSERT INTO Regular VALUES (42, 3,40, 'Design', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (42, 3, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(43, 'Kylan', 'Hinton', 'pass');
INSERT INTO Regular VALUES (43, 3,40, 'BusinessIntelligence', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (43, 3, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(44, 'Ansley', 'Clarke', 'pass');
INSERT INTO Regular VALUES (44, 3,40, 'QA', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (44, 3, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(45, 'Yazmin', 'Murillo', 'pass');
INSERT INTO Regular VALUES (45, 3,40, 'Networking', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (45, 3, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(46, 'Eve', 'Gillespie', 'pass');
INSERT INTO Regular VALUES (46, 3,40, 'Design', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (46, 3, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(47, 'Jorge', 'Clay', 'pass');
INSERT INTO Regular VALUES (47, 3,40, 'QA', 'Silver', 'Premium');
INSERT INTO Tasks VALUES (47, 3, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(48, 'Brogan', 'Fuentes', 'pass');
INSERT INTO Regular VALUES (48, 3,40, 'Design', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (48, 3, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(49, 'Max', 'Grimes', 'other_pass');
INSERT INTO Manager VALUES (49, 3, 39);
INSERT INTO Employees VALUES(50, 'Nicolas', 'Sherman', 'pass');
INSERT INTO Regular VALUES (50, 3,49, 'UI', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (50, 3, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(51, 'Ariella', 'Ortiz', 'pass');
INSERT INTO Regular VALUES (51, 3,49, 'Development', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (51, 3, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(52, 'Barbara', 'Solis', 'pass');
INSERT INTO Regular VALUES (52, 3,49, 'QA', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (52, 3, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(53, 'Brynn', 'Benitez', 'pass');
INSERT INTO Regular VALUES (53, 3,49, 'Design', 'Normal', 'Premium');
INSERT INTO Tasks VALUES (53, 3, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(54, 'Timothy', 'Holmes', 'pass');
INSERT INTO Regular VALUES (54, 3,49, 'Networking', 'Premium', 'Premium');
INSERT INTO Tasks VALUES (54, 3, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(55, 'Kyle', 'Mathis', 'pass');
INSERT INTO SalesAssociate VALUES(55);
INSERT INTO Clients VALUES (3, 'Cloud Solutions', 'Carley', '', 'Flores', 'Carley_Flores@Cloud Solutions.com', 'Montreal', 'QC', 'xxxxxx', 'pass');
INSERT INTO Contracts VALUES (4, 3, '5149108628', 0, 0, '2017-01-01', 'On-premises', 'Silver', 'Development', 5);
INSERT INTO Employees VALUES(56, 'Cortez', 'Ponce', 'pass123');
INSERT INTO Supervisor VALUES (56, 4);
INSERT INTO Employees VALUES(57, 'Jasmine', 'Jones', 'other_pass');
INSERT INTO Manager VALUES (57, 4, 56);
INSERT INTO Employees VALUES(58, 'Neveah', 'Davenport', 'pass');
INSERT INTO Regular VALUES (58, 4,57, 'Networking', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (58, 4, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(59, 'Tucker', 'Pena', 'pass');
INSERT INTO Regular VALUES (59, 4,57, 'QA', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (59, 4, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(60, 'Ann', 'Curry', 'pass');
INSERT INTO Regular VALUES (60, 4,57, 'Development', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (60, 4, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(61, 'Jillian', 'Shepherd', 'pass');
INSERT INTO Regular VALUES (61, 4,57, 'Development', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (61, 4, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(62, 'Conner', 'Bennett', 'pass');
INSERT INTO Regular VALUES (62, 4,57, 'QA', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (62, 4, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(63, 'Londyn', 'Harrell', 'other_pass');
INSERT INTO Manager VALUES (63, 4, 56);
INSERT INTO Employees VALUES(64, 'Armani', 'Preston', 'pass');
INSERT INTO Regular VALUES (64, 4,63, 'Design', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (64, 4, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(65, 'Marie', 'Reid', 'pass');
INSERT INTO Regular VALUES (65, 4,63, 'QA', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (65, 4, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(66, 'River', 'Mitchell', 'pass');
INSERT INTO Regular VALUES (66, 4,63, 'Design', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (66, 4, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(67, 'Cristal', 'Bradford', 'pass');
INSERT INTO Regular VALUES (67, 4,63, 'Development', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (67, 4, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(68, 'Lailah', 'Valentine', 'pass');
INSERT INTO Regular VALUES (68, 4,63, 'BusinessIntelligence', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (68, 4, 'Set up infrastructure for client', 0);
INSERT INTO Clients VALUES (4, 'Google', 'Miguel', '', 'Owens', 'Miguel_Owens@Google.com', 'Montreal', 'QC', 'xxxxxx', 'pass');
INSERT INTO Contracts VALUES (5, 4, '5149108628', 0, 0, '2017-01-01', 'On-premises', 'Diamond', 'Research', 5);
INSERT INTO Employees VALUES(69, 'Alberto', 'Montgomery', 'pass123');
INSERT INTO Supervisor VALUES (69, 5);
INSERT INTO Employees VALUES(70, 'Samson', 'Roth', 'other_pass');
INSERT INTO Manager VALUES (70, 5, 69);
INSERT INTO Employees VALUES(71, 'Elyse', 'Collins', 'pass');
INSERT INTO Regular VALUES (71, 5,70, 'UI', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (71, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(72, 'Chase', 'Edwards', 'pass');
INSERT INTO Regular VALUES (72, 5,70, 'Development', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (72, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(73, 'Tamia', 'Mullins', 'pass');
INSERT INTO Regular VALUES (73, 5,70, 'UI', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (73, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(74, 'Walker', 'Spence', 'pass');
INSERT INTO Regular VALUES (74, 5,70, 'Design', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (74, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(75, 'Diana', 'Elliott', 'pass');
INSERT INTO Regular VALUES (75, 5,70, 'UI', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (75, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(76, 'Dalia', 'Davidson', 'pass');
INSERT INTO Regular VALUES (76, 5,70, 'Development', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (76, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(77, 'Quinten', 'Larsen', 'pass');
INSERT INTO Regular VALUES (77, 5,70, 'Development', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (77, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(78, 'Hadassah', 'Brandt', 'pass');
INSERT INTO Regular VALUES (78, 5,70, 'Development', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (78, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(79, 'Tristin', 'Hendricks', 'other_pass');
INSERT INTO Manager VALUES (79, 5, 69);
INSERT INTO Employees VALUES(80, 'Dulce', 'Benson', 'pass');
INSERT INTO Regular VALUES (80, 5,79, 'QA', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (80, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(81, 'Krish', 'Simmons', 'pass');
INSERT INTO Regular VALUES (81, 5,79, 'UI', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (81, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(82, 'Taryn', 'Graham', 'pass');
INSERT INTO Regular VALUES (82, 5,79, 'Development', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (82, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(83, 'Jazlene', 'Tapia', 'pass');
INSERT INTO Regular VALUES (83, 5,79, 'Networking', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (83, 5, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(84, 'Nehemiah', 'Wiley', 'pass');
INSERT INTO Regular VALUES (84, 5,79, 'Development', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (84, 5, 'Set up infrastructure for client', 0);
INSERT INTO Contracts VALUES (6, 4, '5149108628', 0, 0, '2017-01-01', 'On-premises', 'Diamond', 'CloudServices', 5);
INSERT INTO Employees VALUES(85, 'Arnav', 'Silva', 'pass123');
INSERT INTO Supervisor VALUES (85, 6);
INSERT INTO Employees VALUES(86, 'Deven', 'Palmer', 'other_pass');
INSERT INTO Manager VALUES (86, 6, 85);
INSERT INTO Employees VALUES(87, 'Sam', 'Park', 'pass');
INSERT INTO Regular VALUES (87, 6,86, 'QA', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (87, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(88, 'Brayan', 'Baird', 'pass');
INSERT INTO Regular VALUES (88, 6,86, 'QA', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (88, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(89, 'Isabella', 'Robles', 'pass');
INSERT INTO Regular VALUES (89, 6,86, 'UI', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (89, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(90, 'Angie', 'Avery', 'pass');
INSERT INTO Regular VALUES (90, 6,86, 'Development', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (90, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(91, 'Madalyn', 'Stokes', 'pass');
INSERT INTO Regular VALUES (91, 6,86, 'Development', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (91, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(92, 'Madyson', 'Nunez', 'other_pass');
INSERT INTO Manager VALUES (92, 6, 85);
INSERT INTO Employees VALUES(93, 'Giada', 'Greene', 'pass');
INSERT INTO Regular VALUES (93, 6,92, 'QA', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (93, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(94, 'Lilly', 'Stark', 'pass');
INSERT INTO Regular VALUES (94, 6,92, 'QA', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (94, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(95, 'Jayvon', 'Gutierrez', 'pass');
INSERT INTO Regular VALUES (95, 6,92, 'QA', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (95, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(96, 'Breanna', 'Bowman', 'pass');
INSERT INTO Regular VALUES (96, 6,92, 'Design', 'Normal', 'Diamond');
INSERT INTO Tasks VALUES (96, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(97, 'Landen', 'Hardin', 'pass');
INSERT INTO Regular VALUES (97, 6,92, 'BusinessIntelligence', 'Premium', 'Diamond');
INSERT INTO Tasks VALUES (97, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(98, 'Hayden', 'Hurst', 'pass');
INSERT INTO Regular VALUES (98, 6,92, 'Development', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (98, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(99, 'Houston', 'Barnett', 'pass');
INSERT INTO Regular VALUES (99, 6,92, 'Networking', 'Silver', 'Diamond');
INSERT INTO Tasks VALUES (99, 6, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(100, 'Marquis', 'Hooper', 'pass');
INSERT INTO SalesAssociate VALUES(100);
INSERT INTO Clients VALUES (5, 'Facebook', 'Ezekiel', '', 'Lewis', 'Ezekiel_Lewis@Facebook.com', 'Montreal', 'QC', 'xxxxxx', 'pass');
INSERT INTO Contracts VALUES (7, 5, '5149108628', 0, 0, '2017-01-01', 'On-premises', 'Silver', 'CloudServices', 5);
INSERT INTO Employees VALUES(101, 'Cristofer', 'Gilmore', 'pass123');
INSERT INTO Supervisor VALUES (101, 7);
INSERT INTO Employees VALUES(102, 'Nora', 'Wall', 'other_pass');
INSERT INTO Manager VALUES (102, 7, 101);
INSERT INTO Employees VALUES(103, 'Fabian', 'Maxwell', 'pass');
INSERT INTO Regular VALUES (103, 7,102, 'UI', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (103, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(104, 'Callum', 'Green', 'pass');
INSERT INTO Regular VALUES (104, 7,102, 'BusinessIntelligence', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (104, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(105, 'Savannah', 'Finley', 'pass');
INSERT INTO Regular VALUES (105, 7,102, 'BusinessIntelligence', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (105, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(106, 'Carmelo', 'Hudson', 'pass');
INSERT INTO Regular VALUES (106, 7,102, 'Development', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (106, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(107, 'Phillip', 'Duran', 'pass');
INSERT INTO Regular VALUES (107, 7,102, 'UI', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (107, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(108, 'Alfred', 'Villanueva', 'pass');
INSERT INTO Regular VALUES (108, 7,102, 'BusinessIntelligence', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (108, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(109, 'Kamari', 'Daugherty', 'pass');
INSERT INTO Regular VALUES (109, 7,102, 'BusinessIntelligence', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (109, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(110, 'Arthur', 'Leonard', 'other_pass');
INSERT INTO Manager VALUES (110, 7, 101);
INSERT INTO Employees VALUES(111, 'Roman', 'Guerra', 'pass');
INSERT INTO Regular VALUES (111, 7,110, 'Development', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (111, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(112, 'Miles', 'Schmitt', 'pass');
INSERT INTO Regular VALUES (112, 7,110, 'QA', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (112, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(113, 'Maya', 'Mosley', 'pass');
INSERT INTO Regular VALUES (113, 7,110, 'UI', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (113, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(114, 'Allen', 'Floyd', 'pass');
INSERT INTO Regular VALUES (114, 7,110, 'Networking', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (114, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(115, 'Raelynn', 'Burch', 'pass');
INSERT INTO Regular VALUES (115, 7,110, 'QA', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (115, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(116, 'Paige', 'Grant', 'pass');
INSERT INTO Regular VALUES (116, 7,110, 'UI', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (116, 7, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(117, 'Jamiya', 'Holland', 'pass');
INSERT INTO Regular VALUES (117, 7,110, 'Design', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (117, 7, 'Set up infrastructure for client', 0);
INSERT INTO Clients VALUES (6, 'Twitterm', 'Carson', '', 'Solomon', 'Carson_Solomon@Twitterm.com', 'Montreal', 'QC', 'xxxxxx', 'pass');
INSERT INTO Contracts VALUES (8, 6, '5149108628', 0, 0, '2017-01-01', 'Cloud', 'Silver', 'Research', 5);
INSERT INTO Employees VALUES(118, 'Quentin', 'Ellis', 'pass123');
INSERT INTO Supervisor VALUES (118, 8);
INSERT INTO Employees VALUES(119, 'Lilia', 'Bartlett', 'other_pass');
INSERT INTO Manager VALUES (119, 8, 118);
INSERT INTO Employees VALUES(120, 'Maia', 'Stephens', 'pass');
INSERT INTO Regular VALUES (120, 8,119, 'UI', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (120, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(121, 'Alma', 'Serrano', 'pass');
INSERT INTO Regular VALUES (121, 8,119, 'Development', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (121, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(122, 'Willie', 'Chavez', 'pass');
INSERT INTO Regular VALUES (122, 8,119, 'Development', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (122, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(123, 'Antony', 'Kline', 'pass');
INSERT INTO Regular VALUES (123, 8,119, 'BusinessIntelligence', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (123, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(124, 'Irene', 'Duncan', 'pass');
INSERT INTO Regular VALUES (124, 8,119, 'QA', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (124, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(125, 'Maggie', 'Henry', 'pass');
INSERT INTO Regular VALUES (125, 8,119, 'Networking', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (125, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(126, 'Gregory', 'Madden', 'pass');
INSERT INTO Regular VALUES (126, 8,119, 'QA', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (126, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(127, 'Danielle', 'Mcdowell', 'pass');
INSERT INTO Regular VALUES (127, 8,119, 'Development', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (127, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(128, 'Rayna', 'Montoya', 'other_pass');
INSERT INTO Manager VALUES (128, 8, 118);
INSERT INTO Employees VALUES(129, 'Alissa', 'Douglas', 'pass');
INSERT INTO Regular VALUES (129, 8,128, 'QA', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (129, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(130, 'Kamron', 'Doyle', 'pass');
INSERT INTO Regular VALUES (130, 8,128, 'BusinessIntelligence', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (130, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(131, 'Evangeline', 'Leblanc', 'pass');
INSERT INTO Regular VALUES (131, 8,128, 'Design', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (131, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(132, 'Kelton', 'Cannon', 'pass');
INSERT INTO Regular VALUES (132, 8,128, 'QA', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (132, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(133, 'Trevin', 'Cantrell', 'pass');
INSERT INTO Regular VALUES (133, 8,128, 'QA', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (133, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(134, 'Grace', 'Shea', 'pass');
INSERT INTO Regular VALUES (134, 8,128, 'Design', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (134, 8, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(135, 'Colt', 'Mcgrath', 'pass');
INSERT INTO Regular VALUES (135, 8,128, 'QA', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (135, 8, 'Set up infrastructure for client', 0);
INSERT INTO Contracts VALUES (9, 6, '5149108628', 0, 0, '2017-01-01', 'On-premises', 'Silver', 'Development', 5);
INSERT INTO Employees VALUES(136, 'Jamie', 'Burke', 'pass123');
INSERT INTO Supervisor VALUES (136, 9);
INSERT INTO Employees VALUES(137, 'Regina', 'Delacruz', 'other_pass');
INSERT INTO Manager VALUES (137, 9, 136);
INSERT INTO Employees VALUES(138, 'Jaelynn', 'Dodson', 'pass');
INSERT INTO Regular VALUES (138, 9,137, 'Networking', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (138, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(139, 'Collin', 'George', 'pass');
INSERT INTO Regular VALUES (139, 9,137, 'QA', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (139, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(140, 'Savanna', 'Hobbs', 'pass');
INSERT INTO Regular VALUES (140, 9,137, 'UI', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (140, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(141, 'Vance', 'Ross', 'pass');
INSERT INTO Regular VALUES (141, 9,137, 'Networking', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (141, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(142, 'Tiara', 'Castaneda', 'pass');
INSERT INTO Regular VALUES (142, 9,137, 'Design', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (142, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(143, 'Makai', 'Adkins', 'pass');
INSERT INTO Regular VALUES (143, 9,137, 'QA', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (143, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(144, 'Krystal', 'Walton', 'pass');
INSERT INTO Regular VALUES (144, 9,137, 'Design', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (144, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(145, 'Georgia', 'Trevino', 'pass');
INSERT INTO Regular VALUES (145, 9,137, 'Design', 'Premium', 'Silver');
INSERT INTO Tasks VALUES (145, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(146, 'Brandon', 'Kidd', 'other_pass');
INSERT INTO Manager VALUES (146, 9, 136);
INSERT INTO Employees VALUES(147, 'Kieran', 'Dougherty', 'pass');
INSERT INTO Regular VALUES (147, 9,146, 'QA', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (147, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(148, 'Kasey', 'Powell', 'pass');
INSERT INTO Regular VALUES (148, 9,146, 'UI', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (148, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(149, 'Lane', 'Dawson', 'pass');
INSERT INTO Regular VALUES (149, 9,146, 'Development', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (149, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(150, 'Addison', 'Waller', 'pass');
INSERT INTO Regular VALUES (150, 9,146, 'Development', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (150, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(151, 'Tony', 'Gamble', 'pass');
INSERT INTO Regular VALUES (151, 9,146, 'Design', 'Silver', 'Silver');
INSERT INTO Tasks VALUES (151, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(152, 'Jesse', 'Sellers', 'pass');
INSERT INTO Regular VALUES (152, 9,146, 'BusinessIntelligence', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (152, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(153, 'Libby', 'Frost', 'pass');
INSERT INTO Regular VALUES (153, 9,146, 'BusinessIntelligence', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (153, 9, 'Set up infrastructure for client', 0);
INSERT INTO Employees VALUES(154, 'Jensen', 'Kane', 'pass');
INSERT INTO Regular VALUES (154, 9,146, 'BusinessIntelligence', 'Normal', 'Silver');
INSERT INTO Tasks VALUES (154, 9, 'Set up infrastructure for client', 0);
