//
//  SoccerStage.swift
//  Yokta Beginnings
//
//  Created by Shon on 5/5/25.
//

import Raylib
import Lua

class SoccerStage : Stage {
  
  let pitchTexture: Texture2D
  let footballGame: FootballGame
  
  override init() {
    pitchTexture = LoadTexture("/Users/shon/Documents/Game Assets/pitch-6.png")
    footballGame = FootballGame()
    footballGame.pitchTexture = pitchTexture
  }
  
  override func prepare() {
    super.prepare()
    self.isRunning = true
  }
  
  override func update() {
    super.update()
    footballGame.update(delta: Double(GetFrameTime()))
  }
  
  override func draw() {
//    let screenWidth = GetScreenWidth()
//    let screenHeight = GetScreenHeight()
//
//    let pitchWidth = pitchTexture.width
//    let pitchHeight = pitchTexture.height
//    
//    let position = Vector2(
//      x: Float(screenWidth) / 2.0 - Float(pitchWidth) / 2.0,
//      y: Float(screenHeight) / 2.0 - Float(pitchHeight) / 2.0
//    )
//    
//    BeginDrawing()
//    defer { EndDrawing() }
//    
//    ClearBackground(BLACK)
//    DrawTextureRec(pitchTexture, Rectangle(x: 0, y: 0, width: Float(pitchWidth), height: Float(pitchHeight)), position, WHITE)
    
    footballGame.draw()
  }
}
