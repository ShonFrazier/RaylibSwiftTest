//
//  Game.swift
//  Yokta Beginnings
//
//  Created by Shon on 12/19/24.
//

import Raylib

public struct Size {
  var _width: Double
  var _height: Double
  
  func height<T:BinaryInteger>() -> T {
    T(_height.rounded())
  }
  
  func height<T:BinaryFloatingPoint>() -> T {
    T(_height)
  }
  
  func width<T:BinaryInteger>() -> T {
    T(_width.rounded())
  }
  
  func width<T:BinaryFloatingPoint>() -> T {
    T(_width)
  }
  
  init(width: Double, height: Double) {
    self._width = width
    self._height = height
  }
  
  init<T:BinaryInteger>(width: T, height: T) {
    _width = Double(width)
    _height = Double(height)
  }
  
  init<T:BinaryFloatingPoint>(width: T, height: T) {
    _width = Double(width)
    _height = Double(height)
  }
  
  public static func `default`() -> Size {
    return Size(width: 800, height: 600)
  }
  
  var vec2: Vector2 {
    return Vector2(x: width(), y: height())
  }
}

public class Game {
  var size: Size
  let stages: [Stage]
  
  var stage_index: Int = 0
  var current_stage: Stage? = nil
  
  public private(set) var isRunning: Bool = true
  
  public init(_ size: Size? = nil, _ flags: ConfigFlags? = nil) {
    if let flags = flags {
      SetConfigFlags(flags.rawValue)
    }
    
    if let size = size {
      self.size = size
    } else {
      self.size = Size.default()
    }
    
    InitWindow(self.size.width(), self.size.height(), "Raylib Swift macOS Example")
    
    let (start, end) = {
      let a = Int.random(in: 0..<KAY_GREEN_GLTF_MODELS.count)
      let b = Int.random(in: 0..<KAY_GREEN_GLTF_MODELS.count)
      
      return (min(a,b),max(a,b))
    }()
    let models = Array(KAY_GREEN_GLTF_MODELS[start ... end])
    
    stages = [
      SoccerStage(),
//      SnekStage(),
//      LoadingStage(),
//      ThreeDModelsStage(fromFiles: models),
//      ClearDissolveStage(start: BLACK, end: RED, length: 0.75),
//      ClearDissolveStage(start: RED, end: BLUE, length: 0.5),
//      ClearStage(color: BLUE),
    ]
    
    if stages.count > 0 {
      nextStage()
    } else {
      print("No stages, can't run")
      self.isRunning = false
    }
  }
  
  func nextStage() {
    if let _ = current_stage {
      stage_index += 1
    } else {
      stage_index = 0
    }
    current_stage = stages[stage_index % stages.count]
    current_stage!.prepare()
  }
  
  public func step() {
    guard let stage = current_stage else {
      return
    }
    
    if stage.isRunning {
      stage.update()
      stage.draw()
    } else {
      nextStage()
    }
  }
}
