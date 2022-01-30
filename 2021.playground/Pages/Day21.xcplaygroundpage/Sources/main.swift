import Foundation

// Dice rolling
struct Dice {
    var val = 0
    var rolls = 0
 
    mutating func roll() -> Int {
        var total = 0
        
        for _ in 1...3 {
            self.val += 1
            
            if self.val > 100 {
                self.val = 1
            }
            
            self.rolls += 1
            total += self.val
        }

        return total
    }
}

// Player position and score
struct Player {
    var pos: Int
    var score = 0
    
    mutating func move(roll: Int) {
        if (self.pos + roll) % 10 == 0 {
            self.pos = 10
        } else {
            self.pos = (self.pos + roll) % 10
        }
        
        self.score += self.pos
    }
}

// Main logic
public class Day21 {
    // Part 1
    var dice: Dice
    var P1: Player
    var P2: Player
    
    // Part 2
    var rollSum2universeCount: [Int: Int] = [:]
    var master: [String: [Int]] = [:]   // [pos1 score1 pos2 score2 #uni]
    var result = [0, 0]

    // Initial position and dice
    public init() {
        // Part 1
        self.dice = Dice()
        self.P1 = Player(pos: 1)    // Example: 4
        self.P2 = Player(pos: 2)    // Example: 8
        
        // Part 2
        self.master["4|0|8|0"] = [4, 0, 8, 0, 1]    // Example: self.master["4|0|8|0"] = [4, 0, 8, 0, 1]
        
        // Combos for dice (27 possibilities but only 7 outcomes)
        for i in 1...3 {
            for j in 1...3 {
                for k in 1...3 {
                    let key = i + j + k
                    if self.rollSum2universeCount[key] == nil {
                        self.rollSum2universeCount[key] = 1
                    } else {
                        self.rollSum2universeCount[key]! += 1
                    }
                }
            }
        }
    }
    
    // Play function
    func play() -> Int {
        while true {
            let roll1 = dice.roll()
            P1.move(roll: roll1)
 
            if P1.score >= 1000 {
                return P2.score * dice.rolls
            }
            
            let roll2 = dice.roll()
            P2.move(roll: roll2)
            
            if P2.score >= 1000 {
                return P1.score * dice.rolls
            }
        }
    }
    
    // Play function part 2
    func play2(P1: Bool, master: inout [String: [Int]], result: inout [Int]) {
        var tempPos = 0
        var tempScore = 0
        
        for (key, value) in master {
            // Pop value being considered
            master[key] = nil
            
            // Get a position and score of interest
            if P1 {
                tempPos = value[0]
                tempScore = value[1]
            } else {
                tempPos = value[2]
                tempScore = value[3]
            }
            
            // Go through all dice combinations
            for (rollValue, uniCount) in rollSum2universeCount {
                // Dont overwrite master temp variables
                var localPos = tempPos
                var localScore = tempScore
                
                // Move on the board
                if (localPos + rollValue) % 10 == 0 {
                    localPos = 10
                } else {
                    localPos = (localPos + rollValue) % 10
                }
            
                // Update score
                localScore += localPos
                
                // Do we have a winner?
                if localScore > 20 {
                    if P1 {
                        result[0] += (uniCount * value[4])
                    } else {
                        result[1] += (uniCount * value[4])
                    }
                } else {
                    // Build key for dictionary
                    var masterKey = ""
                    if P1 {
                        masterKey = String(localPos) + "|" + String(localScore) + "|" + String(value[2]) + "|" + String(value[3])
                    } else {
                        masterKey = String(value[0]) + "|" + String(value[1]) + "|" + String(localPos) + "|" + String(localScore)
                    }
                    
                    // Update dictionary
                    if master[masterKey] == nil {
                        if P1 {
                            master[masterKey] = [localPos, localScore, value[2], value[3], uniCount * value[4]]
                        } else {
                            master[masterKey] = [value[0], value[1], localPos, localScore, uniCount * value[4]]
                        }
                    } else {
                        master[masterKey]![4] += (uniCount * value[4])
                    }
                }
            }
        }
    }
    
    // Part 1
    public func part1() {
        print("Part 1: ", play())
    }

    // Part 2
    public func part2() {
        // Loop until all games have won
        while !master.isEmpty {
            play2(P1: true, master: &master, result: &result)
            play2(P1: false, master: &master, result: &result)
            
            print(result, master.count)
        }

        // Results
        print("Part 2: ", result, 444356092776315/result[0], 341960390180808/result[1])
    }
}
