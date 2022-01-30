import Foundation

let startTime = NSDate()

let day21 = Day21()
day21.part1()
day21.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
