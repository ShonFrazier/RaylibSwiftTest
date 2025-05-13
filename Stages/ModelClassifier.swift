//
//  ModelClassifier.swift
//  Yokta Beginnings
//
//  Created by Shon on 3/14/25.
//

import Raylib
//import Clay

struct MetadataPanel {
  let label: String
  var metadata: [String: any CustomStringConvertible]
  
  mutating func addMeta(key: String, value: any CustomStringConvertible) {
    metadata[key] = value
  }
  
  func draw() {
    
  }
}

struct ModelPanel {
  let label: String
  let model: Model
}

struct ModelAssociablePlane : Hashable {
  let model: Model
  let plane: Plane
  
  func hash(into hasher: inout Hasher) {
    model.hash(into: &hasher)
    plane.hash(into: &hasher)
  }
  
  static func ==(lhs: ModelAssociablePlane, rhs: ModelAssociablePlane) -> Bool {
    return lhs.model == rhs.model && lhs.plane == rhs.plane
  }
}

struct ModelAssociation : Hashable {
  let model: ModelAssociablePlane
  let peer: ModelAssociablePlane
  
  func hash(into hasher: inout Hasher) {
    model.hash(into: &hasher)
    peer.hash(into: &hasher)
  }
  
  static func ==(lhs: ModelAssociation, rhs: ModelAssociation) -> Bool {
    return
      ((lhs.model == rhs.model) && (lhs.peer == rhs.peer))
  }
}

struct AssociatedModelsPanel {
  let label: String
  let associations: [Model]
}

class AssociationManager {
  private var associations: [ModelAssociation : Set<ModelAssociation>] = [:]
  private var modelToAssociation: [Model : Set<ModelAssociation>] = [:]
  
  func associate(_ pair1: ModelAssociation, _ pair2: ModelAssociation) {
    if associations[pair1] == nil {
      associations[pair1] = Set()
    }
    associations[pair1]!.insert(pair2)
    
    if associations[pair2] == nil {
      associations[pair2] = Set()
    }
    associations[pair2]!.insert(pair1)
    
    addAssociation(model: pair1.model.model, to: pair1)
    addAssociation(model: pair1.model.model, to: pair2)
    addAssociation(model: pair2.model.model, to: pair1)
    addAssociation(model: pair2.model.model, to: pair2)
  }
  
  func getAssociatedPairs(for pair: ModelAssociation) -> Set<ModelAssociation> {
    return associations[pair] ?? Set()
  }
  
  func getAssociatedPairs(for model: Model) -> Set<ModelAssociation>? {
    return modelToAssociation[model] ?? Set()
  }
  
  func addAssociation(model: Model, to pair: ModelAssociation) {
    if modelToAssociation[model] == nil {
      modelToAssociation[model] = Set()
    }
    modelToAssociation[model]!.insert(pair)
  }
}

class ModelClassifier : Stage {
  var availableModels: [Model] = []
  
  var currentModelAssociaton: ModelAssociation?
  
//  let clayMemory: Clay_Arena
  
  override init() {
//    let dims = Clay_Dimensions(width: Float(GetScreenWidth()), height: Float(GetScreenHeight()))
//    clayMemory = Clay_Default_Initialize(dims)
  }
  
  override func draw() {
//    Clay_BeginLayout()
    
    //CLAY({ .id = CLAY_ID("")
      
//    })
    
//    let cmds = Clay_EndLayout()
    
    
  }
}
