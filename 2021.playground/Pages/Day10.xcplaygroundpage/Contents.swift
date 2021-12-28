import Foundation

let startTime = NSDate()

let day10 = Day10()
day10.part1()
day10.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
