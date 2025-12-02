//  https://adventofcode.com/2025/day/2

import Algorithms
import Foundation

extension Int {

  ///  Number of digits
  var length: Int {
    return String(self).count
  }

  ///   Is the number a double number : e.g. 1234512345
  func hasBeenElfed() -> Bool {
    if !self.length.isMultiple(of: 2) {
      return false
    }
    let str = String(self)
    let front = String(str.prefix(self.length / 2))
    let back = str.suffix(self.length / 2)
    return front == back
  }

  ///   Is the number at least two copies of a sequence?
  func hasBeenElfed2() -> Bool {
    let str = String(self)

    let maxSeqLength = self.length / 2

//    if !self.length.isMultiple(of: 2) {
//      return false
//    }
    var seqLength = 1
    while seqLength <= maxSeqLength {
      let chunks = str.chunks(ofCount: seqLength)
      if chunks.allSatisfy({ $0 == chunks.first! }) {
        return true
      }
      seqLength+=1
    }
    return false
  }

}

package struct Day02: AdventDay {
  let dayNumeral = "02"

  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  /// Load challenge data from file in the Data folder
  func loadData() -> [ClosedRange<Int>]? {
    var ranges = [ClosedRange<Int>]()
    let moduleBundle = Bundle.module

    guard let dataFileURL = moduleBundle.url(forResource: "Data/Day\(dayNumeral)", withExtension: "txt") else {
      print("Unable to form URL for day data file name")
      return nil
    }
    guard let fileContents = try? String(contentsOf: dataFileURL) else {
      print("Unable to read file at URL: \(dataFileURL)")
      return nil
    }
    //  Remove trailing newline
    let noNewlines = fileContents.replacingOccurrences(of: "\n", with: "")
    let rangePairsAsStrings = noNewlines.split(separator: ",").map {$0.split(separator: "-")}
    for rangeAsStringPair in rangePairsAsStrings {
      if let start = Int(String(rangeAsStringPair[0])), let end = Int(String(rangeAsStringPair[1])) {
        let range = start...end
        print(range)
        ranges.append(range)
      } else {
        print("Unable to extract range from: \(rangeAsStringPair)")
      }
    }
    return ranges
  }

  func foo() {

  }



  //MARK: - Answer functions

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    print("Day 2")

    print("=======")
    print("PART 1")
    print("=======")

    guard let ranges = loadData() else {
      print("unable to load data from file...");
      return 0
    }
    //    print("loaded ranges: \(ranges)")

    //  Since the young Elf was just doing silly patterns, you can find the invalid IDs by looking for any ID which is made only of some sequence of digits repeated twice. So, 55 (5 twice), 6464 (64 twice), and 123123 (123 twice) would all be invalid IDs.
    //  None of the numbers have leading zeroes; 0101 isn't an ID at all. (101 is a valid ID that you would ignore.)

    var countOfElfedIDs = 0
    var sumOfElfedIDs = 0
    for range in ranges {
      for num in range {
        if num.hasBeenElfed() {
          print("elfed: \(num)")
          countOfElfedIDs+=1
          sumOfElfedIDs+=num
        }
      }
    }

    return sumOfElfedIDs
  }







  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {

    print("=======")
    print("PART 2")
    print("=======")

    guard let ranges = loadData() else {
      print("unable to load data from file...");
      return 0
    }

    var countOfElfedIDs = 0
    var sumOfElfedIDs = 0
    for range in ranges {
      for num in range {
        if num.hasBeenElfed2() {
//          print("elfed2: \(num)")
          countOfElfedIDs+=1
          sumOfElfedIDs+=num
        }
      }
    }
    return sumOfElfedIDs
  }


}
