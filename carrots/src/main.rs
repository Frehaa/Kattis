use std::io;

fn main() {
    let stdin = io::stdin();
    let mut line = String::new();
    stdin.read_line(&mut line).unwrap();
    let num = line.split_whitespace().nth(1);

    println!("{}", num.unwrap());
}
