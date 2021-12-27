import Foundation

let startTime = NSDate()

let day3 = Day3()
day3.part1()
day3.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
