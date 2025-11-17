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

  func setUpTextView(_ config: Editor.Configuration) {

    isEditable = config.isEditable
    drawsBackground = false
    isRichText = false
    allowsUndo = true
    isSelectable = true

    isRichText = false
    textColor = config.colours.nsColor(for: \.body)
    isAutomaticQuoteSubstitutionEnabled = false
    isAutomaticDashSubstitutionEnabled = false
    isAutomaticSpellingCorrectionEnabled = false

    self.setInsets(config.insets)

    font = config.defaultFont

    typingAttributes = config.typingAttributes
    defaultParagraphStyle = config.paragraphStyle

    isVerticallyResizable = true
    isHorizontallyResizable = false

    let max = CGFloat.greatestFiniteMagnitude

    maxSize = NSSize(
      width: max,
      height: max
    )
    textContainer?.widthTracksTextView = true

    //
    //
    //
    //    minSize = NSSize.zero
    //    maxSize = NSSize(width: max, height: max)
    //
    //    isAutomaticDashSubstitutionEnabled = false
    //
    //    autoresizingMask = [.width]
    //
    //    textContainer?.widthTracksTextView = true
    //    textContainer?.heightTracksTextView = false
    //
    //    textContainer?.lineFragmentPadding = config.theme.insets
    //    textContainerInset = NSSize(
    //      width: 0,
    //      height: config.theme.insets
    //    )
    //    font = NSFont.systemFont(
    //      ofSize: config.theme.fontSize)
    //

  }

}
