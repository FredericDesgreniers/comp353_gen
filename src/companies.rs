use failure::Error;
use std::fs::File;
use std::io::BufRead;
use std::io::BufReader;

#[derive(Debug)]
pub struct Company {
    pub name: String,
    pub first_name: String,
    pub last_name: String,
    pub city: String,
    pub province: String,
    pub postal_code: String,
}

impl Company {
    pub fn from_text(text: &str) -> Result<Self, String> {
        let mut parts = text.split(" ");

        let name = parts.next().ok_or(String::from("Empty line?"))?.to_string();
        let first_name = parts
            .next()
            .ok_or(String::from("No first name"))?
            .to_string();
        let last_name = parts
            .next()
            .ok_or(String::from("No last name"))?
            .to_string();

        let city = parts.next().ok_or(String::from("No city"))?.to_string();
        let province = parts.next().ok_or(String::from("No province"))?.to_string();
        let postal_code = parts
            .next()
            .ok_or(String::from("No postal code"))?
            .to_string();

        Ok(Self {
            name,
            first_name,
            last_name,
            city,
            province,
            postal_code,
        })
    }
}

pub fn read_companies() -> Result<Vec<Company>, Error> {
    let companies_file = File::open("companies.txt")?;
    let company_reader = BufReader::new(&companies_file);

    let companies = company_reader
        .lines()
        .filter_map(|line| {
            if let Ok(line) = line {
                let company = Company::from_text(&line);

                match company {
                    Ok(company) => Some(company),
                    Err(error) => {
                        println!("{:?}", error);
                        None
                    }
                }
            } else {
                None
            }
        })
        .collect::<Vec<Company>>();

    Ok(companies)
}
