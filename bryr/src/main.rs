use std::{io::{self, BufRead}, collections::{HashMap, HashSet}};

fn add_edge(a: i32, b: i32, single_lane: bool, edges: &mut HashMap<i32, Vec<(i32, bool)>>) {
    if !edges.contains_key(&a) {
        edges.insert(a, Vec::new());
    } 
    let edge_set = edges.get_mut(&a).unwrap();
    edge_set.push((b, single_lane));
}

fn main() {
    let stdin = io::stdin();

    let mut edges : HashMap<i32, Vec<(i32, bool)>> = HashMap::new();
    let mut first_line = true;
    let mut n : i32 = 0;
    // Use older compiler to spot that we need to lock before lines
    for line in stdin.lock().lines().map(|l| l.unwrap()) {
        if first_line {
            first_line = false;
            let split = line.split_once(' ');
            n = split.unwrap().0.parse().unwrap();
            continue;
        }
        let nums: Vec<i32> = line.split_whitespace()
            .map(|num| num.parse().unwrap())
            .collect();
        let a = nums[0];
        let b = nums[1];
        let single_lane = nums[2] == 1;
        add_edge(a, b, single_lane, &mut edges);
        add_edge(b, a, single_lane, &mut edges);
    }

    // Shortest path from 1 to n
    let mut visited : HashSet<i32> = HashSet::new();

    let mut pay_set : Vec<i32> = Vec::new();
    let mut free_set : Vec<i32> = Vec::new();
    free_set.push(1);

    let mut counter = 0;
    while !free_set.is_empty() {
        let p = free_set.pop().unwrap();
        visited.insert(p);
        if p == n {
            println!("{counter}");
            break;
        }

        // Traverse all outgoing edges from p
        for (q, single_lane) in edges.get(&p).unwrap() { // Safe because we can assume the graph is coherent
            

            // println!("p = {p} - q = {q} - single_lane = {single_lane}");
            if !visited.contains(q) {
                if *single_lane {
                    pay_set.push(*q);
                } else {
                    free_set.push(*q);
                }
            }
        }

        if free_set.is_empty() { 
            let tmp = free_set;
            free_set = pay_set;
            pay_set = tmp;
            counter += 1;
        }
    }


    // }

}