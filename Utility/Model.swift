//
//  Model.swift
//  Yokta Beginnings
//
//  Created by Shon on 3/14/25.
//

import Raylib

extension Model : Hashable {
  public static func ==(lhs: Model, rhs: Model) -> Bool {
    return
      lhs.transform == rhs.transform &&
      lhs.meshCount == rhs.meshCount &&
      lhs.meshes == rhs.meshes &&
      lhs.materials == rhs.materials &&
      lhs.boneCount == rhs.boneCount &&
      lhs.bones == rhs.bones &&
      lhs.bindPose == rhs.bindPose
  }
  
  public func hash(into hasher: inout Hasher) {
    self.transform.hash(into: &hasher)
  }
}
