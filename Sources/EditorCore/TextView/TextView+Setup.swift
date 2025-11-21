//
//  Settings.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 13/8/2024.
//

import HighlighterCommon
import SharedHelpers
//import BaseHelpers
import SwiftUI

extension BackingTextView {

  func setUpTextView(
//    fontSize: CGFloat,
    config: Editor.Configuration
  ) {

    isEditable = config.isEditable
    drawsBackground = false
    isRichText = false
    allowsUndo = true
    isSelectable = true

    isRichText = false
    textColor = NSColor.textColor

    isAutomaticQuoteSubstitutionEnabled = false
    isAutomaticDashSubstitutionEnabled = false
    isAutomaticSpellingCorrectionEnabled = false

    self.setInsets(config.insets)

//    let defaultFont = NSFont.systemFont(ofSize: fontSize)
    font = config.defaultFont
    typingAttributes = config.typingAttributes
//    typingAttributes = config.typingAttributes(with: defaultFont)
    defaultParagraphStyle = config.paragraphStyle

    isVerticallyResizable = true
    isHorizontallyResizable = false

    let max = CGFloat.greatestFiniteMagnitude

    maxSize = NSSize(
      width: max,
      height: max
    )
    textContainer?.widthTracksTextView = true

  }

}
