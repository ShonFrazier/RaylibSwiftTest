//
//  Matrix.swift
//  Yokta Beginnings
//
//  Created by Shon on 3/14/25.
//

import Raylib

extension Matrix : Hashable {
  public static func ==(lhs: Matrix, rhs: Matrix) -> Bool {
    abs(lhs.m0 - rhs.m0).magnitude < 1e-6 &&
    abs(lhs.m1 - rhs.m1).magnitude < 1e-6 &&
    abs(lhs.m2 - rhs.m2).magnitude < 1e-6 &&
    abs(lhs.m3 - rhs.m3).magnitude < 1e-6 &&
    abs(lhs.m4 - rhs.m4).magnitude < 1e-6 &&
    abs(lhs.m5 - rhs.m5).magnitude < 1e-6 &&
    abs(lhs.m6 - rhs.m6).magnitude < 1e-6 &&
    abs(lhs.m7 - rhs.m7).magnitude < 1e-6 &&
    abs(lhs.m8 - rhs.m8).magnitude < 1e-6 &&
    abs(lhs.m9 - rhs.m9).magnitude < 1e-6 &&
    abs(lhs.m10 - rhs.m10).magnitude < 1e-6 &&
    abs(lhs.m11 - rhs.m11).magnitude < 1e-6 &&
    abs(lhs.m12 - rhs.m12).magnitude < 1e-6 &&
    abs(lhs.m13 - rhs.m13).magnitude < 1e-6 &&
    abs(lhs.m14 - rhs.m14).magnitude < 1e-6 &&
    abs(lhs.m15 - rhs.m15).magnitude < 1e-6
  }
  
  public func hash(into hasher: inout Hasher) {
    for m in [m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15] {
      m.hash(into: &hasher)
    }
  }
}
