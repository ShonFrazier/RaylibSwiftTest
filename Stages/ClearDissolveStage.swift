//
//  ClearDissolveStage.swift
//  Yokta Beginnings
//
//  Created by Shon on 12/19/24.
//

import Foundation
import Raylib


class ClearDissolveStage: Stage {
  let startColor: RColor
  let endColor: RColor
  var currentColor: RColor
  let animationLength: Double //seonds
  
  public init(start: RColor, end: RColor, length: Double) {
    startColor = start
    currentColor = start
    endColor = end
    animationLength = length
  }
  
  public override func prepare() {
    startTime = GetTime()
    endTime = startTime + animationLength
  }
  
  public override func update() {
    let now = GetTime()
    if now > endTime {
      currentColor = endColor
      isRunning = false
      return
    }
    
    let t = (animationLength - (endTime - now)) / animationLength
    currentColor = startColor.interpolate(to: endColor, t: t)
  }
    
  public override func draw() {
    BeginDrawing()
    defer { EndDrawing() }
    
    ClearBackground(currentColor)
  }
}

extension RColor : @retroactive CustomStringConvertible {
  public var description: String {
    return "Color<r: \(self.r)  g: \(self.g)  b: \(self.b)  a: \(self.a)\n>"
  }
}

extension RColor {
  func interpolate(to end: RColor, t: Double) -> RColor {
    return Yokta_Beginnings.interpolate(from: self, to: end, t:t)
  }
}

func interpolate(from start: RColor, to end: RColor, t: Double) -> RColor {
  let r = UInt8(Double(start.r) + (Double(end.r) - Double(start.r)) * t)
  let g = UInt8(Double(start.g) + (Double(end.g) - Double(start.g)) * t)
  let b = UInt8(Double(start.b) + (Double(end.b) - Double(start.b)) * t)
  let a = UInt8(Double(start.a) + (Double(end.a) - Double(start.a)) * t)
  
  return RColor(r: r, g: g, b: b, a: a)
}
