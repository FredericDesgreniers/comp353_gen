use models::ToSqls;
use rand_field::RandField;

pub struct Task {
    pub employee_id: usize,
    pub contract_id: usize,
    pub task_type: TaskType,
    pub hours: usize
}

#[derive(Debug, RandField)]
#[choices("Set up infrastructure for client", "Provisioning of resources", "Assigning tasks to resources", "Allocating a dedicated point of contact")]
#[convert(from)]
pub struct TaskType(pub String);

impl ToSqls for Task {
    fn to_sqls(&self) -> Vec<String> {
        vec![
            format!("INSERT INTO Tasks VALUES ({employee_id}, {contract_id}, '{task_type}', {hours});",
                employee_id=self.employee_id,
                contract_id=self.contract_id,
                task_type=self.task_type.0,
                hours=self.hours
            )
        ]
    }
}
