//
//  Day23.swift
//  AOC2021
//
//  Created by Mark Sherstan on 2022-08-25.
//

import Foundation

class Day23 {
    // Vars
    let ennergyMapping: [String: Int] = ["A": 1, "B": 10, "C": 100, "D": 1000]
    let roomMapping: [String: Int] = ["A": 2, "B": 4, "C": 6, "D": 8]
    let roomPositions: [Int] = [2, 4, 6, 8]
    var p1Input: [String] = Array(repeating: ".", count: 11)
    var p2Input: [String] = Array(repeating: ".", count: 11)
    
    init() {
        // Load in data (minor hardcoded values)
        let url = Bundle.main.url(forResource: "Day23", withExtension: "txt")!
        let input = try! String(contentsOf: url).split(separator: "\n")
        let upper = input[2].replacingOccurrences(of: "#", with: "").replacingOccurrences(of: " ", with: "")
        let lower = input[3].replacingOccurrences(of: "#", with: "").replacingOccurrences(of: " ", with: "")
        let midUpper = "#D#C#B#A#".replacingOccurrences(of: "#", with: "")
        let midLower = "#D#B#A#C#".replacingOccurrences(of: "#", with: "")
        
        // Populate array with the sequenced data
        var idx = 2
        for i in 0..<upper.count {
            p1Input[idx] = String(upper[i]) + String(lower[i])
            p2Input[idx] = String(upper[i]) + String(midUpper[i]) + String(midLower[i]) + String(lower[i])
            idx += 2
        }
    }
    
    ///
    ///
    func getPodFromRoom(_ room: String) -> String? {
        for x in room {
            if x != "." {
                return String(x)
            }
        }
        return nil
    }
        
    /// Check if the path is clear
    /// - Returns: True if path is clear, false if blocked
    func canReach(board: [String], startPos: Int, endPos: Int) -> Bool {
        let low = min(startPos, endPos)
        let high = max(startPos, endPos)
        
        for pos in low...high {
            if pos == startPos {
                continue
            }
            if roomPositions.contains(pos) {
                continue
            }
            if board[pos] != "." {
                return false
            }
        }
        return true
    }
    
    /// Check if the room only contains the goal
    /// - Returns: True if room only contains goal or single goal and nothing else, false for any other case
    func roomOnlyContainsGoal(board: [String], x: String, desiredPos: Int) -> Bool {
        let inRoom = board[desiredPos]
        return inRoom.count == (inRoom.filter{$0 == "."}.count + inRoom.filter{String($0) == x}.count) // TODO: Is this effcient?
    }
    
    ///
    ///
    func possibleMoves(board: [String], pos: Int) -> [Int] {
        let x = board[pos]

        if !roomPositions.contains(pos) {
            if canReach(board: board, startPos: pos, endPos: roomMapping[x]!) && roomOnlyContainsGoal(board: board, x: x, desiredPos: roomMapping[x]!) {
                return [roomMapping[x]!]
            } else {
                return []
            }
        }
        
        let movingPod = getPodFromRoom(x)!
        if (pos == roomMapping[movingPod]) && roomOnlyContainsGoal(board: board, x: movingPod, desiredPos: pos) {
            return []
        }
        
        var possible: [Int] = []
        for dest in 0..<board.count {
            if dest == pos {
                continue
            }
            if roomPositions.contains(dest) && (roomMapping[movingPod] != dest) {
                continue
            }
            if roomMapping[movingPod] == dest {
                if !roomOnlyContainsGoal(board: board, x: movingPod, desiredPos: dest) {
                    continue
                }
            }
            if canReach(board: board, startPos: pos, endPos: dest) {
                possible.append(dest)
            }
        }
        return possible
    }
    
    func move(board: [String], pos: Int, dest: Int) -> ([String], Int) {
        // Vars
        var newBoard: [String] = board
        var dist = 0
        let movingPod = getPodFromRoom(board[pos])!
        
        // Logic
        if board[pos].count == 1 {
            newBoard[pos] = "."
        } else {
            var newRoom = ""
            var found = false
            
            for x in board[pos] {
                if x == "." {
                    dist += 1
                    newRoom.append(x)
                } else if !found {
                    dist += 1
                    newRoom.append(".")
                    found = true
                } else {
                    newRoom.append(x)
                }
            }
            newBoard[pos] = newRoom
        }
        
        dist += abs(pos - dest)
        
        if board[dest].count == 1 {
            newBoard[dest] = movingPod
            return (newBoard, dist * ennergyMapping[movingPod]!)
        } else {
            var room = Array(board[dest]).map{String($0)}
            let extraDist = room.filter({ $0 == "." }).count
            room[extraDist - 1] = movingPod
            dist += extraDist
            let temp = room.joined(separator: "")
            newBoard[dest] = temp
            return (newBoard, dist * ennergyMapping[movingPod]!)
        }
    }
    
    func solve(board: [String], goal: [String]) -> String {
        var states: [[String]: Int] = [board: 0]
        var queue = [board]
        
        while !queue.isEmpty {
            let board = queue.removeLast()

            for (pos, pod) in board.enumerated() {
                if getPodFromRoom(pod) == nil {
                    continue
                }
                let destinations = possibleMoves(board: board, pos: pos)

                for destination in destinations {
                    let (newBoard, extraCost) = move(board: board, pos: pos, dest: destination)
                    let newCost = states[board]! + extraCost
                    
                    var cost: Int
                    if let val = states[newBoard] {
                        cost = val
                    } else {
                        cost = Int.max
                    }
                    
                    if newCost < cost {
                        states[newBoard] = newCost
                        queue.append(newBoard)
                    }
                }
            }
        }
        return String(states[goal]!)
    }
    
    /// Part 1
    func part1() -> String {
        let goal = [".", ".", "AA", ".", "BB", ".", "CC", ".", "DD", ".", "."]
        return solve(board: p1Input, goal: goal)
    }
    
    /// Part 2
    func part2() -> String {
        let goal = [".", ".", "AAAA", ".", "BBBB", ".", "CCCC", ".", "DDDD", ".", "."]
        return solve(board: p2Input, goal: goal)
    }
}
