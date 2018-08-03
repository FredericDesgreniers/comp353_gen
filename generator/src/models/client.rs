use super::person::PersonName;
use models::ToSqls;

pub struct ClientName(pub String);

pub struct Client {
	pub id: usize,
	pub name: ClientName,
	pub representative: PersonName,
	pub email: String,
	pub city: String,
	pub province: String,
	pub postal_code: String,
	pub password: String,
}
impl Client {
	pub fn new(id: usize, name: ClientName, representative: PersonName) -> Self {
		let email = format!("{}_{}@{}.com", representative.first, representative.last, name.0);
		let city = String::from("Montreal");
		let province = String::from("QC");
		let postal_code = String::from("xxxxxx");
		let password = String::from("pass");

		Self {
			id,
			name,
			representative,
			email,
			city,
			province,
			postal_code,
			password
		}
	}
}

impl ToSqls for Client {
	fn to_sqls(&self) -> Vec<String> {
		vec![
			format!("INSERT INTO Clients VALUES ({id}, '{name}', '{rep_fn}', '{rep_mn}', '{rep_ln}', '{email}', '{city}', '{province}', '{postal_code}', '{password}');",
				id=self.id,
				name=self.name,
				rep_fn=self.representative.first,
				rep_mn=self.representative.middle,
				rep_ln=self.representative.last,
				email=self.email,
				city=self.city,
				province=self.province,
				postal_code=self.postal_code,
				password=self.password
			)
		]
	}
}

pub struct Contract {
	pub id: usize,
	pub client_id: usize,
	pub contact_num: String,
	pub acv: f64,
	pub ia: f64,
	pub start_date: String,
	pub service_type: String,
	pub contract_type: String,
	pub line_of_business: String,
	pub satisfaction_level: usize
}

impl ToSqls for Contract {
	fn to_sqls(&self) -> Vec<String> {
        vec![
			format!("INSERT INTO Contracts VALUES ({id}, {client_id}, '{contact_num}', {acv}, {ia}, '{start_date}', '{service_type}', '{contract_type}', '{line_of_business}', {satisfaction_level});",
				id=self.id,
				client_id=self.client_id,
				contact_num=self.contact_num,
				acv=self.acv,
				ia=self.ia,
				start_date=self.start_date,
				service_type=self.service_type,
				contract_type=self.contract_type,
				line_of_business=self.line_of_business,
				satisfaction_level=self.satisfaction_level
			)
		]
	}
}