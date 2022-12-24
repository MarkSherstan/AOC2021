//
//  Day23.swift
//  AOC2021
//
//  Created by Mark Sherstan on 2022-08-25.
//

import Foundation

class Day23 {
    let roomLocation: [String: Int] = ["A": 2, "B": 4, "C": 6, "D": 8]
    let moveEnergy: [String: Int] = ["A": 1, "B": 10, "C": 100, "D": 1000]
    
//    init() {
//        // Load in data (do this parsing later)
//        let url = Bundle.main.url(forResource: "Day23", withExtension: "txt")!
//        let input = try! String(contentsOf: url).split(separator: "\n")
//    }
    
    func solve(_ board: [String]) -> Int {
        var states: [[String]: Int] = [board: 0]
        
        var queue = [board]
        while !queue.isEmpty {
            let board = queue.removeLast()

                    
            print(board)
        }
        
        return 1
    }
    
    func part1() -> String {
        let board = [".", ".", "BA", ".", "CD", ".", "BC", ".", "DA", ".", "."]
        
        let sol = solve(board)
        print(sol)
        return String(sol)
    }
    
    func part2() -> String {
        return "B"
    }
}
