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
  
  func willPrepare()
  func didPrepare()
  
  func willUpdate()
  func didUpdate()
  
  func willDraw()
  func didDraw()
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
  
  public func willPrepare() {}
  public final func prepare() {
    willPrepare()
    if let dismissAfterSeconds = dismissAfterSeconds {
      startTime = GetTime()
      let seconds = dismissAfterSeconds
      endTime = startTime + seconds
    }
    didPrepare()
  }
  public func didPrepare() {}
  
  public func willUpdate() {}
  public final func update() {
    willUpdate()
    if dismissAfterSeconds != nil {
      let now = GetTime()
      if now > endTime {
        stop()
      }
    }
    didUpdate()
  }
  public func didUpdate() {}
  
  public func willDraw() {}
  public final func draw() {
    willDraw()
    didDraw()
  }
  public func didDraw() {}
  
  public func stop() {
    isRunning = false
  }
}
