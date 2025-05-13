//
//  Slay.swift
//  Yokta Beginnings
//
//  Created by Shon on 3/15/25.
//

import Foundation
import Raylib
import simd

typealias _SlayErrorHandler = (String) -> Void
typealias SlayErrorHandlerFunction = (SlayErrorData) -> Void
struct SlayErrorHandler {
  let errorHandlerFunction: SlayErrorHandlerFunction
  let userData: Any?
}

typealias SlayPoint = SIMD2<Double>
typealias SlaySize = SIMD2<Double>
extension SlaySize {
  var width: Double {
    get { self.x }
    set { self.x = newValue }
  }
  var height: Double {
    get { self.y }
    set { self.y = newValue }
  }
  
  public static func from(width: Double, height: Double) -> Self {
    return Self(x: width, y: height)
  }
  
  static var zero: Self {
    Self.from(width:0, height:0)
  }
  
  static var `default`: Self {
    .zero
  }
}
struct Rect {
  var origin: SlayPoint
  var size: SlaySize
  
  func contains(_ point: SlayPoint) -> Bool {
    return point.x >= origin.x &&
      point.x < origin.x + size.width &&
      point.y >= origin.y &&
      point.y < origin.y + size.height
  }
}

typealias SlayDimensions = SlaySize

struct SlayLayoutElementTreeRoot {
  let layoutElementIndex: Int
  let parentId: UInt // This can be zero in the case of the root layout tree
  let clipElementId: UInt // This can be zero if there is no clip element
  let zIndex: Int
  let pointerOffset: Vector2 // Only used when scroll containers are managed externally
}

struct SlayWrappedTextLine {
  let dimensions: SlayDimensions
  let line: String
}

struct SlayTextElementData {
  let text: String
  let preferredDimensions: SlayDimensions
  let elementIndex: Int
  let wrappedLines: [SlayWrappedTextLine] = []
}

struct SlaySizingMinMax {
  let min: Float
  let max: Float
  
  static var `default`: Self {
    Self(min: 0, max: 0)
  }
}

enum SlaySizingType : Int{
  case fit
  case grow
  case percent
  case fixed
  
  static var `default`: Self {
    .fit
  }
}

struct SlaySizingAxis {
  let minMax: SlaySizingMinMax
  let type: SlaySizingType
  let percent: Float
  
  static var `default`: Self {
    Self(minMax: .default, type: .default, percent: 0)
  }
}

struct SlaySizing {
  let width: SlaySizingAxis
  let height: SlaySizingAxis
  
  static var `default`: Self {
    Self(width: .default, height: .default)
  }
}

struct SlayPadding {
  let left: UInt
  let right: UInt
  let top: UInt
  let bottom: UInt
  
  static var `default`: Self {
    return Self(left: 0, right: 0, top: 0, bottom: 0)
  }
}

enum SlayLayoutDirection {
  case leftToRight
  case topToBottom
  
  static var `default`: Self {
    .leftToRight
  }
}

enum SlayLayoutAlignmentX: Int {
  case left
  case right
  case center
  
  static var `default`: Self {
    .left
  }
}

enum SlayLayoutAlignmentY : Int {
  case top
  case bottom
  case center
  
  static var `default`: Self {
    .top
  }
}

struct SlayChildAlignment {
  let x: SlayLayoutAlignmentX
  let y: SlayLayoutAlignmentY
  
  static var `default`: Self {
    Self(x: .default, y: .default)
  }
}

struct SlayLayoutConfig {
  let sizing: SlaySizing
  let padding: SlayPadding
  let childGap: UInt
  let childAlignment: SlayChildAlignment
  let layoutDirection: SlayLayoutDirection
  
  static var `default`: Self {
    return Self.init(sizing: .default, padding: .default, childGap: 0, childAlignment: .default, layoutDirection: .default)
  }
}

enum SlayElementConfigType {
  case none
  case border
  case floating
  case scroll
  case image
  case text
  
  static var `default`: Self {
    return .none
  }
}

enum SlayTextElementConfigWrapMode : UInt {
  case words
  case newlines
  case none
  
  static var `default`: Self {
    .none
  }
}

struct SlayColor {
  let r: Float, g: Float, b: Float, a: Float
  
  static var black: Self { Self(r: 0, g: 0, b: 0, a: 1) }
  static var white: Self { Self(r: 1, g: 1, b: 1, a: 1) }
  static var `default`: Self { .black }
}

struct SlayTextElementConfig {
  var textColor: SlayColor? = nil
  let fontId: UInt = 0
  let fontSize: UInt = 0
  let letterSpacing: UInt = 0
  let lineHeight: UInt = 0
  let wrapMode: SlayTextElementConfigWrapMode = .none
  let hashStringContents: Bool = false
  
  static var `default`: Self {
    Self()
  }
}

struct SlayImageElementConfig {
  let imageData: Data
  let sourceDimensions: SlayDimensions
  
  static var `default`: Self {
    Self(imageData: Data(), sourceDimensions: .zero)
  }
}

enum SlayFloatingAttachPointType {
  case leftTop
  case leftCenter
  case leftBottom
  case centerTop
  case centerCenter
  case centerBottom
  case rightTop
  case rightCenter
  case rightBottom
  
  static var `default`: Self {
    .leftTop
  }
}

struct SlayFloatingAttachPoints {
  let element: SlayFloatingAttachPointType = .default
  let parent: SlayFloatingAttachPointType = .default
  
  static var `default`: Self {
    Self()
  }
}

enum SlayPointerCaptureMode {
  case capture
  case passthrough
  
  static var `default`: Self {
    .passthrough
  }
}

enum SlayFloatingAttachToElement {
  case none
  case parent
  case elementWithId
  case root
  
  static var `default`: Self {
    .none
  }
}

struct SlayFloatingElementConfig {
  let offset: Vector2 = .zero
  let expand: SlayDimensions = .default
  let parentId: UInt = UInt.min
  let zIndex: Int = Int.min
  let attachPoints: SlayFloatingAttachPoints = .default
  let pointerCaptureMode: SlayPointerCaptureMode = .default
  let attachTo: SlayFloatingAttachToElement = .default
  
  static var `default`: Self {
    Self()
  }
}

struct SlayCustomElementConfig {
  let customData: Data = Data()
  
  static var `default`: Self {
    Self()
  }
}

struct SlayScrollElementConfig {
  let horizontal = false
  let vertical = false
  
  static var `default`: Self {
    Self()
  }
}

struct SlayBorderWidth {
  let left: UInt = 0
  let right: UInt = 0
  let top: UInt = 0
  let bottom: UInt = 0
  let betweenChildren = 0
  
  static var `default`: Self {
    Self()
  }
}

struct SlayBorderElementConfig {
  let color: SlayColor = .default
  let width: SlayBorderWidth = .default
  
  static var `default`: Self {
    Self()
  }
}

struct SlayCornerRadius {
  let topLeft: Float = 0
  let topRight: Float = 0
  let bottomLeft: Float = 0
  let bottomRight: Float = 0
  
  static var `default`: Self {
    Self()
  }
}

struct SlaySharedElementConfig {
  let backgroundColor: SlayColor = .default
  let cornerRadius: SlayCornerRadius = .default
  let userData: Any? = nil
  
  static var `default`: Self {
    Self()
  }
}

struct _SlayElementConfigWrapper {
  let config: SlayElementConfigUnion
}

struct SlayLayoutElementChildren {
  var elements: [Int] = []
  var length: UInt16 = 0
  
  static var `default`: Self {
    Self.init()
  }
}

class SlayLayoutElement {
  let children: SlayLayoutElementChildren = .default
  let textElementData: SlayTextElementData? = nil
  let which: SlayLayoutElementChildrenOrTextData = .children(.default)
  var dimensions: SlayDimensions? = nil
  var minDimensions: SlayDimensions? = nil
  let layoutConfig: SlayLayoutConfig? = nil
  var elementConfigs: [SlayElementConfigUnion] = []
  var id: UInt = 0
}

struct SlayBoundingBox {
  let x: Float = 0, y: Float = 0, width: Float = 0, height: Float = 0
  
  static var `default`: Self {
    Self.init()
  }
}

struct SlayScrollContainerDataInternal {
  let layoutElement: SlayLayoutElement
  let boundingBox: SlayBoundingBox
  let contentSize: SlayDimensions
  let scrollOrigin: Vector2
  let pointerOrigin: Vector2
  let scrollMomentum: Vector2
  let scrollPosition: Vector2
  let previousDelta: Vector2
  let momentumTime: Float
  let elementId: UInt
  let openThisFrame: Bool = false
  let pointerScrollActive: Bool = false

}

struct SlayWarning {
  let baseMessage: String
  let dynamicMessage: String
}

struct SlayBooleanWarnings {
  let maxElementsExceeded: Bool = false
  let maxRenderCommandsExceeded: Bool = false
  var maxTextMeasureCacheExceeded: Bool = false
  let textMeasurementFunctionNoSet: Bool = false
}

enum SlayPointerDataInteractionState: Int {
  case pressedThisFrame
  case pressed
  case releasedThisFrame
  case released
}

struct SlayPointerData {
  let position: Vector2 = .zero
  let state = SlayPointerDataInteractionState(rawValue: 0)
}

class SlayRenderData {}
class SlayRectangleRenderData {}
class SlayTextRenderData {}
class SlayImageRenderData {}
class SlayCustomRenderData {}
class SlayBorderRenderData {}

enum SlayRenderCommandType {
  case none
  case rectangle
  case border
  case text
  case image
  case scissorStart
  case scissorEnd
  case custom
}

struct SlayRenderCommand {
  let boundingBox: SlayBoundingBox
  let renderData: SlayRenderData
  let userData: Any
  let id: UInt
  let zIndex: Int
  let commandType: SlayRenderCommandType
}

struct SlayLayoutElementTreeNode {
  let layoutElement: SlayLayoutElement
  let position: Vector2
  let nextChildOffset: Vector2
}

struct SlayLayoutElementsHashMapItem {
  let boundingBox: SlayBoundingBox = .default
  var elementId: SlayElementId
  let layoutElement: SlayLayoutElement
  let onHover: (_ elementId: SlayElementId, _ pointerInfo: SlayPointerData, _ userData: Any) -> Void = { _,_,_ in return }
  let hoverFunctionUserData: Int? = nil
  var nextIndex: Int32
  var generation: UInt32
  let idAlias: UInt32
  var debugData: SlayDebugElementData?
}

struct SlayMeasureTextCacheItem {
  var unwrappedDimensions: SlayDimensions
  var measuredWordsStartIndex: Int
  var containsNewLines: Bool
  var id: UInt
  var nextIndex: Int
  var generation: Int
  
  init(unwrappedDimensions: SlayDimensions = .default, measuredWordsStartIndex: Int = -1, containsNewLines: Bool = false, id: UInt = .min, nextIndex: Int = -1, generation: Int = -1) {
    self.unwrappedDimensions = unwrappedDimensions
    self.measuredWordsStartIndex = measuredWordsStartIndex
    self.containsNewLines = containsNewLines
    self.id = id
    self.nextIndex = nextIndex
    self.generation = generation
  }
  
  static var `default`: Self {
    Self(unwrappedDimensions: .default, measuredWordsStartIndex: -1, id: 0, nextIndex: -1, generation: -1)
  }
}

class SlayMeasuredWord {
  let startOffset: Int
  let length: Int
  let width: Float
  var next: Int
  
  required init(startOffset: Int = -1, length: Int = -1, width: Float = 0, next: Int = -1) {
    self.startOffset = startOffset
    self.length = length
    self.width = width
    self.next = next
  }
  
  static var `default`: Self {
    Self.init()
  }
}

struct SlayDebugElementData {
  var collision: Bool = false
  let collapsed: Bool = false
  
  static var `default`: Self {
    Self.init()
  }
}

class SlayContext {
  let maxElementCountInt = 0
  let maxMeasureTextCacheWordCountInt = 0
  let warningsEnabled: Bool = false
  let errorHandler: SlayErrorHandler? = nil
  var booleanWarnings = SlayBooleanWarnings()
  let warnings: [SlayWarning] = []
  
  let pointerInfo = SlayPointerData()
  let layoutDimensions = SlayDimensions.zero
  let dynamicElementIndexBaseHash = SlayElementId()
  let dynamicElementIndexInt = 0
  let debugModeEnabled: Bool = false
  let disableCulling: Bool = false
  let externalScrollHandlingEnabled: Bool = false
  let generation: Int = 0
  //let arenaResetOffset: UInt
  let measureTextUserData: Any? = nil
  let queryScrollOffsetUserData: Any? = nil
  //let internalArena: SlayArena
  // Layout Elements / Render Commands
  let layoutElements: [SlayLayoutElement] = []
  let renderCommands: [SlayRenderCommand] = []
  let openLayoutElementsStack: [Int] = []
  var layoutElementChildren: [Int] = []
  let layoutElementChildrenBuffer: [Int] = []
  let textElementData: [SlayTextElementData] = []
  let imageElementPointers: [Int] = []
  let reusableElementIndexBuffer: [Int] = []
  let layoutElementClipElementIds: [Int] = []
  // Configs
  var layoutConfigs: [SlayLayoutConfig] = []
  var elementConfigs: [SlayElementConfigUnion] = []
  var textElementConfigs: [SlayTextElementConfig] = []
  var imageElementContigs: [SlayImageElementConfig] = []
  var floatingElementConfigs: [SlayFloatingElementConfig] = []
  var scrollElementConfigs: [SlayScrollElementConfig] = []
  var customElementConfigs: [SlayCustomElementConfig] = []
  var borderElementConfigs: [SlayBorderElementConfig] = []
  var sharedElementConfigs: [SlaySharedElementConfig] = []
  // Misc Data Structures
  var layoutElementIdStrings: [String] = []
  let wrappedTextLines: [SlayWrappedTextLine] = []
  let layoutElementTreeNodeArray1: [SlayLayoutElementTreeNode] = []
  let layoutElementTreeRoots: [SlayLayoutElementTreeRoot] = []
  var layoutElementsHashMapInternal: [SlayLayoutElementsHashMapItem] = []
  var layoutElementsHashMap: [Int] = []
  var measureTextHashMapInternal: [SlayMeasureTextCacheItem] = []
  let measureTextHashMapInternalFreeList: [Int] = []
  var measureTextHashMap: [Int] = []
  var measuredWords: [SlayMeasuredWord] = []
  let measuredWordsFreeList: [Int] = []
  var openClipElementStack: [Int] = []
  let pointerOvedIds: [SlayElementId] = []
  let scrollContainerData: [SlayScrollContainerDataInternal] = []
  let treeNodeVisited: [Bool] = []
  let dynamicStringData: [String] = []
  var debugElementData: [SlayDebugElementData] = []
  
  required init() {
    
  }
  
  private static let singleton = SlayContext()
  
  static var currentContext: SlayContext {
    return Self.singleton
  }
  
  func getOpenLayoutElement() -> SlayLayoutElement? {
    let index = openLayoutElementsStack.last ?? -1
    return layoutElements[index]
  }
  
  func getParentElementId() -> UInt {
    let index = openLayoutElementsStack.count - 2
    return layoutElements[index].id
  }
  
  func storeLayoutConfig(config: SlayLayoutConfig) -> SlayLayoutConfig {
    if booleanWarnings.maxElementsExceeded {
      return .default
    }
    
    layoutConfigs.append(config)
    
    return config
  }
  
  func storeTextElementConfig(config: SlayTextElementConfig) -> SlayTextElementConfig {
    if booleanWarnings.maxElementsExceeded {
      return .default
    }
    
    textElementConfigs.append(config)
    
    return config
  }
  
  func storeImageElementConfig(config: SlayImageElementConfig) -> SlayImageElementConfig {
    if booleanWarnings.maxElementsExceeded {
      return .default
    }
    
    imageElementContigs.append(config)
    
    return config
  }
  
  func storeFloatingElementConfig(config: SlayFloatingElementConfig) -> SlayFloatingElementConfig {
    if booleanWarnings.maxElementsExceeded {
      return .default
    }
    
    floatingElementConfigs.append(config)
    
    return config
  }
  
  func storeCustomElementConfig(config: SlayCustomElementConfig) -> SlayCustomElementConfig {
    if booleanWarnings.maxElementsExceeded {
      return .default
    }
    
    customElementConfigs.append(config)
    
    return config
  }
  
  func storeScrollElementConfig(config: SlayScrollElementConfig) -> SlayScrollElementConfig {
    if booleanWarnings.maxElementsExceeded {
      return .default
    }
    
    scrollElementConfigs.append(config)
    
    return config
  }
  
  func storeBorderElementConfig(config: SlayBorderElementConfig) -> SlayBorderElementConfig {
    if booleanWarnings.maxElementsExceeded {
      return .default
    }
    
    borderElementConfigs.append(config)
    
    return config
  }
  
  func storeSharedElementConfig(config: SlaySharedElementConfig) -> SlaySharedElementConfig {
    sharedElementConfigs.append(config)
    if booleanWarnings.maxElementsExceeded {
      return .default
    }
    
    return config
  }
  
  func attachElementConfig(config: SlayElementConfigUnion, type: SlayElementConfigType) -> SlayElementConfigUnion {
    if booleanWarnings.maxElementsExceeded {
      return SlayElementConfigUnion.default
    }
    
    let openLayoutElement = getOpenLayoutElement()
    openLayoutElement?.elementConfigs.append(config)
    
    return config
  }
  
  func findElementConfigWithType<T>(element: SlayLayoutElement) -> T? {
    return elementConfigs.first(of: T.self)
  }
  
  func addMeasuredWord(word: SlayMeasuredWord, previousWord: SlayMeasuredWord) -> SlayMeasuredWord {
    measuredWords.append(word)
    
    previousWord.next = measuredWords.count - 1
    return word
  }
  
  func measureTextCached(text: String, config: SlayTextElementConfig) -> SlayMeasureTextCacheItem {
    let id = text.hash(with: config)
    let hashBucket = Int(id) % maxMeasureTextCacheWordCountInt / 32
    var elementIndexPrevious = 0
    var elementIndex = measureTextHashMap[hashBucket]
    while elementIndex != 0 {
      var hashEntry = measureTextHashMapInternal[elementIndex]
      if hashEntry.id == id {
        hashEntry.generation = generation
        return hashEntry
      }
      
      if generation - hashEntry.generation > 2 {
        var nextWordIndex = hashEntry.measuredWordsStartIndex
        while nextWordIndex != -1 {
          let measuredWord = measuredWords[nextWordIndex]
          nextWordIndex = measuredWord.next
        }
        
        let nextIndex = hashEntry.nextIndex
        measuredWords[elementIndex] = .default
        if elementIndexPrevious == 0 {
          measureTextHashMap[hashBucket] = nextIndex
        } else {
          var previousHashEntry = measureTextHashMapInternal[elementIndexPrevious]
          previousHashEntry.nextIndex = nextIndex
        }
        elementIndex = nextIndex
      } else {
        elementIndexPrevious = elementIndex
        elementIndex = hashEntry.nextIndex
      }
    }
    
    let newItemIndex = 0
    let newCacheItem = SlayMeasureTextCacheItem.default
    var measured: SlayMeasureTextCacheItem? = nil
    
    if measureTextHashMapInternal.count ==
        measureTextHashMapInternal.capacity - 1 {
      
      if booleanWarnings.maxTextMeasureCacheExceeded {
        if let errorHandler = self.errorHandler {
          errorHandler.errorHandlerFunction(
            SlayErrorData(errorType: .elementsCapacityExceeded, errorText: "Slay ran out of capacity while attempting to measure text elements. Try using SlaySetMaxElementCount() with a higher value.", userData: errorHandler.userData)
          )
        }
      }
      return SlayMeasureTextCacheItem.default
    }
    measureTextHashMapInternal.append(newCacheItem)
    
    var start = 0
    var end = 0
    var lineWidth = 0.0
    var measuredWidth = 0.0
    var measuredHeight = 0.0
    let spaceWidth: Float = Float(SlayMeasureText(
      text: " ", config: config, userData: measureTextUserData).width)
    
    var tempWord: SlayMeasuredWord = .default
    var previousWord = tempWord
    
    while end < text.lengthOfBytes(using: .utf8) {
      if measuredWords.count == measuredWords.capacity - 1 {
        if !booleanWarnings.maxTextMeasureCacheExceeded {
          errorHandler?.errorHandlerFunction(
            SlayErrorData(errorType: .textMeasurementCapacityExceeded, errorText: "Slay has run out of space in its internal text measurement cache. Try using SlaySetMaxMeasureTextCacheWordCount() (default: 16384, with 1 unit storing 1 measured word).", userData: errorHandler?.userData))
          booleanWarnings.maxTextMeasureCacheExceeded = true
        }
        return .default
      }
      var current = text.last
      if current == " " || current == "\n" {
        let length = end - start
        var dimensions = SlayMeasureText(text: text[startingAt: start], config: config, userData: measureTextUserData)
        let measuredHeight = max(measuredHeight, dimensions.height)
        if current == " " {
          dimensions.width += CGFloat(spaceWidth)
          previousWord = 
          addMeasuredWord(word: SlayMeasuredWord(startOffset: start, length: length + 1, width: Float(dimensions.width), next: -1
          ), previousWord: previousWord)
        }
        if current == "\n" {
          if length > 0 {
            _ = addMeasuredWord(word: SlayMeasuredWord(
              startOffset: start, length: length, width: Float(dimensions.width), next: -1
            ), previousWord: previousWord)
          }
          previousWord = addMeasuredWord(word: SlayMeasuredWord(startOffset: end + 1, length: 0, width: Float(dimensions.width), next: -1),
              previousWord: previousWord)
          lineWidth += dimensions.width
          measuredWidth = max(lineWidth, measuredWidth)
          lineWidth = 0
        }
        start = end + 1
      }
      end += 1
    }
    if end - start > 0 {
      let dimensions = SlayMeasureText(text: text[startingAt: start], config: config, userData: measureTextUserData)
      _ = addMeasuredWord(word: SlayMeasuredWord(startOffset: start, length: end - start, width: Float(dimensions.width), next: -1), previousWord: previousWord)
      lineWidth += dimensions.width
      measuredHeight = max(measuredHeight, dimensions.height)
    }
    measuredWidth = max(lineWidth, measuredWidth)
  
    measured?.measuredWordsStartIndex = tempWord.next
    measured?.unwrappedDimensions.width = measuredWidth
    measured?.unwrappedDimensions.height = measuredHeight
    
    if elementIndexPrevious != 0 {
      measureTextHashMapInternal[elementIndexPrevious].nextIndex = newItemIndex
    } else {
      measureTextHashMap[hashBucket]
    }
    return measured ?? .default
  }
  
  func addHashMapItem(elementId: SlayElementId, layoutElement: SlayLayoutElement, idAlias: UInt) -> SlayLayoutElementsHashMapItem {
    var item = SlayLayoutElementsHashMapItem(elementId: elementId, layoutElement: layoutElement, nextIndex: -1, generation: UInt32(generation) + 1, idAlias: UInt32(idAlias), debugData: .default)
    let hashBucket = Int(elementId.id) % layoutElementsHashMap.capacity
    var hashItemPrevious: Int32 = -1
    var hashItemIndex: Int32 = 0
    while hashItemIndex != -1 {
      var hashItem = layoutElementsHashMapInternal[Int(hashItemIndex)]
      if hashItem.elementId.id == elementId.id {
        item.nextIndex = hashItem.nextIndex
        if hashItem.generation <= self.generation {
          hashItem.elementId = elementId
          hashItem.generation = UInt32(self.generation + 1)
        } else {
          self.errorHandler?.errorHandlerFunction(SlayErrorData(
            errorType: .duplicateId,
            errorText: "An element with this ID was already previously declared during this layout.", userData: self.errorHandler?.userData
          ))
          if self.debugModeEnabled {
            hashItem.debugData?.collision = true
          }
        }
        return hashItem
      }
      hashItemPrevious = hashItemIndex
      hashItemIndex = hashItem.nextIndex
    }
    self.layoutElementsHashMapInternal.append(item)
    var hashItem = item
    hashItem.debugData = SlayDebugElementData.default
    self.debugElementData.append(hashItem.debugData!)
    
    if hashItemPrevious != -1 {
      var prevItem = self.layoutElementsHashMapInternal[Int(hashItemPrevious)]
      prevItem.nextIndex = Int32(self.layoutElementsHashMapInternal.count - 1)
    } else {
      self.layoutElementsHashMap[hashBucket] = self.layoutElementsHashMapInternal.count - 1
    }
    return hashItem
  }
  
  func generateIdForAnonymousElement(openLayoutElement: SlayLayoutElement) {
    let parentIndex = self.openLayoutElementsStack.nthFromEnd(1)
    let parentElement = self.layoutElements[parentIndex!]
    let elementId = UInt32(parentElement.children.elements.count).hash(with: UInt32(parentElement.id))
    openLayoutElement.id = elementId.id
    _ = self.addHashMapItem(elementId: elementId, layoutElement: openLayoutElement, idAlias: 0)
    self.layoutElementIdStrings.append(elementId.stringId)
  }
  
  func closeElement() {
    if self.booleanWarnings.maxElementsExceeded {
      return
    }
    var elementHasScrollHorizontal = false
    var elementHasScrollVertical = false
    if var openLayoutElement = getOpenLayoutElement(), var layoutConfig = openLayoutElement.layoutConfig {
      var i = 0
      for config in openLayoutElement.elementConfigs {
        let childIndex = self.layoutElementChildrenBuffer.count -
        openLayoutElement.children.elements.count + i
        
        switch config {
        case .scrollElementConfig(let scrollConfig):
          elementHasScrollVertical = scrollConfig.vertical
          elementHasScrollHorizontal = scrollConfig.horizontal
          self.openClipElementStack.removeLast()
          break
        default: continue
        }
      
        switch openLayoutElement.which {
        case .children(var c):
          c.elements = [self.layoutElementChildren.last!]
          if layoutConfig.layoutDirection == .leftToRight {
            openLayoutElement.dimensions!.width = Double(layoutConfig.padding.left + layoutConfig.padding.right)
            for i in self.layoutElementChildrenBuffer {
              var child = self.layoutElements[i]
              openLayoutElement.dimensions?.width += child.dimensions!.width
              openLayoutElement.dimensions?.height = max(openLayoutElement.dimensions!.height, child.dimensions!.height + Double(layoutConfig.padding.top) + Double(layoutConfig.padding.bottom))
              if !elementHasScrollHorizontal {
                openLayoutElement.minDimensions!.width += child.minDimensions!.width
              }
              if !elementHasScrollVertical {
                openLayoutElement.minDimensions?.height = max(openLayoutElement.minDimensions!.height, child.minDimensions!.height + Double(layoutConfig.padding.top) + Double(layoutConfig.padding.bottom))
              }
              self.layoutElementChildren.append(childIndex)
            }
          }
          break
          
        default:
          break
        }
        
        i += 1
      }
    }
  }
}

enum SlayLayoutElementChildrenOrTextData {
  case textElementData(SlayTextElementData)
  case children(SlayLayoutElementChildren)
}

func SlayElementHasConfig(layoutElement: SlayLayoutElement, type: SlayElementConfigUnion) -> Bool {
  for i in 0 ..< layoutElement.elementConfigs.count {
    var layoutElementConfig = layoutElement.elementConfigs[i]
    if layoutElement.elementConfigs[i].caseIdentifier == type.caseIdentifier {
      return true
    }
  }
  return false
}

func SlayMeasureText(text: String, config: SlayTextElementConfig, userData: Any?) -> SlayDimensions {
  return .default
}

typealias SlayOnHover = (_ elementId: SlayElementId, _ pointerInfo: SlayPointerData, _ userData: Any) -> Void

struct _SlayLayoutElementHashMapItem {
  let boundingBox: SlayBoundingBox? = nil
  let elementId: SlayElementId
  let layoutElement: SlayLayoutElement
  let onHover: SlayOnHover? = nil
  let hoverFunctionUserData: Any? = nil
  var nextIndex: Int32
  let generation: UInt32
  let idAlias: UInt32
  let debugData: SlayDebugElementData? = nil
}

enum SlayErrorType {
  case textMeasurementFunctionNotProvider
  case arenaCapacityExceeded
  case elementsCapacityExceeded
  case textMeasurementCapacityExceeded
  case duplicateId
  case floatingContainerParentNotFound
  case internalError
  
  static var `default`: Self {
    .internalError
  }
}

struct SlayErrorData {
  let errorType: SlayErrorType
  let errorText: String
  let userData: Any?
  
  static var `default`: Self {
    return Self(errorType: .default, errorText: "", userData: nil)
  }
}

enum SlayElementConfigUnion {
  case none
  case textElementConfig(SlayTextElementConfig)
  case imageElementConfig(SlayImageElementConfig)
  case floatingElementConfig(SlayFloatingElementConfig)
  case customElementConfig(SlayCustomElementConfig)
  case scrollElementConfig(SlayScrollElementConfig)
  case borderElementConfig(SlayBorderElementConfig)
  case sharedElementConfig(SlaySharedElementConfig)
  
  var caseIdentifier: CaseIdentifier {
    switch self {
    case .borderElementConfig(_): return .borderElementConfig
    case .none: return .none
    case .textElementConfig(_): return .textElementConfig
    case .imageElementConfig(_): return .imageElementConfig
    case .floatingElementConfig(_): return .floatingElementConfig
    case .customElementConfig(_): return .customElementConfig
    case .scrollElementConfig(_): return .scrollElementConfig
    case .sharedElementConfig(_): return .sharedElementConfig
    }
  }
  
  enum CaseIdentifier {
    case none, textElementConfig, imageElementConfig, floatingElementConfig, customElementConfig, scrollElementConfig, borderElementConfig, sharedElementConfig
  }
  
  static var `default`: Self {
    .none
  }
}

extension String {
  func hash(offset: UInt, seed: UInt) -> SlayElementId {
    var hash: UInt = 0
    var base = seed
    let key = self
    
    for c in key {
      base += UInt(c.asciiValue ?? 0)
      base += (base << 10)
      base ^= (base >> 6)
    }
    hash = base
    hash += offset
    hash += (hash << 10)
    hash ^= (hash >> 6)
    
    hash += (hash << 3)
    hash += (base << 3)
    hash ^= (hash >> 11)
    hash ^= (base >> 11)
    hash += (hash << 15)
    hash += (base << 15)
    
    return SlayElementId()
  }
  
  func hash(with config: SlayTextElementConfig) -> UInt {
    let text = self
    
    var hash: UInt = 0
    var pointerAsNumber: UInt = address(ofAny: text) ?? 0
    
    if config.hashStringContents {
      let maxLengthToHash = min(text.lengthOfBytes(using: .utf8), 256)
      for c in text.prefix(maxLengthToHash) {
        hash += UInt(c.asciiValue ?? 0)
        hash += (hash << 10)
        hash ^= (hash >> 6)
      }
    } else {
      hash += pointerAsNumber
      hash += (hash << 10)
      hash ^= (hash >> 6)
    }
    
    hash += UInt(text.lengthOfBytes(using: .utf8))
    hash += (hash << 10)
    hash ^= (hash >> 6)
    
    hash += config.fontId
    hash += (hash << 10)
    hash ^= (hash >> 6)

    hash += config.fontSize
    hash += (hash << 10)
    hash ^= (hash >> 6)
    
    hash += config.lineHeight
    hash += (hash << 10)
    hash ^= (hash >> 6)
    
    hash += config.letterSpacing
    hash += (hash << 10)
    hash ^= (hash >> 6)

    hash += config.wrapMode.rawValue
    hash += (hash << 10)
    hash ^= (hash >> 6)
    
    hash += (hash << 3)
    hash ^= (hash >> 11)
    hash += (hash << 15)
    
    return hash + 1
  }
  
}

func address(ofAny object: Any) -> UInt? {
  guard let ref = object as AnyObject? else { return nil }
  let ptr = Unmanaged.passUnretained(ref).toOpaque()
  return UInt(bitPattern: ptr)
}

extension Array where Element == SlayElementConfigUnion {
  func first<T>(of type: T.Type = T.self) -> T? {
    for item in self {
      switch item {
      case let .textElementConfig(value as T): return value
      case let .imageElementConfig(value as T): return value
      case let .floatingElementConfig(value as T): return value
      case let .customElementConfig(value as T): return value
      case let .scrollElementConfig(value as T): return value
      case let .borderElementConfig(value as T): return value
      case let .sharedElementConfig(value as T): return value
        // Add other cases as needed
      default: continue
      }
    }
    return nil
  }
}

struct SlayElementConfig {
  var type: SlayElementConfigType = .default
  var config: SlayElementConfigUnion = .default
  
  init(type: SlayElementConfigType, config: SlayElementConfigUnion) {
    self.type = type
    self.config = config
  }
  
  init() { }
  
  static var `default`: Self {
    Self()
  }
}

struct SlayElementId {
  let id: UInt
  let offset: UInt
  let baseId: UInt
  let stringId: String
  
  init(id: UInt = 0, offset: UInt = 0, baseId: UInt = 0, stringId: String = "") {
    self.id = id
    self.offset = offset
    self.baseId = baseId
    self.stringId = stringId
  }
  
  static var `default`: Self {
    Self.init()
  }
}

let SPACECHAR = " "
let STRING_DEFAULT = ""

extension String {
  subscript(startingAt i: Int) -> String {
    let start = index(startIndex, offsetBy: i)
    return String(self[start...])
  }
}

extension Collection {
    /// Returns the element that is `n` positions from the end of the collection.
    /// `n = 0` returns the last element, `n = 1` returns the second-to-last, etc.
    func nthFromEnd(_ n: Int) -> Element? {
        guard n >= 0, n < count else { return nil }
        return self[index(endIndex, offsetBy: -(n + 1))]
    }
}

extension UInt32 {
  func hash(with seed: UInt32) -> SlayElementId {
    var offset = self
    var hash: UInt32 = seed
    hash += (offset + 48)
    hash += (hash << 10)
    hash ^= (hash >> 6)
    
    hash += (hash << 3)
    hash ^= (hash >> 11)
    hash += (hash << 15)
    
    return SlayElementId(id: UInt(hash) + 1, offset: UInt(offset), baseId: UInt(seed), stringId: "")
  }
}
