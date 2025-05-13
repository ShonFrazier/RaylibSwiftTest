//
//  Vector.swift
//  Yokta Beginnings
//
//  Created by Shon on 3/14/25.
//

import Foundation
import Raylib

infix operator ⋅

typealias Vector2 = Raylib.Vector2

extension Vector3 : Hashable {
  init(_ x: Float, _ y: Float, _ z: Float) {
    self.init(x:x, y:y, z:z)
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(x.hashValue)
    hasher.combine(y.hashValue)
    hasher.combine(z.hashValue)
  }
  
  public static var zero: Self {
    .init(0,0,0)
  }
  
  public static func ==(lhs: Self, rhs: Self) -> Bool {
    lhs.x == rhs.x &&
    lhs.y == rhs.y &&
    lhs.z == rhs.z
  }
  
  static prefix func -(vec: Self) -> Self {
    .init(-vec.x, -vec.y, -vec.z)
  }
  
  static func +(lhs: Self, rhs: Self) -> Self {
    .init(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
  }
  
  static func -(lhs: Self, rhs: Self) -> Self {
    .init(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
  }
  
  static func *(vec: Self, scalar: Float) -> Self {
    .init(vec.x * scalar, vec.y * scalar, vec.z * scalar)
  }
  
  static func *(scalar: Float, vec: Self) -> Self {
    vec * scalar
  }
  
  static func +=(lhs: inout Self, rhs: Self) {
    lhs.x += rhs.x
    lhs.y += rhs.y
    lhs.z += rhs.z
  }
  
  static func *=(vec: inout Self, scalar: Float) {
    vec.x *= scalar
    vec.y *= scalar
    vec.z *= scalar
  }
  
  static func ⋅(lhs: Self, rhs: Self) -> Float {
    lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * lhs.z
  }
  
  func dot(_ other: Self) -> Float {
    self ⋅ other
  }
  
  func isParallel(to other: Self) -> Bool {
    let dot = (self ⋅ other)
    let one = Float(1)
    let negOne = -one
    return (dot - one).magnitude < 1e-6 || (dot - negOne).magnitude < 1e-6
  }
  
  func distance(to other: Self) -> Float {
    let xDiff = other.x - self.x
    let yDiff = other.y - self.y
    let zDiff = other.z - self.z
    return sqrt( xDiff * xDiff  +  yDiff * yDiff  +  zDiff * zDiff )
  }
  
  var magnitude: Float {
    sqrt( x * x  +  y * y  +  z * z )
  }
  
  var normalized: Self {
    self * (1.0 / magnitude)
  }
  
  var isNormalized: Bool {
    (magnitude - 1).magnitude < 1e-6
  }
}

extension Vector2 {
  init(_ x: Float, _ y: Float) {
    self.init(x: x, y: y)
  }
  
  static var zero: Self {
    self.init(0,0)
  }
  
  var vec3: Vector3 {
    Vector3(self.x, self.y, 0)
  }

  
  func dot(_ other: Self) -> Float {
    self ⋅ other
  }
  
  func distance(to other: Self) -> Float {
    (self - other).magnitude
  }
  
  var magnitude: Float {
    sqrt( x * x  +  y * y )
  }
  
  var normalized: Self {
    self * (1.0 / magnitude)
  }
  
  static var east: Self {
    Vector2(1,0)
  }
  static var north: Self {
    Vector2(0,0)
  }
  static var west: Self {
    Vector2(-1,0)
  }
  static var south: Self {
    Vector2(0,-1)
  }
  
  static prefix func -(vec: Self) -> Self {
    .init(-vec.x, -vec.y)
  }
  
  static func +(lhs: Self, rhs: Self) -> Self {
    .init(lhs.x + rhs.x, lhs.y + rhs.y)
  }
  
  static func +=(lhs: inout Self, rhs: Self) {
    lhs.x += rhs.x
    lhs.y += rhs.y
  }
  
  static func -(lhs: Self, rhs: Self) -> Self {
    .init(lhs.x - rhs.x, lhs.y - rhs.y)
  }
  
  static func -=(lhs: inout Self, rhs: Self) {
    lhs.x -= rhs.x
    lhs.y -= rhs.y
  }
  
  static func *(vec: Self, scalar: Float) -> Self {
    .init(vec.x * scalar, vec.y * scalar)
  }
  
  static func *=(vec: inout Self, scalar: Float) {
    vec.x *= scalar
    vec.y *= scalar
  }
  
  static func *(scalar: Float, vec: Self) -> Self {
    vec * scalar
  }
 
  static func ⋅(lhs: Self, rhs: Self) -> Float {
    lhs.x * rhs.x + lhs.y * rhs.y
  }
  
  static func ==(lhs: Self, rhs: Self) -> Bool {
    lhs.x == rhs.x && lhs.y == rhs.y
  }
  
  static func +(lhs: Self, rhs: Float) -> Self {
    .init(lhs.x + rhs, lhs.y + rhs)
  }
  
  static func +(lhs: Float, rhs: Self) -> Self {
    rhs + lhs
  }
  
  static func +(lhs: Self, rhs: Int) -> Self {
    lhs + Float(rhs)
  }

  static func +(lhs: Int, rhs: Self) -> Self {
    rhs + lhs
  }
  
  static func *(vec: Self, scalar: Int) -> Self {
    vec * Float(scalar)
  }
  
  static func /(lhs: Self, rhs: Float) -> Self {
    lhs * (1.0 / rhs)
  }
    
  static func /(lhs: Self, rhs: Int) -> Self {
    lhs / Float(rhs)
  }
  
}
