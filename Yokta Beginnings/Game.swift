//
//  Game.swift
//  Yokta Beginnings
//
//  Created by Shon on 12/19/24.
//

import Raylib

public struct Size {
  var width: Int32
  var height: Int32
  
  public static func `default`() -> Size {
    return Size(width: 800, height: 600)
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
    
    stages = [
      SnekStage(),
      LoadingStage(),
      ClearDissolveStage(start: BLACK, end: RED, length: 0.75),
      ClearDissolveStage(start: RED, end: BLUE, length: 0.5),
      //ClearStage(color: BLUE),
    ]
    InitWindow(self.size.width, self.size.height, "Raylib Swift macOS Example")
    
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
