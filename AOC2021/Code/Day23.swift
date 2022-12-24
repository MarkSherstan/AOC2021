//
//  Day23.swift
//  AOC2021
//
//  Created by Mark Sherstan on 2022-08-25.
//

import Foundation

class Day23 {
    let ennergyMapping: [String: Int] = ["A": 1, "B": 10, "C": 100, "D": 1000]
    let roomMapping: [String: Int] = ["A": 2, "B": 4, "C": 6, "D": 8]
    let roomPositions: [Int] = [2, 4, 6, 8]
    
//    init() {
//        // Load in data (do this parsing later)
//        let url = Bundle.main.url(forResource: "Day23", withExtension: "txt")!
//        let input = try! String(contentsOf: url).split(separator: "\n")
//    }
    
//    func getPodFromRoom(_ room: [String]) -> String? {
//        for x in room {
//            if x != "." {
//                return x
//            }
//        }
//        return nil
//    }
    
    // Check if path is blocked
    func canReach(board: [String], startPos: Int, endPos: Int) -> Bool {
        let low = min(startPos, endPos)
        let high = max(startPos, endPos)
        
        for pos in low...high {
            if pos == startPos {
                continue
            }
            if roomPositions.contains(pos) {
                
            }
            if board[pos] != "." {
                return false
            }
        }
        
        return true
    }
    
    func possibleMoves(board: [String], pos: Int) {
        let x = board[pos]
        
        if !roomPositions.contains(pos) {
            print("")
        }
    }
    
    func solve(_ board: [String]) -> Int {
        var states: [[String]: Int] = [board: 0]
        
        var queue = [board]
        while !queue.isEmpty {
            let board = queue.removeLast()

            for (pos, pod) in board.enumerated() {
                if pod == "." {
                    continue
                }
                
                
                
                
            }
        }
                    
        print(board)

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
