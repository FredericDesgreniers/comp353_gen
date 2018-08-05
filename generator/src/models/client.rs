use super::person::PersonName;
use models::ToSqls;
use rand_field::RandField;
use rand::Rng;
use rand::ThreadRng;

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

#[derive(Clone, RandField)]
#[choices("Premium", "Gold", "Diamond", "Silver")]
#[convert(from)]
pub struct ContractType(pub String);

#[derive(RandField)]
#[choices("Cloud", "On-premises")]
#[convert(from)]
pub struct ServiceType(pub String);

#[derive(RandField)]
#[choices("CloudServices", "Development", "Research")]
#[convert(from)]
pub struct LineOfBusiness(pub String);

pub struct Date(pub String);

impl RandField for Date {
	fn random() -> Self {
		let mut rng = ::rand::thread_rng();

		let year = rng.gen_range(2015, 2019);
		let month = rng.gen_range(0, 12);
		let day = rng.gen_range(1, 28);

		Date(format!("{:04}-{:02}-{:02}", year, month, day))

	}
}

pub struct Contract {
	pub id: usize,
	pub client_id: usize,
	pub supervised_by: usize,
	pub contact_num: String,
	pub acv: f64,
	pub ia: f64,
	pub start_date: Date,
	pub service_type: ServiceType,
	pub contract_type: ContractType,
	pub line_of_business: LineOfBusiness,
	pub satisfaction_level: usize
}

impl ToSqls for Contract {
	fn to_sqls(&self) -> Vec<String> {
        vec![
			format!("INSERT INTO Contracts VALUES ({id}, {client_id}, {supervised_by}, '{contact_num}', {acv}, {ia}, '{start_date}', '{service_type}', '{contract_type}', '{line_of_business}', {satisfaction_level});",
				id=self.id,
				client_id=self.client_id,
				supervised_by=self.supervised_by,
				contact_num=self.contact_num,
				acv=self.acv,
				ia=self.ia,
				start_date=self.start_date.0,
				service_type=self.service_type.0,
				contract_type=self.contract_type.0,
				line_of_business=self.line_of_business.0,
				satisfaction_level=self.satisfaction_level
			)
		]
	}
}