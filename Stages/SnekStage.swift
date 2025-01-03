//
//  SnekStage.swift
//  Yokta Beginnings
//
//  Created by Shon on 12/30/24.
//

import Darwin
import Raylib

extension Rectangle {
  var center: Position {
    Position(x: self.x + self.width / 2.0, y: self.y + self.height / 2.0)
  }
}

let DEFAULT_SNEK_LENGTH: UInt = 2

class SnekStage : Stage {
  static let defaultGridSize = Size(width: 50, height: 50)
  static let defaultCellSize = Size(width: 10, height: 10)
  
  let backgroundColor: RColor
  let gridSize: Size
  let cellSize: Size // screen units (pixels, points, wtfe)
  
  let snek: Snek

  let fullGridSize: Size

  init(gridSize: Size = defaultGridSize, cellSize: Size = defaultCellSize, backgroundColor: RColor = BLACK) {
    self.backgroundColor = backgroundColor
    self.cellSize = cellSize
    self.gridSize = gridSize

    self.fullGridSize = Size(
      width: gridSize.width * cellSize.width,
      height: gridSize.height * cellSize.width
    )

    // Get the center of the entire grid
    let r: Rectangle = Rectangle(x: 0, y: 0, width: Float(gridSize.width), height: Float(gridSize.height))
    let center = r.center

    let range: Range<Int> = 0..<Int(DEFAULT_SNEK_LENGTH)
    let body = range.map { e in
      let i = Float(Int(e)) * 1.0
      return SnekCell(count: DEFAULT_SNEK_LENGTH, position: center + (i * Position.east))
    }

    self.snek = Snek(body: body, direction: .random())
  }

  override func willDraw() {
    BeginDrawing()
    defer { EndDrawing() }
    
    ClearBackground(backgroundColor)
    
    let hMargin = (GetScreenWidth() - fullGridSize.width) / 2
    let vMargin = (GetScreenHeight() - fullGridSize.height) / 2



    snek.body.forEach({ cell in
      let x = cell.position.x * Float(cellSize.width) + Float(hMargin)
      let y = cell.position.y * Float(cellSize.height) + Float(vMargin)
      DrawRectangle(Int32(x), Int32(y), cellSize.width, cellSize.height, RED)
    })
  }
}

enum Direction : RawRepresentable, CaseIterable {
  case east
  case north
  case west
  case south

  var rawValue: Position {
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

  init?(rawValue: Position) {
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
    return self == clamping.min()
      ? clamping.min()!
      : self - 1
  }
  func incremented(_ clamping: Range<Self> = Range(uncheckedBounds: (lower: UInt.min, upper: UInt.max))) -> Self {
    return self == clamping.max()
      ? clamping.max()!
      : self + 1
  }
}

struct SnekCell {
  var count: UInt
  var position: Position

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
    let trimmedBody = body.filter { $0.count > 0 }

    let newBody = [newHead] + trimmedBody

    return Snek(body: newBody, direction: direction, score: score)
  }

  func with(direction: Direction) -> Snek {
    return Snek(body: body, direction: direction, score: score)
  }
}
