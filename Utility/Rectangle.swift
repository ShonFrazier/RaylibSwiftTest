//
//  Rectangle.swift
//  Yokta Beginnings
//
//  Created by Shon on 5/5/25.
//

import Raylib

extension Rectangle {
  init(center: Vector2, size: Vector2) {
    self.init(
      x: center.x - size.x / 2,
      y: center.y - size.y / 2,
      width: size.x,
      height: size.y
    )
  }
  
  init(origin: Position2, size: Size) {
    self.init(x: origin.x, y: origin.y, width: size.width(), height: size.height())
  }
  
  init(for texture: Texture2D) {
    self.init(x: 0, y: 0, width: Float(texture.width), height: Float(texture.height))
  }
  
  var origin: Position2 { .init(x: x, y: y) }
  var size: Size { .init(width: width, height: height) }
  
  static let zero: Self = .init(origin: .zero, size: .zero)
  
  static func *(rec: Self, scalar: Float) -> Self {
    .init(
      x: rec.x * scalar,
      y: rec.y * scalar,
      width: rec.width * scalar,
      height: rec.height * scalar
    )
  }
  
  func scaled(within container: Rectangle, options: ScalingOptions = .default) -> (rec: Rectangle, scale: Float) {
    // Determine scaling factor depending on the chosen scaling option.
    let scaleFactor: Float
    let aspectWidth = container.width / self.width
    let aspectHeight = container.height / self.height
    
    if options.contains(.fill) {
      // Scale to fill the container (use the larger scale factor)
      scaleFactor = max(aspectWidth, aspectHeight)
    } else { // default to .fit
      // Scale to fit within the container (use the smaller scale factor)
      scaleFactor = min(aspectWidth, aspectHeight)
    }
    
    // Compute new size
    let newSize = Size(width: self.width * scaleFactor,
                      height: self.height * scaleFactor)
    var newOrigin = container.origin
    
    // If centered is set, adjust origin to center the scaled rectangle within the container.
    if options.contains(.center) {
      let offsetX: Float = (container.size.width() - newSize.width()) / 2.0
      let offsetY: Float = (container.size.height() - newSize.height()) / 2.0
      newOrigin = Position2(x: container.origin.x + offsetX, y: container.origin.y + offsetY)
    }
    
    return (Rectangle(origin: newOrigin, size: newSize), scaleFactor)
  }
  
  static func ==(lhs: Rectangle, rhs: Rectangle) -> Bool {
    lhs.x == rhs.x &&
    lhs.y == rhs.y &&
    lhs.width == rhs.width &&
    lhs.height == rhs.height
  }
  
  static func !=(lhs: Rectangle, rhs: Rectangle) -> Bool {
    !(lhs == rhs)
  }

  struct ScalingOptions : OptionSet {
    let rawValue: Int
    
    static let fit = ScalingOptions(rawValue: 1 << 0)
    static let fill = ScalingOptions(rawValue: 1 << 1)
    static let center = ScalingOptions(rawValue: 1 << 2)
    
    static let `default` : ScalingOptions = [.fit, .center]
  }
}

extension Size {
  static let zero: Self = .init(width: 0, height: 0)
  
  static func *(size: Self, scalar: Int32) -> Self {
    .init(width: size.width() * scalar, height: size.height() * scalar)
  }
  
  static func /(size: Self, divisor: Int32) -> Self {
    .init(width: size.width() / divisor, height: size.height() / divisor)
  }
  
  func scale(fit within: Size) -> Float {
    min(within.width() / self.width(), within.height() / self.height())
  }
  
  func scaled(fit within: Size) -> Size {
    self * Int32(scale(fit: within))
  }
}

