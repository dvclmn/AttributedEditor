//
//  HorizontalRuleAtt.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 18/11/2025.
//

import AppKit

/// NSTextAttachmentCell that draws a horizontal rule
class HorizontalRuleAttachmentCell: NSTextAttachmentCell {
  
  /// Height of the rule in points
  var ruleHeight: CGFloat = 2
  
  /// Draw the horizontal line across the attachment's width
  override func draw(withFrame cellFrame: NSRect, in controlView: NSView?) {
    NSColor.separatorColor.setFill()
    let ruleRect = NSRect(
      x: cellFrame.minX,
      y: cellFrame.midY - ruleHeight/2,
      width: cellFrame.width,
      height: ruleHeight
    )
    ruleRect.fill()
  }
  
  /// Make the attachment occupy the full width of the text container
  override var cellSize: NSSize {
    guard let textView = controlView as? NSTextView else {
      return super.cellSize
    }
    let width = textView.textContainer?.size.width ?? 200
    return NSSize(width: width, height: 10) // height includes some padding
  }
}

/// NSTextAttachment subclass that stores HorizontalRuleAttachmentCell
class HorizontalRuleAttachment: NSTextAttachment {
  
  init() {
    super.init(data: nil, ofType: nil)
    let cell = HorizontalRuleAttachmentCell()
    self.attachmentCell = cell
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.attachmentCell = HorizontalRuleAttachmentCell()
  }
}

// MARK: - NSPasteboardWriting

extension HorizontalRuleAttachment: NSPasteboardWriting {
  
  func writableTypes(for pasteboard: NSPasteboard) -> [NSPasteboard.PasteboardType] {
    [.string]
  }
  
  func pasteboardPropertyList(forType type: NSPasteboard.PasteboardType) -> Any? {
    if type == .string {
      return "---"
    }
    return nil
  }
}



//class HorizontalRuleAttachment: NSTextAttachment {
//  override func attachmentBounds(
//    for textContainer: NSTextContainer?,
//    proposedLineFragment lineFrag: NSRect,
//    glyphPosition position: CGPoint,
//    characterIndex charIndex: Int
//  ) -> NSRect {
//    let width = lineFrag.width - 20 // some padding
//    return NSRect(x: 0, y: -4, width: width, height: 2)
//  }
//  
//  override func image(
//    forBounds imageBounds: NSRect,
//    textContainer: NSTextContainer?,
//    characterIndex charIndex: Int
//  ) -> NSImage? {
//    let image = NSImage(size: imageBounds.size)
//    image.lockFocus()
//    NSColor.separatorColor.setFill()
//    NSRect(origin: .zero, size: imageBounds.size).fill()
//    image.unlockFocus()
//    return image
//  }
//}
