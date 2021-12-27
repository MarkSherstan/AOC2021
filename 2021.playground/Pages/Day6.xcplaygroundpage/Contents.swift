import Foundation

let startTime = NSDate()

let day6 = Day6()
day6.part1()
day6.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
