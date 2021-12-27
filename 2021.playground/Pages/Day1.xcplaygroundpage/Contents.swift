import Foundation

let startTime = NSDate()

let day1 = Day1()
day1.part1()
day1.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
