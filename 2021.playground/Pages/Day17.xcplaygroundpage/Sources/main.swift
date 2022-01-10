import Foundation

// Target/input struct
struct Target {
    let xMin: Int
    let xMax: Int
    let yMin: Int
    let yMax: Int
}

// Probe pos and vel struct
struct Probe {
    var xPos = 0
    var yPos = 0
    var xVel: Int
    var yVel: Int
}

public class Day17 {
    var target: Target

    // Assign Data
    public init() {
        // self.target = Target(xMin: 20, xMax: 30, yMin: -10, yMax: -5)
        self.target = Target(xMin: 124, xMax: 174, yMin: -123, yMax: -86)
    }

    // Func for moving the probe
    func step(probe: inout Probe) {
        // Update position
        probe.xPos += probe.xVel
        probe.yPos += probe.yVel
        
        // Update x velocity
        if probe.xVel > 0 {
            probe.xVel -= 1
        } else if probe.xVel < 0 {
            probe.xVel += 1
        }
        
        // Update y velocity
        probe.yVel -= 1
    }

    // Sim function
    func sim(xVel: Int, yVel: Int) -> Int {
        // Initial conditions
        var probe = Probe(xVel: xVel, yVel: yVel)
        var highest = 0

        while true {
            // Run simulation
            step(probe: &probe)
            
            // Keep track of highest position
            if probe.yPos > highest {
                highest = probe.yPos
            }
            
            // Overshoot exit condition
            if (probe.xVel == 0) && (probe.xPos < target.xMin) || (probe.xVel == 0) && (probe.xPos > target.xMax) {
                return -1
            }
            
            if probe.yPos < target.yMin {
                return -1
            }
            
            // Target location exit condition
            if (probe.xPos <= target.xMax) && (probe.xPos >= target.xMin) {
                if (probe.yPos <= target.yMax) && (probe.yPos >= target.yMin) {
                    return highest
                }
            }
        }
        
    }

    // Part 1
    public func part1() {
        // Run through combos
        var highest = 0

        for x in 0...target.xMax {
            for y in 0...1000 {
                let temp = sim(xVel: x, yVel: y)
                
                if temp > highest {
                    highest = temp
                }
            }
            print(x, target.xMax)
        }

        // Print results
        print("Part 1: ", highest)
    }

    // Part 2
    public func part2() {
        print("Part 2: ", 000)
    }
}
