//  https://adventofcode.com/2025/day/1

import Algorithms
import Foundation

package struct Day01: AdventDay {
  let dayNumeral = "01"

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

  /// An instruction for the safe dial (either L or R and a distance)
  struct DialInstruction: CustomStringConvertible {
    enum Direction: Int {
      case L = -1
      case R = 1
    }
    let direction: Direction
    let distance: Int
    let originalDistance: Int

    let dialMin = 0
    let dialMax = 99

    var ignoredWholeSpins = 0

    var description: String {
      return "Turn \(direction == .L ? "Left" : "Right") by \(distance)"
    }

    /// Initialise instruction from a string e.g. 'L15' or 'R1'
    public init?(string: String) {
      guard string.count > 1 && string.count > 0  else {
        print("could not init DialInstruction - string wrong length")
        return nil
      }
      let directionLetter = string.first!
      guard directionLetter == "L" || directionLetter == "R" else {
        print("could not init DialInstruction - direction letter not L/R")
        return nil
      }
      let distanceAsString = string.dropFirst()
      guard var distanceAsInt = Int(distanceAsString) else {
        print("could not init DialInstruction - distance not a number")
        return nil
      }
      originalDistance = distanceAsInt

      direction = directionLetter == "L" ? .L : .R

//      //  Sanitise the distance so that it's not over 99 (we can ignore multiple whole spins)
//      while distanceAsInt > 99 {
//        distanceAsInt -= 100
//        ignoredWholeSpins += 1
//      }

      //  Sanitise the distance so that it's not over 99 (we can ignore multiple whole spins)
      if distanceAsInt > 99 {
        let multiples = distanceAsInt / 100
        let remainder = distanceAsInt % 100
        distanceAsInt = remainder
        ignoredWholeSpins = multiples
      }


      distance = distanceAsInt
    }

  }


  /// The Safe dial
  package struct Dial: CustomStringConvertible {
    let dialMin = 0
    let dialMax = 99

    var currentPosition: Int = 0

    init(startingAt currentPosition: Int) {
      self.currentPosition = currentPosition
    }

    public var description: String {
      return "Dial Position: \(currentPosition)"
    }

    /// Calculates dial number after an instruction has been applied (short-hand - doesn't apply multiple spins)
    func numberAfterExecuting(instruction: DialInstruction) -> Int {
//      print("Executing dial spin: \(self) from \(currentDialNumber)")
      var newDialIndex = currentPosition + (instruction.distance * instruction.direction.rawValue)
      if newDialIndex < dialMin {
        let overshoot = dialMin - newDialIndex
//        print("overshoot by: \(overshoot)")
        //  Fencepost
        newDialIndex = dialMax - overshoot + 1
      } else if newDialIndex > dialMax {
        let overshoot = newDialIndex - dialMax
//        print("overshoot by: \(overshoot)")
        //  Fencepost
        newDialIndex = dialMin + overshoot - 1
      }
//      print("Dial now points at: \(newDialIndex)")
      precondition(newDialIndex >= dialMin && newDialIndex <= dialMax, "invalid dial number!: \(newDialIndex)")
      return newDialIndex
    }

    /// Actually apply the instruction to the dial.
    mutating func executeInstruction(instruction: DialInstruction) {
      currentPosition = numberAfterExecuting(instruction: instruction)
    }

    /// Given an instruction, how many times did the dial click past zero?
    func numTimesPastZero(forInstruction instruction: DialInstruction) -> Int {
      let components = componentsForInstruction(instruction)
      if components.remainder == 0 {
        return components.wholeSpins
      }
      //  Check if we are going left from zero
      if currentPosition == 0 && instruction.direction == .L {
        return components.wholeSpins
      }
      //  See if we cross once using the just the remainder
      let dialWidth = dialMax - dialMin
      let remainingDialWidth = ( instruction.direction == .R ? (dialWidth - currentPosition) : (currentPosition)  )
      if components.remainder >= remainingDialWidth {
        return components.wholeSpins + 1
      }
      return components.wholeSpins
//      return 0
    }

    //  How many times around the dial
    struct DialComponents {
      let wholeSpins: Int
      let remainder: Int
    }

    /// Gives the number of times that the dial goes round, and also the remainder
    func componentsForInstruction(_ instruction: DialInstruction) -> DialComponents {
      let fullDistance = instruction.originalDistance
      let dialWidth = dialMax - dialMin + 1

      if fullDistance < dialWidth {
        return DialComponents(wholeSpins: 0, remainder: fullDistance)
      }

      //  More than One whole spin.
      let multiples = fullDistance / dialWidth
      let remainder = fullDistance % dialWidth

      return DialComponents(wholeSpins: multiples, remainder: remainder)
    }

  }




  //MARK: - Answer functions

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    print("Day 1")

    let spinR1 = Day01.DialInstruction(string: "R1")
    print(spinR1!)

    //  Load the data
    guard let data = loadData() else {
      print("could not load day's data from file...")
      return 0
    }
    //    print(data)

    //  Turn the data into instructions
    let spinInstructions = data.split(separator: "\n")
    let spins = spinInstructions.compactMap { DialInstruction(string: String($0)) }

    //  The safe has a dial with only an arrow on it; around the dial are the numbers 0 through 99 in order
    //  Because the dial is a circle, turning the dial left from 0 one click makes it point at 99. Similarly, turning the dial right from 99 one click makes it point at 0.
    //  The dial starts by pointing at 50.

    //  The actual password is the number of times the dial is left pointing at 0 after any rotation in the sequence.

    let dialStart = 50
    var numberOfTimesDialIsZero: Int = 0
    var dial = Dial(startingAt: dialStart)

    for spin in spins {
      dial.executeInstruction(instruction: spin)
      if dial.currentPosition == 0 {
        numberOfTimesDialIsZero += 1
      }
    }
    print("We hit Zero \(numberOfTimesDialIsZero) times.")

    return numberOfTimesDialIsZero
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

    //  Turn the data into instructions
    let spinInstructions = data.split(separator: "\n")
    let spins = spinInstructions.compactMap { DialInstruction(string: String($0)) }
    let dialStart = 50

    var dial = Dial(startingAt: dialStart)
    var numberOfTimesDialIsZero: Int = 0

    for spin in spins {
      numberOfTimesDialIsZero += dial.numTimesPastZero(forInstruction: spin)
      dial.executeInstruction(instruction: spin)
    }
    print("We hit Zero \(numberOfTimesDialIsZero) times.")

    return numberOfTimesDialIsZero

  }


}
