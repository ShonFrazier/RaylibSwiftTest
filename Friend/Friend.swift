//
//  Friend.swift
//  Yokta Beginnings
//
//  Created by Shon on 12/22/24.
//

import Foundation

struct Food {
  var nutrition: Double
  var hydration: Double
}

struct Friend {
  enum Species {
    case cat
    case dog
  }
  
  enum Mood {
    case neutral // no other moods
    case hungry
    case thirsty
    case tired
    case sad
    case sick
    case healthy
  }
  
  var name: String
  var species: Species
  var birthdate: Date
  var hunger: Double // 0.0 to 1.0   not hungry to extremely hungry
  var thirst: Double
  var sleepiness: Double
  var health: Double // 0.0 to 1.0  poor health / sick to perfectly healthy
  var energy: Double
  var moods: Set<Mood>
  
  func update<T>(_ keyPath: WritableKeyPath<Friend, T>, to value: T) -> Self {
    var copy = self
    copy[keyPath: keyPath] = value
    return copy
  }
  
  func add<T>(value: T, to keyPath: WritableKeyPath<Friend, T>) -> Self where T:Numeric {
    var copy = self
    copy[keyPath: keyPath] += value
    return copy
  }
  
  func setMood(_ mood: Mood) -> Self {
    if mood != .neutral {
      var newMoods = moods.union([mood])
      return update(\.moods, to: newMoods)
    } else {
      return self
    }
  }
  
  func unsetMood(_ mood: Mood) -> Self {
    var newMoods = moods.subtracting([mood])
    return update(\.moods, to: newMoods)
  }
  
  func feed(food: Food) -> Self {
    let newState = add(value: -food.nutrition, to: \.hunger)
    if newState.hunger >= 0.7 {
      return setMood(.hungry)
    } else {
      return unsetMood(.hungry)
    }
  }
  
  func giveWater(amount: Double) -> Self {
    return feed(food: Food(nutrition: 0, hydration: amount))
  }
  
}
