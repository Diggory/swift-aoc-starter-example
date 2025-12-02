import Testing


@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
struct Day01Tests {

  class DialTests {

    let foo = "Hello"
    let spinR0 = Day01.DialInstruction(string: "R0")!
    let spinR1 = Day01.DialInstruction(string: "R1")!
    let spinL1 = Day01.DialInstruction(string: "L1")!
    let spinR10 = Day01.DialInstruction(string: "R10")!
    let spinL10 = Day01.DialInstruction(string: "L10")!
    let spinR50 = Day01.DialInstruction(string: "R50")!
    let spinL50 = Day01.DialInstruction(string: "L50")!
    let spinR99 = Day01.DialInstruction(string: "R99")!
    let spinL99 = Day01.DialInstruction(string: "L99")!
    let spinR100 = Day01.DialInstruction(string: "R100")!
    let spinL100 = Day01.DialInstruction(string: "L100")!
    let spinR123 = Day01.DialInstruction(string: "R123")!
    let spinR150 = Day01.DialInstruction(string: "R150")!
    let spinL150 = Day01.DialInstruction(string: "L150")!
    let spinR250 = Day01.DialInstruction(string: "R250")!
    let spinL250 = Day01.DialInstruction(string: "L250")!
    let spinL350 = Day01.DialInstruction(string: "L350")!


    let dialStartPosition50: Int = 50
    var dial = Day01.Dial(startingAt: 50)

    func resetDial() {
      dial.currentPosition = dialStartPosition50
    }

    @Test("Initial State")
    func initialState() {
      #expect(dial.currentPosition == 50)
    }

    @Test("R1") func spinR1Test() {
      resetDial()
      #expect(dial.numberAfterExecuting(instruction: spinR1) == 51)
    }

    @Test("L1") func spinL1Test() {
      resetDial()
      #expect(dial.numberAfterExecuting(instruction: spinL1) == 49)
    }

    @Test("R50") func spinR50Test() {
      resetDial()
      #expect(dial.numberAfterExecuting(instruction: spinR50) == 00)
    }

    @Test("L50") func spinL50Test() {
      resetDial()
      #expect(dial.numberAfterExecuting(instruction: spinL50) == 00)
    }

    @Test("R100") func spinR100Test() {
      resetDial()
      #expect(dial.numberAfterExecuting(instruction: spinR100) == 50)
    }

    @Test("L100") func spinL100Test() {
      resetDial()
      #expect(dial.numberAfterExecuting(instruction: spinL100) == 50)
    }

    @Test("R99") func spinR99Test() {
      resetDial()
      #expect(dial.numberAfterExecuting(instruction: spinR99) == 49)
    }

    @Test("L99") func spinL99Test() {
      resetDial()
      #expect(dial.numberAfterExecuting(instruction: spinL99) == 51)
    }

    @Test("R150") func spinR150Test() {
      resetDial()
      #expect(dial.numberAfterExecuting(instruction: spinR150) == 00)
    }

    @Test("L150") func spinL150Test() {
      resetDial()
      #expect(dial.numberAfterExecuting(instruction: spinL150) == 00)
    }

    //  Testing DialComponents
    @Test("Components D10") func componentsW11D10Test() {
      resetDial()
      let components = dial.componentsForInstruction(spinR10)
      #expect(components.wholeSpins == 0)
      #expect(components.remainder == 10)
    }

    @Test("Components D0") func componentsW11D00Test() {
      resetDial()
      let components = dial.componentsForInstruction(spinR0)
      #expect(components.wholeSpins == 0)
      #expect(components.remainder == 0)
    }


    @Test("Components D99") func componentsW11D99Test() {
      resetDial()
      let components = dial.componentsForInstruction(spinR99)
      #expect(components.wholeSpins == 0)
      #expect(components.remainder == 99)
    }

    @Test("Components D100") func componentsW11D100Test() {
      resetDial()
      let components = dial.componentsForInstruction(spinR100)
      #expect(components.wholeSpins == 1)
      #expect(components.remainder == 0)
    }

    @Test("Components D150") func componentsW11D150Test() {
      resetDial()
      let components = dial.componentsForInstruction(spinR150)
      #expect(components.wholeSpins == 1)
      #expect(components.remainder == 50)
    }

    @Test("Components D123") func componentsW11D123Test() {
      resetDial()
      let components = dial.componentsForInstruction(spinR123)
      #expect(components.wholeSpins == 1)
      #expect(components.remainder == 23)
    }

    @Test("Components D250") func componentsW11D250Test() {
      resetDial()
      let components = dial.componentsForInstruction(spinR250)
      #expect(components.wholeSpins == 2)
      #expect(components.remainder == 50)
    }

    //  Times Past Zero...
    @Test("Times past 0: R10 from 50") func timesPastZeroR10From50() {
      resetDial()
      #expect(dial.numTimesPastZero(forInstruction: spinR10) == 00)
    }

    @Test("Times past 0: L10 from 50") func timesPastZeroL10From50() {
      resetDial()
      #expect(dial.numTimesPastZero(forInstruction: spinL10) == 00)
    }

    @Test("Times past 0: R50 from 50") func timesPastZeroR50From50() {
      resetDial()
      #expect(dial.numTimesPastZero(forInstruction: spinR50) == 1)
    }

    @Test("Times past 0: L50 from 50") func timesPastZeroL50From50() {
      resetDial()
      #expect(dial.numTimesPastZero(forInstruction: spinL50) == 1)
    }

    @Test("Times past 0: R100 from 50") func timesPastZeroR100From50() {
      resetDial()
      #expect(dial.numTimesPastZero(forInstruction: spinR100) == 1)
    }

    @Test("Times past 0: L100 from 50") func timesPastZeroL100From50() {
      resetDial()
      #expect(dial.numTimesPastZero(forInstruction: spinL100) == 1)
    }

    @Test("Times past 0: R150 from 50") func timesPastZeroR150From50() {
      resetDial()
      #expect(dial.numTimesPastZero(forInstruction: spinR150) == 2)
    }

    @Test("Times past 0: L150 from 50") func timesPastZeroL150From50() {
      resetDial()
      #expect(dial.numTimesPastZero(forInstruction: spinL150) == 2)
    }




    @Test("Times past 0: R50 from 0") func timesPastZeroR50From0() {
      resetDial()
      dial.currentPosition = 0
      #expect(dial.numTimesPastZero(forInstruction: spinR50) == 0)
    }

    @Test("Times past 0: L50 from 0") func timesPastZeroL50From0() {
      resetDial()
      dial.currentPosition = 0
      #expect(dial.numTimesPastZero(forInstruction: spinL50) == 0)
    }

    @Test("Times past 0: L1 from 1") func timesPastZeroL1From1() {
      resetDial()
      dial.currentPosition = 1
      #expect(dial.numTimesPastZero(forInstruction: spinL1) == 1)
    }

    @Test("Times past 0: R1 from 1") func timesPastZeroR1From1() {
      resetDial()
      dial.currentPosition = 1
      #expect(dial.numTimesPastZero(forInstruction: spinR1) == 0)
    }

    @Test("Times past 0: L1 from 99") func timesPastZeroL1From99() {
      resetDial()
      dial.currentPosition = 99
      #expect(dial.numTimesPastZero(forInstruction: spinL1) == 0)
    }

    @Test("Times past 0: R1 from 99") func timesPastZeroR1From99() {
      resetDial()
      dial.currentPosition = 99
      #expect(dial.numTimesPastZero(forInstruction: spinR1) == 1)
    }


    @Test("Times past 0: L100 from 0") func timesPastZeroL100From0() {
      resetDial()
      dial.currentPosition = 0
      #expect(dial.numTimesPastZero(forInstruction: spinL100) == 1)
    }

    @Test("Times past 0: L150 from 0") func timesPastZeroL150From0() {
      resetDial()
      dial.currentPosition = 0
      #expect(dial.numTimesPastZero(forInstruction: spinL150) == 1)
    }

    @Test("Times past 0: L250 from 0") func timesPastZeroL250From0() {
      resetDial()
      dial.currentPosition = 0
      #expect(dial.numTimesPastZero(forInstruction: spinL250) == 2)
    }

    @Test("Times past 0: L350 from 0") func timesPastZeroL350From0() {
      resetDial()
      dial.currentPosition = 0
      #expect(dial.numTimesPastZero(forInstruction: spinL350) == 3)
    }



  }

}
