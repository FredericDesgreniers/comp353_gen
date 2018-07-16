DROP TABLE Employees;
DROP TABLE Contracts;
DROP TABLE Companies;
CREATE TABLE Companies(
         companyId int NOT NULL AUTO_INCREMENT,
         companyName varchar(255),
         repFirstName varchar(255),
         repMiddleInital varchar(5),
         repLastName varchar(255),
         emailId varchar(255),
         city varchar(255),
         province varchar(255),
         postalCode varchar(255),
         PRIMARY KEY (companyId)
);
CREATE TABLE Contracts(
        contractId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
        companyId int NOT NULL,
        FOREIGN KEY(companyId) REFERENCES Companies(companyId),
        contactNumber varchar(15) NOT NULL,
        annualContractValue double NOT NULL,
        initalAmount double NOT NULL,
        serviceStartDate DATE NOT NULL,
        serviceType ENUM('Cloud','On-premises') NOT NULL,
        premiumType ENUM('Premium','Gold','Diamond','Silver') NOT NULL
);
CREATE TABLE Employees (
        employeeId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        is_manager BOOL NOT NULL,
        department ENUM('Development', 'QA', 'UI', 'Design', 'BusinessIntelligence', 'Networking')  NOT NULL,
		firstName VARCHAR(255) NOT NULL,
		lastName VARCHAR(255) NOT NULL,
        contractId INT NOT NULL,
        FOREIGN KEY (contractId) REFERENCES Contracts(contractId)
);
INSERT INTO Companies VALUES(1, 'Google', 'Sundar', NULL, 'Pichai', 'Sundar_Pichai@Google.com', 'MountainView', 'CA', 'J2L3D2');
INSERT INTO Contracts VALUES(1, 1 ,'1840477001', 64814.00, 4645.00, '2016-12-12', 'On-premises', 'Gold');
INSERT INTO Employees VALUES(0, 1, 'Design', 'Salvador', ' Foster', 1);
INSERT INTO Employees VALUES(0, 0, 'Networking', 'Michelle', ' Christensen', 1);
INSERT INTO Employees VALUES(0, 0, 'Development', 'Barbara', ' Rowe', 1);
INSERT INTO Employees VALUES(0, 0, 'Development', 'Heather', ' Phelps', 1);
INSERT INTO Employees VALUES(0, 0, 'UI', 'Alma', ' Pena', 1);
INSERT INTO Contracts VALUES(2, 1 ,'6390189615', 49978.00, 4505.00, '2018-12-01', 'Cloud', 'Gold');
INSERT INTO Employees VALUES(0, 1, 'BusinessIntelligence', 'Mike', ' Cain', 2);
INSERT INTO Employees VALUES(0, 0, 'Development', 'Myron', ' Blake', 2);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Kari', ' Griffin', 2);
INSERT INTO Employees VALUES(0, 0, 'Development', 'Kristi', ' Powers', 2);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Silvia', ' Lowe', 2);
INSERT INTO Employees VALUES(0, 0, 'BusinessIntelligence', 'Derrick', ' Bailey', 2);
INSERT INTO Employees VALUES(0, 0, 'Development', 'Brandy', ' Cummings', 2);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Glen', ' Herrera', 2);
INSERT INTO Employees VALUES(0, 0, 'BusinessIntelligence', 'Reginald', ' Black', 2);
INSERT INTO Employees VALUES(0, 0, 'QA', 'Luther', ' Reyes', 2);
INSERT INTO Contracts VALUES(3, 1 ,'9606118635', 113260.00, 7427.00, '2018-05-12', 'Cloud', 'Gold');
INSERT INTO Employees VALUES(0, 1, 'QA', 'Andres', ' Moore', 3);
INSERT INTO Employees VALUES(0, 0, 'Networking', 'Delbert', ' Franklin', 3);
INSERT INTO Employees VALUES(0, 0, 'UI', 'Samantha', ' Hodges', 3);
INSERT INTO Employees VALUES(0, 0, 'QA', 'Felicia', ' Kelley', 3);
INSERT INTO Employees VALUES(0, 0, 'BusinessIntelligence', 'Elbert', ' Hamilton', 3);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Joseph', ' Woods', 3);
INSERT INTO Employees VALUES(0, 0, 'Networking', 'Cynthia', ' Moss', 3);
INSERT INTO Contracts VALUES(4, 1 ,'7870157735', 88267.00, 11286.00, '2016-02-14', 'On-premises', 'Diamond');
INSERT INTO Employees VALUES(0, 1, 'Design', 'Lucas', ' Edwards', 4);
INSERT INTO Employees VALUES(0, 0, 'Networking', 'Maria', ' Logan', 4);
INSERT INTO Employees VALUES(0, 0, 'QA', 'Eva', ' Massey', 4);
INSERT INTO Employees VALUES(0, 0, 'Development', 'Ellen', ' Abbott', 4);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Irving', ' Vega', 4);
INSERT INTO Employees VALUES(0, 0, 'QA', 'Helen', ' Hogan', 4);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Cary', ' Gill', 4);
INSERT INTO Employees VALUES(0, 0, 'QA', 'Mamie', ' Mullins', 4);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Martin', ' Payne', 4);
INSERT INTO Employees VALUES(0, 0, 'Networking', 'Terrence', ' Copeland', 4);
INSERT INTO Employees VALUES(0, 0, 'BusinessIntelligence', 'Jaime', ' Cross', 4);
INSERT INTO Companies VALUES(2, 'Apple', 'Tim', NULL, 'Cook', 'Tim_Cook@Apple.com', 'Cupertino', 'CA', 'T2P4Y5');
INSERT INTO Contracts VALUES(5, 2 ,'8527676734', 122838.00, 1588.00, '2016-12-12', 'Cloud', 'Gold');
INSERT INTO Employees VALUES(0, 1, 'QA', 'Lila', ' Gibbs', 5);
INSERT INTO Employees VALUES(0, 0, 'Networking', 'Terry', ' Patterson', 5);
INSERT INTO Employees VALUES(0, 0, 'QA', 'Dave', ' Dean', 5);
INSERT INTO Employees VALUES(0, 0, 'BusinessIntelligence', 'Perry', ' Richards', 5);
INSERT INTO Employees VALUES(0, 0, 'QA', 'Edith', ' Dunn', 5);
INSERT INTO Employees VALUES(0, 0, 'Development', 'Kelli', ' Stephens', 5);
INSERT INTO Employees VALUES(0, 0, 'Networking', 'Kim', ' Brewer', 5);
INSERT INTO Contracts VALUES(6, 2 ,'5873949633', 95974.00, 10090.00, '2018-01-07', 'Cloud', 'Premium');
INSERT INTO Employees VALUES(0, 1, 'UI', 'Fernando', ' Klein', 6);
INSERT INTO Employees VALUES(0, 0, 'Development', 'Beulah', ' Walton', 6);
INSERT INTO Employees VALUES(0, 0, 'UI', 'Susan', ' Martin', 6);
INSERT INTO Employees VALUES(0, 0, 'Networking', 'Merle', ' Wilkins', 6);
INSERT INTO Employees VALUES(0, 0, 'Networking', 'Bernice', ' Little', 6);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Erin', ' Ray', 6);
INSERT INTO Employees VALUES(0, 0, 'BusinessIntelligence', 'Alfredo', ' Marsh', 6);
INSERT INTO Employees VALUES(0, 0, 'Networking', 'Jeannette', ' Dennis', 6);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Jerry', ' Poole', 6);
INSERT INTO Contracts VALUES(7, 2 ,'9841883438', 74684.00, 678.00, '2017-04-10', 'Cloud', 'Diamond');
INSERT INTO Employees VALUES(0, 1, 'Networking', 'Javier', ' Malone', 7);
INSERT INTO Employees VALUES(0, 0, 'Development', 'Timothy', ' Figueroa', 7);
INSERT INTO Employees VALUES(0, 0, 'Networking', 'Darrel', ' Vasquez', 7);
INSERT INTO Employees VALUES(0, 0, 'BusinessIntelligence', 'Alicia', ' Martinez', 7);
INSERT INTO Employees VALUES(0, 0, 'BusinessIntelligence', 'Marjorie', ' Montgomery', 7);
INSERT INTO Contracts VALUES(8, 2 ,'5563972150', 142183.00, 9239.00, '2018-10-21', 'On-premises', 'Gold');
INSERT INTO Employees VALUES(0, 1, 'QA', 'Curtis', ' Garrett', 8);
INSERT INTO Employees VALUES(0, 0, 'QA', 'Johnny', ' Barnes', 8);
INSERT INTO Employees VALUES(0, 0, 'QA', 'Ashley', ' Dawson', 8);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Monica', ' Fields', 8);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Johanna', ' Nguyen', 8);
INSERT INTO Employees VALUES(0, 0, 'QA', 'Kellie', ' Delgado', 8);
INSERT INTO Employees VALUES(0, 0, 'UI', 'Lorenzo', ' Townsend', 8);
INSERT INTO Employees VALUES(0, 0, 'Development', 'Julie', ' Drake', 8);
INSERT INTO Employees VALUES(0, 0, 'UI', 'Jan', ' Neal', 8);
INSERT INTO Companies VALUES(3, 'Nike', 'Mark', NULL, 'Parker', 'Mark_Parker@Nike.com', 'Beaverton', 'OR', 'J4I2H8');
INSERT INTO Contracts VALUES(9, 3 ,'5132307540', 108625.00, 13776.00, '2017-12-27', 'On-premises', 'Gold');
INSERT INTO Employees VALUES(0, 1, 'UI', 'Lola', ' Hansen', 9);
INSERT INTO Employees VALUES(0, 0, 'BusinessIntelligence', 'Rosemarie', ' Roberts', 9);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Antonio', ' Young', 9);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Lynette', ' Greene', 9);
INSERT INTO Employees VALUES(0, 0, 'Development', 'Roxanne', ' Cook', 9);
INSERT INTO Companies VALUES(4, 'Facebook', 'Mark', NULL, 'Zuckerberg', 'Mark_Zuckerberg@Facebook.com', 'MonloPark', 'CA', 'I9E2H3');
INSERT INTO Contracts VALUES(10, 4 ,'7076041830', 70259.00, 3327.00, '2017-09-15', 'Cloud', 'Diamond');
INSERT INTO Employees VALUES(0, 1, 'Development', 'Marcella', ' Warner', 10);
INSERT INTO Employees VALUES(0, 0, 'Development', 'Darla', ' Chavez', 10);
INSERT INTO Employees VALUES(0, 0, 'Development', 'Margaret', ' Watts', 10);
INSERT INTO Employees VALUES(0, 0, 'Networking', 'Earnest', ' Gross', 10);
INSERT INTO Employees VALUES(0, 0, 'Networking', 'Connie', ' Cannon', 10);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Garry', ' Love', 10);
INSERT INTO Employees VALUES(0, 0, 'UI', 'Courtney', ' Gregory', 10);
INSERT INTO Employees VALUES(0, 0, 'QA', 'Taylor', ' Bennett', 10);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Damon', ' Flores', 10);
INSERT INTO Contracts VALUES(11, 4 ,'4543057111', 101327.00, 10669.00, '2016-12-09', 'On-premises', 'Silver');
INSERT INTO Employees VALUES(0, 1, 'Design', 'Tommy', ' Jimenez', 11);
INSERT INTO Employees VALUES(0, 0, 'Networking', 'Gretchen', ' Warren', 11);
INSERT INTO Employees VALUES(0, 0, 'Development', 'Rosalie', ' Ellis', 11);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Kirk', ' Baldwin', 11);
INSERT INTO Employees VALUES(0, 0, 'Development', 'Danielle', ' Berry', 11);
INSERT INTO Employees VALUES(0, 0, 'BusinessIntelligence', 'Jana', ' Ford', 11);
INSERT INTO Employees VALUES(0, 0, 'Development', 'Cory', ' Mathis', 11);
INSERT INTO Employees VALUES(0, 0, 'UI', 'Dora', ' Wong', 11);
INSERT INTO Contracts VALUES(12, 4 ,'8875309811', 76463.00, 9878.00, '2016-06-23', 'On-premises', 'Diamond');
INSERT INTO Employees VALUES(0, 1, 'QA', 'Daniel', ' Mccarthy', 12);
INSERT INTO Employees VALUES(0, 0, 'QA', 'Tasha', ' Chapman', 12);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Bethany', ' Sparks', 12);
INSERT INTO Employees VALUES(0, 0, 'QA', 'Elisa', ' Padilla', 12);
INSERT INTO Employees VALUES(0, 0, 'Networking', 'Wendy', ' Miles', 12);
INSERT INTO Employees VALUES(0, 0, 'QA', 'Nichole', ' Fox', 12);
INSERT INTO Employees VALUES(0, 0, 'Design', 'Wm', ' Jensen', 12);
INSERT INTO Employees VALUES(0, 0, 'QA', 'Marlene', ' Garcia', 12);
INSERT INTO Employees VALUES(0, 0, 'UI', 'Rosemary', ' Evans', 12);
