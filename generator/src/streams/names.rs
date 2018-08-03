use std::fmt::Display;
use std::fmt::Formatter;
use super::{Parser,ParserError};
use models::person::PersonName;
use models::client::ClientName;


impl Display for PersonName {
	fn fmt(&self, f: &mut Formatter) -> Result<(), ::std::fmt::Error> {
		f.write_fmt(format_args!("{} {} {}", self.first, self.middle, self.last))?;
		Ok(())
	}
}

impl Parser for PersonName {
	type Output = Self;

	fn parse(input: &str) -> Result<Self::Output, ParserError> {
		let parts = input.split(' ').collect::<Vec<&str>>();

		if let Some(first) = parts.get(0) {
			let first = first.to_string();
			Ok(if parts.len() >= 3 {
				let middle = parts[1].to_string();
				let last = parts[2].to_string();

				Self {
					first,
					middle,
					last
				}
			} else if let Some(last) = parts.get(1) {
				let last = last.to_string();
				Self {
					first,
					middle: String::from(""),
					last
				}
			} else {
				Err(ParserError::ParsingError(String::from(format!("Input does not have a last name: {}", input))))?
			})
		} else {
			Err(ParserError::ParsingError(String::from("Input is empty")))?
		}
	}
}

impl Display for ClientName {
	fn fmt(&self, f: &mut Formatter) -> Result<(), ::std::fmt::Error> {
		f.write_fmt(format_args!("{}", self.0))?;

		Ok(())
	}
}

impl Parser for ClientName {
	type Output = ClientName;

	fn parse(input: &str) -> Result<<Self as Parser>::Output, ParserError> {
		Ok(ClientName(input.to_string()))
	}
}