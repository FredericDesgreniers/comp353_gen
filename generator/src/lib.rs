#![feature(attr_literals)]

#[macro_use]
extern crate failure;
extern crate rand;

pub mod streams;
pub mod models;

use streams::{Stream, names::PersonName};
use models::person::PersonName;

pub struct Generator {
	name_stream: Stream<PersonName>
}

impl Generator {
	pub fn new(name_stream: Stream<PersonName>) -> Self {
		Self {
			name_stream
		}
	}
}