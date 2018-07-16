extern crate failure;
extern crate rand;

use failure::Error;

use rand::distributions::range::{Range, SampleRange};
use rand::prelude::*;
use rand::thread_rng;
use std::char;
use std::fs::File;
use std::io::BufWriter;
use std::io::Write;

mod companies;
mod employees;

const EMPLOYEE_TYPE: [&str; 6] = [
    "Development",
    "QA",
    "UI",
    "Design",
    "BusinessIntelligence",
    "Networking",
];

const SERVICE_TYPE: [&str; 2] = ["Cloud", "On-premises"];

const PREMIUM_TYPE: [&str; 4] = ["Premium", "Gold", "Diamond", "Silver"];

fn main() -> Result<(), Error> {
    let mut rng = thread_rng();

    let mut out = File::create("ini_data.sql")?;

    writeln!(out, "DROP TABLE Employees;")?;
    writeln!(out, "DROP TABLE Contracts;")?;
    writeln!(out, "DROP TABLE Companies;")?;

    writeln!(
        out,
        "CREATE TABLE Companies(
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
);"
    )?;

    writeln!(
        out,
        "CREATE TABLE Contracts(
        contractId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
        companyId int NOT NULL,
        FOREIGN KEY(companyId) REFERENCES Companies(companyId),
        contactNumber varchar(15) NOT NULL,
        annualContractValue double NOT NULL,
        initalAmount double NOT NULL,
        serviceStartDate DATE NOT NULL,
        serviceType ENUM('Cloud','On-premises') NOT NULL,
        premiumType ENUM('Premium','Gold','Diamond','Silver') NOT NULL
);"
    )?;

    writeln!(out, "CREATE TABLE Employees (
        employeeId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        is_manager BOOL NOT NULL,
        department ENUM('Development', 'QA', 'UI', 'Design', 'BusinessIntelligence', 'Networking')  NOT NULL,
		firstName VARCHAR(255) NOT NULL,
		lastName VARCHAR(255) NOT NULL,
        contractId INT NOT NULL,
        FOREIGN KEY (contractId) REFERENCES Contracts(contractId)
);")?;

    let companies = companies::read_companies()?;

    let mut employees = employees::read_employees()?;

    let mut last_contract_id = 1;
    let mut last_company_id = 1;

    let contract_rng = Range::new(1, 6);
    let employee_rng = Range::new(5, 12);

    for (index, company) in companies.into_iter().enumerate() {
        let email = format!(
            "{}_{}@{}.com",
            company.first_name, company.last_name, company.name
        );

        writeln!(out, "INSERT INTO Companies VALUES({id}, '{name}', '{first_name}', NULL, '{last_name}', '{email}', '{city}', '{province}', '{postal_code}');",
			id = last_company_id,
			name = company.name,
			first_name = company.first_name,
			last_name = company.last_name,
			email = email,
			city = company.city,
			province = company.province,
			postal_code = company.postal_code
		)?;

        let is_nike = company.name == "Nike";

        let number_of_contracts = if is_nike {
            1
        } else {
            contract_rng.sample(&mut rng)
        };

        for _ in 0..number_of_contracts {
            let contract_type = SERVICE_TYPE[rng.gen_range(0, SERVICE_TYPE.len())];
            let contract_level = if is_nike {
                "Gold"
            } else {
                PREMIUM_TYPE[rng.gen_range(0, PREMIUM_TYPE.len())]
            };

            let year = rng.gen_range::<usize>(2016, 2019);
            let month = rng.gen_range::<usize>(1, 13);

            let day = rng.gen_range::<usize>(0, 28);

            let date = format!("{:04}-{:02}-{:02}", year, month, day);

            let mut contact_num = String::new();

            for _ in 0..10 {
                contact_num.push(char::from_digit(rng.gen_range(0, 10), 10).unwrap());
            }

            writeln!(out, "INSERT INTO Contracts VALUES({id}, {company_id} ,'{contact_number}', {annual}.00, {initial}.00, '{date}', '{c_type}', '{c_level}');",
				id = last_contract_id,
				company_id = last_company_id,
				contact_number = contact_num,
				annual = rng.gen_range(45000, 150000),
				initial = rng.gen_range(500, 14000),
				date = date,
				c_type = contract_type,
				c_level = contract_level
			)?;

            let number_of_employees = employee_rng.sample(&mut rng);

            for i in 0..number_of_employees {
                let employee = employees.pop().unwrap();

                writeln!(out, "INSERT INTO Employees VALUES(0, {is_manager}, '{dep}', '{first_name}', '{last_name}', {contract_id});",
					dep = EMPLOYEE_TYPE[rng.gen_range(0, EMPLOYEE_TYPE.len())],
					is_manager = (i == 0) as i32,
					first_name = employee.first_name,
					last_name = employee.last_name,
					contract_id = last_contract_id
				)?;
            }

            last_contract_id += 1;
        }

        last_company_id += 1;
    }

    Ok(())
}
