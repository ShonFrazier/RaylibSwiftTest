//
//  Stage.swift
//  Yokta Beginnings
//
//  Created by Shon on 12/19/24.
//

import Foundation
import Raylib

public protocol StageInterface {
  var isRunning: Bool { get }
  var dismissAfterSeconds: Double? {get set}
  
  func prepare()
  func update()
  func draw()
}

public class Stage : StageInterface {
  public var isRunning: Bool
  public var dismissAfterSeconds: Double?
  
  var startTime: Double
  var endTime: Double
  
  public init() {
    isRunning = true
    startTime = 0
    endTime = 0
  }
  
  public func prepare() {
    if let dismissAfterSeconds = dismissAfterSeconds {
      startTime = GetTime()
      let seconds = dismissAfterSeconds
      endTime = startTime + seconds
    }
  }
  
  public func update() {
    if dismissAfterSeconds != nil {
      // If now is after endTime, stop
      if GetTime() > endTime {
        stop()
      }
    }
  }
  
  public func draw() {}
  
  public func stop() {
    isRunning = false
  }
}
