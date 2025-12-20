//
//  Settings.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 13/8/2024.
//

import HighlighterCommon
import SharedHelpers
import SwiftUI

extension BackingTextView {

  func setUpTextView(
    font defaultFont: NSFont,
    config: Editor.Configuration,
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

    let paragraphStyle = config.paragraphStyle

    font = defaultFont

    typingAttributes = [
      .font: defaultFont,
      .foregroundColor: NSColor.textColor,
      .paragraphStyle: paragraphStyle,
    ]

    defaultParagraphStyle = paragraphStyle

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
