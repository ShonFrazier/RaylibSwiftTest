//
//  ThreeDModelsStage.swift
//  Yokta Beginnings
//
//  Created by Shon on 3/13/25.
//

import Foundation
import Raylib

let FORMAT = "gltf"
let COLOR = "green"

let MODELS_PARENT = "/Users/shon/Downloads/KayKit_Platformer_Pack_1.0_SOURCE/Assets/\(FORMAT)/\(COLOR)"

let KAY_GREEN_GLTF_MODELS = [
  "arch_\(COLOR).\(FORMAT)",
  "arch_tall_\(COLOR).\(FORMAT)",
  "arch_wide_\(COLOR).\(FORMAT)",
  "ball_\(COLOR).\(FORMAT)",
  "barrier_1x1x1_\(COLOR).\(FORMAT)",
  "barrier_1x1x2_\(COLOR).\(FORMAT)",
  "barrier_1x1x4_\(COLOR).\(FORMAT)",
  "barrier_2x1x1_\(COLOR).\(FORMAT)",
  "barrier_2x1x2_\(COLOR).\(FORMAT)",
  "barrier_2x1x4_\(COLOR).\(FORMAT)",
  "barrier_3x1x1_\(COLOR).\(FORMAT)",
  "barrier_3x1x2_\(COLOR).\(FORMAT)",
  "barrier_3x1x4_\(COLOR).\(FORMAT)",
  "barrier_4x1x1_\(COLOR).\(FORMAT)",
  "barrier_4x1x2_\(COLOR).\(FORMAT)",
  "barrier_4x1x4_\(COLOR).\(FORMAT)",
  "bomb_A_\(COLOR).\(FORMAT)",
  "bomb_B_\(COLOR).\(FORMAT)",
  "bracing_large_\(COLOR).\(FORMAT)",
  "bracing_medium_\(COLOR).\(FORMAT)",
  "bracing_small_\(COLOR).\(FORMAT)",
  "button_base_\(COLOR).\(FORMAT)",
  "cannon_base_\(COLOR).\(FORMAT)",
  "chest_\(COLOR).\(FORMAT)",
  "chest_large_\(COLOR).\(FORMAT)",
  "cone_\(COLOR).\(FORMAT)",
  "conveyor_2x4x1_\(COLOR).\(FORMAT)",
  "conveyor_2x8x1_\(COLOR).\(FORMAT)",
  "conveyor_4x4x1_\(COLOR).\(FORMAT)",
  "conveyor_4x8x1_\(COLOR).\(FORMAT)",
  "diamond_\(COLOR).\(FORMAT)",
  "flag_A_\(COLOR).\(FORMAT)",
  "flag_B_\(COLOR).\(FORMAT)",
  "flag_C_\(COLOR).\(FORMAT)",
  "floor_net_2x2x1_\(COLOR).\(FORMAT)",
  "floor_net_4x4x1_\(COLOR).\(FORMAT)",
  "floor_spikes_trap_2x2x1_\(COLOR).\(FORMAT)",
  "floor_spikes_trap_4x4x1_\(COLOR).\(FORMAT)",
  "hammer_\(COLOR).\(FORMAT)",
  "hammer_large_\(COLOR).\(FORMAT)",
  "hammer_large_spikes_\(COLOR).\(FORMAT)",
  "hammer_spikes_\(COLOR).\(FORMAT)",
  "heart_\(COLOR).\(FORMAT)",
  "hoop_angled_\(COLOR).\(FORMAT)",
  "hoop_\(COLOR).\(FORMAT)",
  "lever_floor_base_\(COLOR).\(FORMAT)",
  "lever_wall_base_A_\(COLOR).\(FORMAT)",
  "lever_wall_base_B_\(COLOR).\(FORMAT)",
  "pipe_180_A_\(COLOR).\(FORMAT)",
  "pipe_180_B_\(COLOR).\(FORMAT)",
  "pipe_90_A_\(COLOR).\(FORMAT)",
  "pipe_90_B_\(COLOR).\(FORMAT)",
  "pipe_end_\(COLOR).\(FORMAT)",
  "pipe_straight_A_\(COLOR).\(FORMAT)",
  "pipe_straight_B_\(COLOR).\(FORMAT)",
  "platform_1x1x1_\(COLOR).\(FORMAT)",
  "platform_2x2x1_\(COLOR).\(FORMAT)",
  "platform_2x2x2_\(COLOR).\(FORMAT)",
  "platform_2x2x4_\(COLOR).\(FORMAT)",
  "platform_4x2x1_\(COLOR).\(FORMAT)",
  "platform_4x2x2_\(COLOR).\(FORMAT)",
  "platform_4x2x4_\(COLOR).\(FORMAT)",
  "platform_4x4x1_\(COLOR).\(FORMAT)",
  "platform_4x4x2_\(COLOR).\(FORMAT)",
  "platform_4x4x4_\(COLOR).\(FORMAT)",
  "platform_6x2x1_\(COLOR).\(FORMAT)",
  "platform_6x2x2_\(COLOR).\(FORMAT)",
  "platform_6x2x4_\(COLOR).\(FORMAT)",
  "platform_6x6x1_\(COLOR).\(FORMAT)",
  "platform_6x6x2_\(COLOR).\(FORMAT)",
  "platform_6x6x4_\(COLOR).\(FORMAT)",
  "platform_arrow_2x2x1_\(COLOR).\(FORMAT)",
  "platform_arrow_4x4x1_\(COLOR).\(FORMAT)",
  "platform_decorative_1x1x1_\(COLOR).\(FORMAT)",
  "platform_decorative_2x2x2_\(COLOR).\(FORMAT)",
  "platform_hole_6x6x1_\(COLOR).\(FORMAT)",
  "platform_slope_2x2x2_\(COLOR).\(FORMAT)",
  "platform_slope_2x4x4_\(COLOR).\(FORMAT)",
  "platform_slope_2x6x4_\(COLOR).\(FORMAT)",
  "platform_slope_4x2x2_\(COLOR).\(FORMAT)",
  "platform_slope_4x4x4_\(COLOR).\(FORMAT)",
  "platform_slope_4x6x4_\(COLOR).\(FORMAT)",
  "platform_slope_6x2x2_\(COLOR).\(FORMAT)",
  "platform_slope_6x4x4_\(COLOR).\(FORMAT)",
  "platform_slope_6x6x4_\(COLOR).\(FORMAT)",
  "power_\(COLOR).\(FORMAT)",
  "railing_corner_double_\(COLOR).\(FORMAT)",
  "railing_corner_padded_\(COLOR).\(FORMAT)",
  "railing_corner_single_\(COLOR).\(FORMAT)",
  "railing_straight_double_\(COLOR).\(FORMAT)",
  "railing_straight_padded_\(COLOR).\(FORMAT)",
  "railing_straight_single_\(COLOR).\(FORMAT)",
  "safetynet_2x2x1_\(COLOR).\(FORMAT)",
  "safetynet_4x2x1_\(COLOR).\(FORMAT)",
  "safetynet_6x2x1_\(COLOR).\(FORMAT)",
  "saw_trap_double_\(COLOR).\(FORMAT)",
  "saw_trap_\(COLOR).\(FORMAT)",
  "saw_trap_long_\(COLOR).\(FORMAT)",
  "signage_arrow_stand_\(COLOR).\(FORMAT)",
  "signage_arrow_wall_\(COLOR).\(FORMAT)",
  "signage_arrows_left_\(COLOR).\(FORMAT)",
  "signage_arrows_right_\(COLOR).\(FORMAT)",
  "spikeblock_double_horizontal_\(COLOR).\(FORMAT)",
  "spikeblock_double_vertical_\(COLOR).\(FORMAT)",
  "spikeblock_down_\(COLOR).\(FORMAT)",
  "spikeblock_left_\(COLOR).\(FORMAT)",
  "spikeblock_omni_\(COLOR).\(FORMAT)",
  "spikeblock_quad_\(COLOR).\(FORMAT)",
  "spikeblock_right_\(COLOR).\(FORMAT)",
  "spikeblock_up_\(COLOR).\(FORMAT)",
  "spring_pad_\(COLOR).\(FORMAT)",
  "star_\(COLOR).\(FORMAT)",
  "swiper_double_\(COLOR).\(FORMAT)",
  "swiper_double_long_\(COLOR).\(FORMAT)",
  "swiper_\(COLOR).\(FORMAT)",
  "swiper_long_\(COLOR).\(FORMAT)",
  "swiper_quad_\(COLOR).\(FORMAT)",
  "swiper_quad_long_\(COLOR).\(FORMAT)",
]

enum LightType : Int32 {
  case none = 0,
       directional,
       point
  
  static var `default`: Self { .none }
}

struct Light {
  var type: LightType
  var enabled: Bool
  var position: Vector3
  var target: Vector3
  var color: RColor
  var attenuation: Float
  
  var enabledLoc: Int32
  var typeLoc: Int32
  var positionLoc: Int32
  var targetLoc: Int32
  var colorLoc: Int32
  var attenuationLoc: Int32
  
  static var `default`: Self {
    Self(type: .default, enabled: false, position: .zero, target: .zero, color: BLANK, attenuation: 0, enabledLoc: 0, typeLoc: 0, positionLoc: 0, targetLoc: 0, colorLoc: 0, attenuationLoc: 0)
  }
}

func CreateLight(_ type: LightType, _ position: Vector3, _ target: Vector3, _ color: RColor, _ shader: Shader) -> Light {
  var light = Light.default;

  light.enabled = true;
  light.type = type;
  light.position = position;
  light.target = target;
  light.color = color;
  
  // NOTE: Lighting shader naming must be the provided ones
  light.enabledLoc = GetShaderLocation(shader, "light.enabled");
  light.typeLoc = GetShaderLocation(shader, "lights.type");
  light.positionLoc = GetShaderLocation(shader, "light.position");
  light.targetLoc = GetShaderLocation(shader, "light.target");
  light.colorLoc = GetShaderLocation(shader, "light.color");
  
  UpdateLightValues(shader, &light);
  
  return light;
}

func UpdateLightValues(_ shader: Shader, _ light: inout Light) {
  // Send to shader light enabled state and type
  SetShaderValue(
    shader,
    light.enabledLoc,
    &(light.enabled),
    Int32(SHADER_UNIFORM_INT.rawValue)
  );
  SetShaderValue(shader, light.typeLoc, &(light.type), Int32(SHADER_UNIFORM_INT.rawValue))
  
  // Send to shader light position values
  let position: [Float] = [ light.position.x, light.position.y, light.position.z ]
  SetShaderValue(shader, light.positionLoc, position, Int32(SHADER_UNIFORM_VEC3.rawValue))
  
  // Send to shader light target position values
  let target: [Float] = [ light.target.x, light.target.y, light.target.z ]
    SetShaderValue(shader, light.targetLoc, target, Int32(SHADER_UNIFORM_VEC3.rawValue))
  
  // Send to shader light color values
  let color: [Float] = [
    Float(light.color.r) / 255.0,
    Float(light.color.g) / 255.0,
    Float(light.color.b) / 255.0,
    Float(light.color.a) / 255.0
  ];
  SetShaderValue(shader, light.colorLoc, color, Int32(SHADER_UNIFORM_VEC4.rawValue));
}

class CameraMotion {
  var rotation: Vector3 = .zero // Store the camera's rotation as Euler angles
  var positionOffset: Vector3 = .zero// Store the camera's position offset
  var targetPositionOffset: Vector3 = .zero
  var upOffset: Vector3 = .zero
  var speed: Float = 0 // Camera speed
  var sensitivity: Float = 1 // Mouse sensitivity
  var sensitivityRotation: Float = 1 // Mouse sensitivity for rotation
  var sensitivityPan: Float = 1  // Mouse sensitivity for panning
  var sensitivityZoom: Float = 1 // Mouse sensitivity for zooming
  var prevMousePos: Vector2 = .zero // Store the previous mouse position
  var isRotating: Bool = false // Flag to check if the camera is rotating
  var isPanning: Bool = false // Flag to check if the camera is panning
  var isZooming: Bool = false // Flag to check if the camera is zooming
}

class ThreeDModelsStage : Stage {
  let models: [Model]
  var camera: Camera
  let camMotion = CameraMotion()
  
  init(models: [Model]) {
    self.models = models
    self.camera = Camera(
      position: Vector3(x: 15.0, y: 15.0, z: 15.0),
      target: Vector3(x: 0.0, y: 0.0, z: 0.0),
      up: Vector3(x: 0.0, y: 1.0, z: 0.0),
      fovy: 45.0,
      projection: Int32(CAMERA_PERSPECTIVE.rawValue)
    )
    
    let shader = LoadShader("resources/shaders/glsl330/lighting.vs", "resources/shaders/glsl330/lighting.fs")
    
    let light = CreateLight(.point, Vector3( -2, 1, -2 ), .zero, WHITE, shader)
  }
  
  convenience init(fromFile atPath: String) {
    self.init(fromFiles: [atPath])
  }
  
  convenience init(fromFiles atPaths: [String] = Array(KAY_GREEN_GLTF_MODELS[ 5 ... 13 ])) {
    let models = atPaths.map { path in
      let fullPath = "\(MODELS_PARENT)/\(path)"
      return LoadModel(fullPath)
    }
    self.init(models: models)
  }
  
  override func draw() {
    /*
    let currMousePos = GetMousePosition()
    let prevMousePos = self.camMotion.prevMousePos
    
    // Check if the left mouse button is pressed
    if IsMouseButtonPressed(Int32(MOUSE_BUTTON_LEFT.rawValue)) {
      // Calculate the mouse delta
      let mouseDelta = (currMousePos - prevMousePos) * camMotion.sensitivity
      
      // Update the camera's rotation
      camMotion.rotation += mouseDelta.vec3
      
      // Update the camera's position and target
      // We'll implement this later
    }
    
    // Update the previous mouse position
    camMotion.prevMousePos = currMousePos
    
    camera.position += camMotion.positionOffset
    camera.target += camMotion.targetPositionOffset
    camera.up += camMotion.upOffset
    */
    
    BeginDrawing()
    defer { EndDrawing() }
    
    ClearBackground(Color(r: 0, g: 0, b: 127, a: 255))
    
    BeginMode3D(self.camera)
    defer { EndMode3D() }
    
    UpdateCamera(&self.camera, CameraMode.free.rawValue)
    
    var x: Float = 0
    
    models.forEach({ model in
      DrawModel(model, Vector3(x, 0, 0), 1.0, WHITE)
      
      if model.meshCount > 0, let meshes = model.meshes {
        let box = GetMeshBoundingBox(meshes[0])
        
        let szx = box.max.x - box.min.x
        let szy = box.max.y - box.min.y
        let szz = box.max.z - box.min.z
        
        let maxsz = max(szx, max( szy, szz ))
       
        x += (maxsz + 0.5)
      }
    })
  }
}

enum CameraMode : Int32 {
  case custom
  case free
  case orbital
  case firstPerson
  case thirdPerson
}
