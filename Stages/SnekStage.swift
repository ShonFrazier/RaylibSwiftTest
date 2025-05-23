//
//  SnekStage.swift
//  Yokta Beginnings
//
//  Created by Shon on 12/30/24.
//

import Darwin
import Raylib
//import Clay

extension Rectangle {
  var center: Position2 {
    Position2(x: self.x + self.width / 2.0, y: self.y + self.height / 2.0)
  }
  
  func contains(_ p: Position2) -> Bool {
    return
      p.x >= self.x &&
      p.y >= self.y &&
      p.x <= self.x + self.width &&
      p.y <= self.y + self.height
  }
}

let DEFAULT_SNEK_LENGTH: UInt = 2

class SnekStage : Stage {
  static let defaultGridSize = Size(width: 50, height: 50)
  static let defaultCellSize = Size(width: 10, height: 10)
  
  let backgroundColor: RColor
  let gridSize: Size
  let cellSize: Size // screen units (pixels, points, wtfe)
  
  let gridRectangle: Rectangle
  
  var snek: Snek
  
  var stepTimeDelta: Double = 0.25
  var nextStepTime: Double
  var accumulatedFrameTime: Float = 0

  let fullGridSize: Size

//  let clayMemory: Clay_Arena

  init(gridSize: Size = defaultGridSize, cellSize: Size = defaultCellSize, backgroundColor: RColor = BLACK) {
    self.backgroundColor = backgroundColor
    self.cellSize = cellSize
    self.gridSize = gridSize

    self.fullGridSize = Size(
      width: gridSize.width() * cellSize.width(),
      height: gridSize.height() * cellSize.width()
    )

    // Get the center of the entire grid
    self.gridRectangle = Rectangle(x: 0, y: 0, width: gridSize.width(), height: gridSize.height())
    let center = self.gridRectangle.center

    let range: Range<Int> = 0..<Int(DEFAULT_SNEK_LENGTH)
    let body = range.map { i in
      let f = Float(i)
      return SnekCell(count: DEFAULT_SNEK_LENGTH, position: center + (f * Position2.east))
    }

    self.snek = Snek(body: body, direction: .random())
    self.nextStepTime = GetTime()

//    let dims = Clay_Dimensions(width: Float(GetScreenWidth()), height: Float(GetScreenHeight()))
//    clayMemory = Clay_Default_Initialize(dims)
  }
  
  override func draw() {
    let now = GetTime()

//    Clay_BeginLayout()
//    let cmds = Clay_EndLayout()

    BeginDrawing()
    defer { EndDrawing() }

    ClearBackground(backgroundColor)
    
    let hMargin = (GetScreenWidth() - fullGridSize.width()) / 2
    let vMargin = (GetScreenHeight() - fullGridSize.height()) / 2
    
    let timeToStep = GetTime() >= nextStepTime

    if timeToStep {
      if let snek = snek.move() {
        if let head = snek.head {
          if self.gridRectangle.contains(head) {
            self.snek = snek
          } else {
            self.die()
          }
        } else {
          print("headles Snek?")
        }
      } else {
        print("Error moving snek")
      }
      self.nextStepTime = now + stepTimeDelta
    }

    self.snek.body.forEach({ cell in
      let x = cell.position.x * cellSize.width() + Float(hMargin)
      let y = cell.position.y * cellSize.height() + Float(vMargin)
      DrawRectangle(Int32(x), Int32(y), cellSize.width(), cellSize.height(), RED)
    })

    //Clay_Raylib_Render(cmds, nil);
  }
  
  func die() {
    print("ded x.x")
  }
}

enum Direction : RawRepresentable, CaseIterable {
  case east
  case north
  case west
  case south

  var rawValue: Position2 {
    switch self {
    case .east:
      return .east
    case .north:
      return .north
    case .west:
      return .west
    case .south:
      return .south
    }
  }

  init?(rawValue: Position2) {
    if rawValue == .east {
      self = .east
    }
    if rawValue == .north {
      self = .north
    }
    if rawValue == .west {
      self = .west
    }
    if rawValue == .south {
      self = .south
    }

    return nil
  }

  static func random() -> Direction {
    return Self.allCases.randomElement() ?? .east
  }
}

extension UInt {
  func decremented(_ clamping: Range<Self> = Range(uncheckedBounds: (lower: UInt.min, upper: UInt.max))) -> Self {
    return self == clamping.lowerBound
      ? clamping.lowerBound
      : self - 1
  }
  func incremented(_ clamping: Range<Self> = Range(uncheckedBounds: (lower: UInt.min, upper: UInt.max))) -> Self {
    return self == clamping.upperBound
      ? clamping.upperBound
      : self + 1
  }
}

struct SnekCell {
  var count: UInt
  var position: Position2

  var decremented: SnekCell {
    return SnekCell(count: count.decremented(), position: position)
  }

  var incremented: SnekCell {
    return SnekCell(count: count.incremented(), position: position)
  }

  func next(going in: Direction) -> SnekCell {
    let count = count.decremented()
    let position = position + `in`.rawValue

    return SnekCell(count: count, position: position)
  }
}

struct Snek {
  let body: [SnekCell]
  let direction: Direction
  let score: UInt
  
  var head: Position2? {
    body.first?.position
  }

  init(body: [SnekCell] = [], direction: Direction, score: UInt = 2) {
    self.body = body
    self.direction = direction
    self.score = score
  }

  func move() -> Snek? {
    guard let currentHead = body.first else {
      return nil
    }
    let newHead = currentHead.next(going: direction)

    let updatedBody = body.map { $0.decremented }
    let trimmedBody = updatedBody.filter { $0.count > 0 }

    let newBody = [newHead] + trimmedBody

    return Snek(body: newBody, direction: direction, score: score)
  }

  func with(direction: Direction) -> Snek {
    return Snek(body: body, direction: direction, score: score)
  }
  
  func die() {
    
  }
}
