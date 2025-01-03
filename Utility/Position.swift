//
//  Position.swift
//  Yokta Beginnings
//
//  Created by Shon on 12/30/24.
//

import Foundation

struct Position : Equatable {
  var x: Float
  var y: Float

  init(_ x: Float, _ y: Float) {
    self.x = x
    self.y = y
  }

  init(x: Float, y: Float) {
    self.init(x,y)
  }

  static var east: Position {
    return Position(1, 0)
  }
  static var north: Position {
    return Position(0, 1)
  }
  static var west: Position {
    return Position(-1, 0)
  }
  static var south: Position {
    return Position(0, -1)
  }

  static var zero: Position {
    return Position(0,0)
  }
}

func == (lhs: Position, rhs: Position) -> Bool {
  return lhs.x == rhs.x && lhs.y == lhs.y
}

func + (lhs: Position, rhs: Position) -> Position {
  return Position(lhs.x + rhs.x, lhs.y + rhs.y)
}

func * (scalar: Float, pos: Position) -> Position {
  return Position(pos.x * scalar, pos.y * scalar)
}

func * (pos: Position, scalar: Float) -> Position {
  return scalar * pos
}
