//
//  Font+Preset.swift
//  SwiftDown
//
//  Created by Dave Coleman on 26/2/2025.
//

import NSUI

//public typealias FontPresetGroup = [FontStyleType: FontConfig]
//
//public enum FontStyleType: CaseIterable {
//  case bold
//  case italic
//  case boldItalic
//  case body
//  case monospaced
//  
//  public func preset(withSize size: CGFloat) -> FontConfig {
//    switch self {
//      case .bold: FontConfig.system(size: size, weight: .bold)
//      case .italic: FontConfig.system(size: size, traits: .traitItalic)
//      case .boldItalic: FontConfig.system(size: size, weight: .bold, traits: .traitItalic)
//      case .body: FontConfig.system(size: size)
//      case .monospaced: FontConfig.system(size: size, design: .monospaced)
//    }
//  }
//  
//  public func presetGroup(withSize size: CGFloat) -> FontPresetGroup {
//    var map: FontPresetGroup = [:]
//    for preset in FontStyleType.allCases {
//      map[preset] = preset.preset(withSize: size)
//    }
//    return map
//  }
//}
//
