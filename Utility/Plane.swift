//
//  Plane.swift
//  Yokta Beginnings
//
//  Created by Shon on 3/14/25.
//

import Raylib

struct Plane : Hashable {
  let name: String?
  let normal: Vector3
  let point: Position3
  
  init(name: String? = nil, normal: Vector3, point: Position3) {
    self.name = name
    self.normal = normal
    self.point = point
  }
  
  static var xz: Self {
    Plane(name: "xz", normal: Vector3(0,1,0), point: Position3.zero)
  }
  
  static var xy: Self {
    Plane(name: "xy", normal: Vector3(0,0,1), point: Position3.zero)
  }
  
  static var yz: Self {
    Plane(name: "yz", normal: Vector3(1,0,0), point: Position3.zero)
  }
  
  func isSame(with other: Plane) -> Bool {
    let isParallel = normal.isParallel(to: other.normal)
    let myPointLiesWithinOther = self.point.lies(within: other)
    return isParallel && myPointLiesWithinOther
  }
  
  func hash(into hasher: inout Hasher) {
    name.hash(into: &hasher)
    normal.hash(into: &hasher)
    point.hash(into: &hasher)
  }
  
  static func ==(lhs: Self, rhs: Self) -> Bool {
    lhs.isSame(with: rhs)
  }
}

extension Vector3 {
  func lies(within plane: Plane) -> Bool {
    let dot1 = self.dot(plane.point)
    let dot2 = plane.normal.dot(plane.point)
    return abs(dot1 - dot2).magnitude < 1e-6
  }
}
