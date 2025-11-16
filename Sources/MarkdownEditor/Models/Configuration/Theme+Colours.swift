//
//  Theme+Colours.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import Foundation
import ColourKit

extension Markdown {
  
  /// This doesn't include source code theme, this is
  /// handled elsewhere
  public struct Colours {
    let body: ColourPair
    let inlineCode: ColourPair
    let blockCode: ColourPair
    let strikeThrough: ColourPair
    let highlight: ColourPair
  }
}
