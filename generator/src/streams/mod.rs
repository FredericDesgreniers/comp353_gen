use std::io::{BufReader, BufRead};
use std::fs::File;
use failure::Error;
use std::fmt::Display;
use std::fmt::Formatter;

pub mod names;

#[derive(Debug, Fail)]
pub enum ParserError {
	#[fail(display = "Could not parse {}", 0)]
	ParsingError(String)
}

pub trait Parser {
	type Output;

	fn parse(input: &str) -> Result<Self::Output, ParserError>;
}


#[derive(Debug, Fail)]
pub enum StreamError {
	#[fail(display = "No names remaining...")]
	EmptyStream
}

pub struct Stream<T: Parser, S> {
	reader: BufReader<File>,
	buffer: Vec<T::Output>,
	buffer_len: usize,
	state: S
}

impl<'a, T: Parser, S> Stream<T, S> {
	pub fn from_file(file: File) -> Self {
		Self {
			reader: BufReader::new(file),
			buffer: Vec::new(),
			buffer_len: 20
		}
	}

	pub fn pop(&mut self) -> Result<T::Output, StreamError> {
		if let Some(name) = self.buffer.pop() {
			Ok(name)
		} else {
			self.refill()?;
			self.pop()
		}
	}

	pub fn refill(&mut self) -> Result<(), StreamError> {
		while self.buffer.len() < self.buffer_len {
			let mut line = String::new();
			let read = self.reader.read_line(&mut line);

			if let Ok(read) = read {

				if read == 0 {
					break;
				}

				let line = line.trim();

				match T::parse(line) {
					Ok(name) => self.buffer.push(name),
					Err(err) => println!("Error parsing: {:?}", err),
				}
			}
		}

		if self.buffer.is_empty() {
			return Err(StreamError::EmptyStream);
		}

		Ok(())
	}

	pub fn iter(&'a mut self) -> StreamRefIterator<'a, T> {
		StreamRefIterator {
			name_stream: self
		}
	}
}

impl<T: Parser> IntoIterator for Stream<T> {
	type Item = T::Output;
	type IntoIter = StreamIterator<T>;

	fn into_iter(self) -> <Self as IntoIterator>::IntoIter {
		StreamIterator {
			name_stream: self
		}
	}
}

pub struct StreamIterator<T: Parser> {
	name_stream: Stream<T>
}

impl<T: Parser> Iterator for StreamIterator<T> {
	type Item = T::Output;

	fn next(&mut self) -> Option<<Self as Iterator>::Item> {
		self.name_stream.pop().ok()
	}
}

pub struct StreamRefIterator<'a, T: 'a + Parser> {
	name_stream: &'a mut Stream<T>
}

impl<'a, T: Parser> Iterator for StreamRefIterator<'a, T> {
	type Item = T::Output;

	fn next(&mut self) -> Option<<Self as Iterator>::Item> {
		self.name_stream.pop().ok()
	}
}
