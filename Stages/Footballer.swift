//
//  FootballPlayer.swift
//  Yokta Beginnings
//
//  Created by Shon on 5/6/25.
//

import Foundation
import Lua

class Footballer {
  let lua: LuaState
  var program: String = ""
  
  let team: FootballTeam
  let name: String
  let role: String
  let number: Int
  
  var position: Position2 = .zero
  var velocity: Vector2 = .zero
  
  // Requests
  var requestedMovement: Vector2?
  var requestedKick: Vector2?
  
  init (team: FootballTeam, name: String, role: String, number: Int) {
    lua = LuaState(libraries: .all)
    
    self.team = team
    self.name = name
    self.role = role
    self.number = number
  }
  
  deinit {
    lua.close()
  }
  
  func update(game: FootballGame)  {
    do {
      try lua.dostring(program)
      if let result = lua.tostringUtf8(1) {
        // TODO: Analyze result for instructions
      }
    } catch let error {
      print("Error while executing program: \(error)")
    }
  }
  
  //MARK: Movement
  func moveTo(target: Vector2) {
    self.requestedMovement = target
  }
    
  func stop() {
    self.requestedMovement = nil
    self.velocity = .zero
  }
  
  //MARK: Ball
  func kick(target: Vector2) {
    self.requestedKick = target
  }
}
