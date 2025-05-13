//
//  FootballGame.swift
//  Yokta Beginnings
//
//  Created by Shon on 5/6/25.
//

import Foundation
import Raylib

let PLAYER_SPEED: Float = 8 * 1000 / 3600 // 8km/h as m/s
let KICK_RADIUS: Float = 1
let BALL_DECELERATION: Float = -0.3 // m/s^2 - technically, negative deceleration would be acceleration. This sign should not be changed,
let MAX_KICK_SPEED: Float = 20

let TEAMS_FILE: String = "/Users/shon/Projects/Yokta Beginnings/asset-generator/complete-teams.json"
let TEAM_SPRITE_FMT: String = "/Users/shon/Projects/Yokta Beginnings/asset-generator/output/%@_%@.png"

enum TeamSide : String, CaseIterable {
  case home = "ring"
  case away = "stripe"
}

class FootballGame {
  var clubs: [FootballTeam] = [] // all teams
  var teams: [TeamSide:FootballTeam] = [:] // current competition
  var ballPosition: Position2 = .zero
  var ballVelocity: Vector2 = .zero
  
  var pitchTexture: Texture2D?
  
  init() {
    var allTeams: [FootballTeam] = []
    if let teamData = try? Data(contentsOf: URL(fileURLWithPath: TEAMS_FILE)) {
      if let json = try? JSONSerialization.jsonObject(with: teamData, options: []) as? [[String:Any]] {
        for record in json {
          let teamName = record["team"] as! String
          
          let team_name = teamName.lowercased().replacingOccurrences(of: " ", with: "_")
          var team = FootballTeam(name: teamName)
          
          for side in TeamSide.allCases {
            let path = String(format: TEAM_SPRITE_FMT, team_name, side.rawValue)
            let texture = LoadTexture(path)
            team.sprites[side] = texture
          }
          
          let players = record["players"] as! [[String:Any]]
          for player in players {
            let name = player["name"] as? String
            let role = player["position"] as? String
            let number = player["number"] as? Int
            
            let newPlayer = Footballer(team: team, name: name ?? "Anonymous", role: role ?? "Unknown", number: number ?? 0)
            team.players.append(newPlayer)
          }
          allTeams.append(team)
        }
      }
    }
    let homeTeam = allTeams.randomElement()!
    var awayTeam: FootballTeam
    repeat {
      awayTeam = allTeams.randomElement()!
    } while awayTeam == homeTeam
    
    teams[.home] = homeTeam
    teams[.away] = awayTeam
  }
  
  func moveBall(delta: TimeInterval) {
    ballPosition += ballVelocity * Float(delta)
  }
  
  func decelerateBall(delta: TimeInterval) {
    let newSpeed = max(0, ballVelocity.magnitude - BALL_DECELERATION * Float(delta))
    ballVelocity = ballVelocity.normalized * newSpeed
  }
  
  func update(delta: TimeInterval) {
    moveBall(delta: delta)
    decelerateBall(delta: delta)
    
    for (_, team) in self.teams {
      for footballer in team.players {
        if let target = footballer.requestedMovement {
          let delta = (target - footballer.position)
          let direction = delta.normalized
          
          footballer.position += direction * PLAYER_SPEED
        }
        
        if let target = footballer.requestedKick {
          if footballer.position.distance(to: ballPosition) <= KICK_RADIUS {
            ballVelocity += target.normalized * MAX_KICK_SPEED
          }
        }
      }
    }
  }
  
  var lastDestRec: Rectangle = .zero
  func draw() {
    let screenRec = Rectangle(origin: .zero, size: Size(width: GetScreenWidth(), height: GetScreenHeight()))
    let origin: Position2 = (screenRec.size / 2).vec2
    
    guard let pitchTexture = self.pitchTexture else { return }
    
    BeginDrawing()
    defer { EndDrawing() }
    
    // Blank
    ClearBackground(BLACK)
    
    // Pitch
    let imageRec = Rectangle(for: pitchTexture)
    let (destRec, scale) = imageRec.scaled(within: screenRec)
    
    if lastDestRec != destRec {
      print("\(lastDestRec) -> \(destRec)")
      lastDestRec = destRec
    }
    
    DrawTexturePro(pitchTexture, imageRec, destRec, imageRec.origin, 0, WHITE)
    
    for (side, team) in self.teams {
      if let teamSprite = team.sprites[side] {
        let playerRec = Rectangle(for: teamSprite) * scale
        for footballer in team.players {
          // draw player
          let dest = Rectangle(center: footballer.position + screenRec.center, size: playerRec.size.vec2)
          DrawTexturePro(teamSprite, playerRec, dest, playerRec.center, 0, WHITE)
        }
      }
    }
  }
}

enum ColorLabel {
  case primary(RColor)
  case secondary(RColor)
  case additional([RColor])
}

struct FootballTeam {
  var side: TeamSide? = nil
  var sprites: [TeamSide:Texture2D] = [:]
  var players: [Footballer] = []
  
  let name: String
  
  static func ==(lhs: FootballTeam, rhs: FootballTeam) -> Bool {
    lhs.name == rhs.name
  }
}

