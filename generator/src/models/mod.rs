pub mod person;
pub mod client;
pub mod employee;
pub mod task;

pub trait ToSqls {
    fn to_sqls(&self) -> Vec<String>;
}