//
//  SplashStage.swift
//  Yokta Beginnings
//
//  Created by Shon on 12/19/24.
//

import Raylib

let DEFAULT_LOADING_STRING_LIST: [LoadingMessage] = [
  LoadingMessage(string: "Loading   "),
  LoadingMessage(string: "Loading.  "),
  LoadingMessage(string: "Loading.. "),
  LoadingMessage(string: "Loading..."),
  LoadingMessage(string: "Loading .."),
  LoadingMessage(string: "Loading  ."),
  LoadingMessage(string: "Loading   "),
  LoadingMessage(string: "Loading.  "),
  LoadingMessage(string: "Loading . "),
  LoadingMessage(string: "Loading  ."),
]

let DEFAULT_LOADING_STRING_TIMEOUT: Double = 0.1

protocol Copyable {
  func copy() -> Self
}

public struct LoadingMessage {
  var string: String
  var timeout: Double?
  
  static func empty() -> Self {
    return LoadingMessage(string: "")
  }
}

extension LoadingMessage: Copyable {
  func copy() -> Self {
    return LoadingMessage(string: self.string, timeout: self.timeout)
  }
}

public class LoadingStage : Stage {
  let messages: [LoadingMessage]
  
  var currentString: LoadingMessage?
  var currentStringIndex: Int = 0
  var currentStringEndTime: Double = 0
  
  var font: Raylib.Font
  var fontSize: Float
  var charSpacing: Float
  
  var largestStringSize: Vector2?
  
  
  public init(messages: [LoadingMessage]? = nil) {
    if let messages = messages {
      self.messages = messages
    } else {
      self.messages = DEFAULT_LOADING_STRING_LIST.map { $0.copy() }
    }
    
    self.font = GetFontDefault()
    self.fontSize = 20
    self.charSpacing = 2
    
    if self.messages.indices.contains(0) {
      currentString = self.messages[currentStringIndex]
    } else {
      currentString = nil
    }
    
    super.init()
    dismissAfterSeconds = 10
  }
  
  public override func prepare() {
    currentStringIndex = 0
    if self.messages.indices.contains(currentStringIndex) {
      nextString()
    } else {
      self.isRunning = false
    }
  }
  
  public override func update() {
    let now = GetTime()
    
    if now >= currentStringEndTime {
      nextString()
    }
    
    if IsKeyPressed(Int32(KEY_SPACE.rawValue)) {
      self.isRunning = false
    }
  }
  
  func nextString() {
    if currentString != nil {
      currentStringIndex += 1
      currentStringIndex %= messages.count
    } else {
      currentStringIndex = 0
    }
    currentString = messages[currentStringIndex]
    currentStringEndTime = GetTime() + (currentString!.timeout ?? DEFAULT_LOADING_STRING_TIMEOUT)
  }
  
  public override func draw() {
    let message = messages[currentStringIndex]
    let winWidth = GetScreenWidth()
    let winHeight = GetScreenHeight()
    
    if self.largestStringSize == nil {
      var largest: Vector2 = Vector2(x: 0, y: 0)
      for message in messages {
        let size = MeasureTextEx(self.font, message.string, self.fontSize, self.charSpacing)
        
        largest.x = max(size.x, largest.x)
        largest.y = max(size.y, largest.y)
      }
      largest.x *= 1.25
      largestStringSize = largest
    }
    
    BeginDrawing()
    defer { EndDrawing() }
    
    ClearBackground(BLACK)
    
    guard let size = largestStringSize else {
      return
    }
    
    let x = (Float(winWidth) / 2.0 - size.x / 2.0) * 0.8
    let y = Float(winHeight) / 2.0 - size.y / 2.0
    
    DrawText(message.string, Int32(x), Int32(y), Int32(self.fontSize), RAYWHITE)
  }
}
