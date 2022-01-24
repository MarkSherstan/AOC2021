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
    var dice: Dice
    var P1: Player
    var P2: Player

    // Initial position and dice
    public init() {
        self.dice = Dice()
        self.P1 = Player(pos: 1)    // Example: 4
        self.P2 = Player(pos: 2)    // Example: 8
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
    
    // Part 1
    public func part1() {
        print("Part 1: ", play())
    }

    // Part 2
    public func part2() {
        print("Part 2: ", 000)
    }
}
