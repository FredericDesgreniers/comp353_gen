extern crate failure;
extern crate rand;
extern crate generator;

use failure::Error;

use rand::distributions::range::{Range, SampleRange};
use rand::prelude::*;
use rand::thread_rng;
use std::fs::File;

use generator::streams::Stream;
use generator::models::person::PersonName;
use generator::models::client::ClientName;
use generator::Generator;
use std::io::Write;

fn main() -> Result<(), Error> {
	let mut name_generator: Stream<PersonName> = Stream::from_file(File::open("employees.txt")?);
	let client_name_generator: Stream<ClientName> = Stream::from_file(File::open("companies.txt")?);

	let mut generator = Generator::new(name_generator, client_name_generator, Default::default());
	let result = generator.generate();

	let mut output_file = File::create("out.sql")?;

	output_file.write_all(b"

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
");

	output_file.write_all(result.unwrap().as_bytes());

	Ok(())
}


