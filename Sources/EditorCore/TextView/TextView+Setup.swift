//
//  Settings.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 13/8/2024.
//

//import SharedHelpers
import CoreTools
import SwiftUI

extension NSTextView {

  func setUpTextView() {
    drawsBackground = false
    isRichText = false
    allowsUndo = true
    isSelectable = true

    isRichText = false
    textColor = NSColor.textColor

    isAutomaticQuoteSubstitutionEnabled = false
    isAutomaticDashSubstitutionEnabled = false
    isAutomaticSpellingCorrectionEnabled = false

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
