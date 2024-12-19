//
//  RaylibViewController.swift
//  Yokta Beginnings
//
//  Created by Shon on 12/18/24.
//

import Cocoa
import Foundation

class RaylibViewController: NSViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Initialize raylib window
    InitWindow(800, 600, "Raylib Swift macOS Example")
    SetTargetFPS(60)
    
    // Start game loop in background
    DispatchQueue.global(qos: .userInteractive).async {
      self.gameLoop()
    }
  }
  
  func gameLoop() {
    while !WindowShouldClose() {
      BeginDrawing()
      ClearBackground(RAYWHITE)
      
      // Your drawing code here
      DrawText("Hello, Raylib on macOS!", 190, 200, 20, BLACK)
      
      EndDrawing()
    }
    
    CloseWindow()
  }
}

