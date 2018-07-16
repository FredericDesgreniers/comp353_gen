use failure::Error;
use std::fs::File;
use std::io::BufReader;
use std::io::BufRead;

#[derive(Debug)]
pub struct Employee {
	pub first_name: String,
	pub last_name: String
}

impl Employee {
	pub fn from_text(text: &str) -> Result<Employee, String> {

		let (first_name, last_name) = text.split_at(text.find(" ").ok_or(String::from("Incomplete name"))?);

		Ok(Employee {
			first_name: first_name.to_string(),
			last_name: last_name.to_string()
		})
	}
}

pub fn read_employees() -> Result<Vec<Employee>, Error> {
	let employees_file = File::open("employees.txt")?;
	let employee_reader = BufReader::new(&employees_file);

	let employees = employee_reader.lines().filter_map(|line| {
		if let Ok(line) = line {
			let employee = Employee::from_text(&line);

			match employee {
				Ok(employee) => {
					Some(employee)
				},
				Err(error) => {
					println!("{:?}", error);
					None
				}
			}
		} else {
			None
		}
	}).collect::<Vec<Employee>>();

	Ok(employees)
}