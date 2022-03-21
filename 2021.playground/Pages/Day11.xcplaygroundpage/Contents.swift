import Foundation

let startTime = NSDate()

let day11 = Day11()
day11.part1()
day11.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
