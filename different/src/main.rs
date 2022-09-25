use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    let mut values : Vec<i64> = Vec::new();
    for line in stdin.lock().lines().map(|l| l.unwrap()) {
        let nums: Vec<i64> = line.split_whitespace()
            .map(|num| num.parse().unwrap())
            .collect();
        let a = nums[0];
        let b = nums[1];
        values.push((a-b).abs());
    }
    let lines :Vec<String> = values.iter().map(|v| v.to_string()).collect();
    println!("{}", lines.join("\n"));
}