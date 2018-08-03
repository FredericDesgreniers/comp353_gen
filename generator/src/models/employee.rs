use models::person::PersonName;
use models::ToSqls;

pub struct Employee {
    pub employee_id: usize,
    pub name: PersonName,
    pub password: String,
}

impl ToSqls for Employee {
    fn to_sqls(&self) -> Vec<String> {
        vec![
            format!("INSERT INTO Employees VALUES({id}, '{first_name}', '{last_name}', '{password}');",
                    id=self.employee_id,
                    first_name=self.name.first,
                    last_name=self.name.last,
                    password=self.password
            )
        ]
    }
}

pub struct SalesAssociate {
    pub employee: Employee
}

impl ToSqls for SalesAssociate {
    fn to_sqls(&self) -> Vec<String> {
        let mut employee_sql = self.employee.to_sqls();
        employee_sql.push(format!("INSERT INTO SalesAssociate VALUES({id});",
                id=self.employee.employee_id
        ));

        employee_sql
    }
}

impl SalesAssociate {
    pub fn new(employee_id: usize, name: PersonName, password: &str) -> Self {
        Self {
            employee: Employee {
                employee_id,
                name,
                password: password.to_string()
            }
        }
    }
}

pub struct Admin {
    pub employee: Employee
}

impl Admin {
    pub fn new(employee_id: usize, name: PersonName, password: &str) -> Self {
        Self {
            employee: Employee {
                employee_id,
                name,
                password: password.to_string()
            }
        }
    }
}

impl ToSqls for Admin {
    fn to_sqls(&self) -> Vec<String> {
        let mut sql = self.employee.to_sqls();
        sql.push(format!("INSERT INTO Admins VALUES ({id});", id=self.employee.employee_id));

        sql
    }
}

pub struct Supervisor {
    pub employee: Employee,
    pub contract_id: usize,
}

impl Supervisor {
    pub fn new(employee_id: usize, name: PersonName, password: &str, contract_id: usize) -> Self {
        Self {
            employee: Employee {
                employee_id,
                name,
                password: password.to_string()
            },
            contract_id,
        }
    }
}

impl ToSqls for Supervisor {
    fn to_sqls(&self) -> Vec<String> {
        let mut sql = self.employee.to_sqls();
        sql.push(format!("INSERT INTO Supervisor VALUES ({id}, {contract_id});",
                         id=self.employee.employee_id,
                         contract_id=self.contract_id
        ));

        sql
    }
}

pub struct Manager {
    pub employee: Employee,
    pub contract_id: usize,
    pub managed_by: usize
}

impl Manager {
    pub fn new(employee_id: usize, name: PersonName, password: &str, contract_id: usize, managed_by: usize) -> Self {
        Self {
            employee: Employee {
                employee_id,
                name,
                password: password.to_string()
            },
            contract_id,
            managed_by
        }
    }
}

impl ToSqls for Manager {
    fn to_sqls(&self) -> Vec<String> {
        let mut sql = self.employee.to_sqls();
        sql.push(format!("INSERT INTO Manager VALUES ({id}, {contract_id}, {managed_by});",
                         id=self.employee.employee_id,
                         contract_id=self.contract_id,
                         managed_by=self.managed_by
        ));

        sql
    }
}
pub struct Regular {
    pub employee: Employee,
    pub contract_id: usize,
    pub department: String,
    pub insurance: String,
    pub managed_by: usize,
    pub desired_contract_type: String
}


impl Regular {
    pub fn new(employee_id: usize, name: PersonName, password: &str, contract_id: usize, department: &str, insurance: &str, managed_by: usize, desired_contract_type: &str) -> Self {
        Self {
            employee: Employee {
                employee_id,
                name,
                password: password.to_string()
            },
            contract_id,
            department: department.to_string(),
            insurance: insurance.to_string(),
            managed_by,
            desired_contract_type: desired_contract_type.to_string()
        }
    }
}

impl ToSqls for Regular {
    fn to_sqls(&self) -> Vec<String> {
        let mut sql = self.employee.to_sqls();
        sql.push(format!("INSERT INTO Regular VALUES ({id}, {contract_id},{managed_by}, '{department}', '{insurance}', '{desired}');",
                         id=self.employee.employee_id,
                         contract_id=self.contract_id,
                         department=self.department,
                         insurance=self.insurance,
                         managed_by = self.managed_by,
                         desired=self.desired_contract_type
        ));

        sql
    }
}