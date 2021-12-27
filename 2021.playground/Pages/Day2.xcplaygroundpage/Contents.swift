import Foundation

let startTime = NSDate()

let day2 = Day2()
day2.part1()
day2.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
