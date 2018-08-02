extern crate failure;
extern crate rand;
extern crate generator;

use failure::Error;

use rand::distributions::range::{Range, SampleRange};
use rand::prelude::*;
use rand::thread_rng;
use std::fs::File;

use generator::names::Stream;
use generator::names::PersonName;

fn main() -> Result<(), Error> {
	let mut name_generator: Stream<PersonName> = Stream::from_file(File::open("employees.txt")?);

	name_generator.iter().enumerate().for_each(|name| println!("{} {}", name.0, name.1));

	Ok(())
}


