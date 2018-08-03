use models::ToSqls;

pub struct Task {
    pub employee_id: usize,
    pub contract_id: usize,
    pub task_type: String,
    pub hours: usize
}

impl ToSqls for Task {
    fn to_sqls(&self) -> Vec<String> {
        vec![
            format!("INSERT INTO Tasks VALUES ({employee_id}, {contract_id}, '{task_type}', {hours});",
                employee_id=self.employee_id,
                contract_id=self.contract_id,
                task_type=self.task_type,
                hours=self.hours
            )
        ]
    }
}
