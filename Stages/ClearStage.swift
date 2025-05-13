//
//  ClearStage.swift
//  Yokta Beginnings
//
//  Created by Shon on 12/19/24.
//

import Raylib

class ClearStage : Stage {
  let clearColor: RColor
  
  init(color: RColor) {
    clearColor = color
  }
  
  override func draw() {
    BeginDrawing()
    defer { EndDrawing() }
    
    ClearBackground(clearColor)
  }
}
