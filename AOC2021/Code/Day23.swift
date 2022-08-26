//
//  Day23.swift
//  AOC2021
//
//  Created by Mark Sherstan on 2022-08-25.
//

import Foundation

class Day23 {
    init() {
        // Load in data
        let url = Bundle.main.url(forResource: "Day23", withExtension: "txt")!
        let input = try! String(contentsOf: url).split(separator: "\n")
        
        print(input)
    }
    
    func part1() -> String {
        return "A"
    }
    
    func part2() -> String {
        return "B"
    }
}
