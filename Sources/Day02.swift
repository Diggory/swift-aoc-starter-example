//  https://adventofcode.com/2025/day/2

import Algorithms
import Foundation

package struct Day02: AdventDay {
  let dayNumeral = "02"

  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  /// Load challenge data from file in the Data folder
  func loadData() -> String? {
    let moduleBundle = Bundle.module
    if let dataFileURL = moduleBundle.url(forResource: "Data/Day\(dayNumeral)", withExtension: "txt") {
      if let fileContents = try? String(contentsOf: dataFileURL) {
        return fileContents
      }
    }
    return nil
  }





  //MARK: - Answer functions

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    print("Day 2")

    print("=======")
    print("PART 1")
    print("=======")

    return 0
  }







  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {

    print("=======")
    print("PART 2")
    print("=======")


    //  Load the data
    guard let data = loadData() else {
      print("could not load day's data from file...")
      return 0
    }

    return 0
  }


}
