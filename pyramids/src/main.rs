use std::io;

fn main() {
    let stdin = io::stdin();
    let mut line = String::new();
    stdin.read_line(&mut line).unwrap();
    let block_count = line.trim().parse::<i32>().unwrap();

    let mut curr_width = 1;
    let mut curr_height = 0;
    let mut curr_blocks = 0;
    loop {
        curr_blocks += curr_width * curr_width;
        if curr_blocks > block_count {
            break;
        }
        curr_height += 1;
        curr_width += 2;
    }

    println!("{curr_height}");




}
