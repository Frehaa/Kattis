use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    let mut values : Vec<u64> = Vec::new();
    for line in stdin.lock().lines().map(|l| l.unwrap()) {
        if line == "0 0 0 0" { break }
        let nums: Vec<u64> = line.split_whitespace()
            .map(|num| num.parse().unwrap())
            .collect();
        let initial_position = nums[0];
        let first_position = nums[1];
        let second_position = nums[2];
        let third_position = nums[3];

        let degrees_per_mark = 9; // 360 / 40;
        let marks = 40;

        /* stop at the first number of the combination */ 
        let marks_to_first_position = if first_position > initial_position {
            first_position - initial_position
        } else {
            marks - initial_position + first_position
        };

        /* continue turning counter-clockwise until the 2nd number is reached */ 
        let marks_to_second_position = if first_position > second_position {
            first_position - second_position
        } else {
            first_position + marks - second_position
        };

        /* turn the dial clockwise again until the 3rd number is reached */
        let marks_to_third_position = if third_position > second_position {
            third_position - second_position
        } else {
            marks - second_position + third_position
        };

        println!("{} - {} - {} ", marks_to_first_position, marks_to_second_position, marks_to_third_position);

        values.push(/* turn the dial clockwise 2 full turns */ 2 * marks * degrees_per_mark  + 
                    marks_to_first_position * degrees_per_mark + 
                    /* turn the dial counter-clockwise 1 full turn */ 1 * marks * degrees_per_mark + 
                    marks_to_second_position * degrees_per_mark + 
                    marks_to_third_position * degrees_per_mark
        );

        println!("{} - {} ", line, values.last().unwrap());

    }

    let result : Vec<String> = values.iter().map(|v| v.to_string()).collect();
    println!("{}", result.join("\n"));

}