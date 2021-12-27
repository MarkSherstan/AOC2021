import Foundation

let startTime = NSDate()

let day4 = Day4()
day4.part1()
day4.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
