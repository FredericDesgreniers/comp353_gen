DROP TABLE Employees;
DROP TABLE Contracts;
DROP TABLE Companies;
DROP TABLE Tasks; 

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
        employeeType ENUM('Supervisor', 'Manager', 'Normal') NOT NULL,
        department ENUM('Development', 'QA', 'UI', 'Design', 'BusinessIntelligence', 'Networking')  NOT NULL,
		firstName VARCHAR(255) NOT NULL,
		lastName VARCHAR(255) NOT NULL,
        contractId INT NOT NULL,
        lineOfBusiness ENUM('CloudServices', 'Development', 'Research'),
        superiorId INT DEFAULT NULL,
        FOREIGN KEY (contractId) REFERENCES Contracts(contractId),
        FOREIGN KEY (superiorId) REFERENCES Employees(employeeId) 
);

CREATE TABLE Tasks {
    taskId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    taskType ENUM('InfrastructureSetUp', 'ProvisioningResources', 'AssigningTasksToResources', 'AllocatingDedicatedPointOfContact') NOT NULL
    employeeId INT NOT NULL,
    loggedHours INT DEFAULT 0

    FOREIGN KEY (employeeId) REFERENCES Employees(employeeId)
}