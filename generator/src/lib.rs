#![feature(attr_literals, nll)]

#[macro_use]
extern crate failure;
extern crate rand;
#[macro_use]
extern crate lazy_static;

pub mod streams;
pub mod models;

use rand::Rng;
use failure::Error;
use streams::{Stream};
use models::person::PersonName;
use models::ToSqls;
use models::client::{ClientName, Client};
use std::ops::Range;
use models::employee::SalesAssociate;
use rand::ThreadRng;
use models::client::Contract;
use models::employee::Supervisor;
use models::employee::Manager;
use models::employee::Regular;
use models::task::Task;

pub struct Generator {
	name_stream: Stream<PersonName>,
	client_name_stream: Stream<ClientName>,
	config: GeneratorConfig
}

#[derive(Clone)]
pub struct GeneratorConfig {
	sales_associate_range: Range<usize>,
	client_range: Range<usize>,
	contract_range: Range<usize>,
	manager_range: Range<usize>,
	regular_employee_range: Range<usize>
}

impl Default for GeneratorConfig {
	fn default() -> Self {
		Self {
			sales_associate_range: (4..6),
			client_range: (1..3),
			contract_range: (1..3),
			manager_range: (2..4),
			regular_employee_range: (5..9)
		}
	}
}

impl Generator {
	pub fn new(name_stream: Stream<PersonName>, client_name_stream: Stream<ClientName>, config: GeneratorConfig) -> Self {
		Self {
			name_stream,
			client_name_stream,
			config
		}
	}

	pub fn generate(&mut self) -> Result<String, Error> {
		let mut sqls = Vec::new();
		let mut random = rand::thread_rng();

		let mut employee_id = 1;
		let mut client_id = 1;
		let mut contract_id = 1;

		for _ in create_random_range(0, &self.config.sales_associate_range){
			let sales_associate = SalesAssociate::new(employee_id, self.name_stream.pop()?, "pass");
			employee_id += 1;
			sqls.append(&mut sales_associate.to_sqls());

			for _ in create_random_range(0, &self.config.client_range) {
				let client = Client::new(client_id, self.client_name_stream.pop()?, self.name_stream.pop()?);
				sqls.append(&mut client.to_sqls());
				client_id += 1;

				for _ in create_random_range(0, &self.config.contract_range) {
					let contract = Contract {
						id: contract_id,
						client_id: client.id,
						contact_num: String::from("5149108628"),
						acv: 0.0,
						ia: 0.0,
						start_date: String::from("2017-01-01"),
						service_type: String::from("Cloud"),
						contract_type: String::from("Premium"),
						line_of_business: String::from("CloudServices"),
						satisfaction_level: 5,
					};
					sqls.append(&mut contract.to_sqls());
					contract_id += 1;

					let supervisor = Supervisor::new(employee_id, self.name_stream.pop()?, "pass123", contract.id);
					sqls.append(&mut supervisor.to_sqls());
					employee_id += 1;

					for _ in create_random_range(0, &self.config.manager_range) {
						let manager = Manager::new(employee_id, self.name_stream.pop()?, "other_pass", contract.id, supervisor.employee.employee_id);
						sqls.append(&mut manager.to_sqls());
						employee_id += 1;

						for _ in create_random_range(0, &self.config.regular_employee_range) {
							let regular = Regular::new(employee_id, self.name_stream.pop()?, "pass",contract.id, "UI", "Normal", manager.employee.employee_id, "Gold");
							employee_id += 1;
							sqls.append(&mut regular.to_sqls());

							let task = Task {
								employee_id: regular.employee.employee_id,
								contract_id: contract.id,
								task_type: String::from("Set up infrastructure for client"),
								hours: 0
							};

							sqls.append(&mut task.to_sqls());

						}
					}
				}
			}
		}

		Ok(sqls.into_iter().fold(String::new(), |mut acc, next| {acc.push_str(&format!("{}\n", next));  acc}))
	}
}

pub fn create_random_range(start: usize, range: &Range<usize>) -> Range<usize> {
	(start..rand::thread_rng().gen_range(range.start, range.end))
}