//
//  Highlighter+Helpers.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit
import CoreTools
//import EditorCore
import MarkdownHighlighter
//import TextView

//extension AttributedEditorView.Coordinator {
extension MarkdownHighlighter {
  
//  var resolver: ThemeResolver { ThemeResolver(theme) }

  @MainActor
  public func applyStyles(
    runs: [SyntaxRun],
    textView: NSTextView,
    affectedRange: NSRange,
    font: NSFont,
    defaults: NSTextAttributes
  ) {

    guard let tcs = textView.textContentStorage else { return }
    guard let ts = tcs.textStorage else { return }
    //    guard let textStorage = textView.textStorage else { return }
    //    let text = textStorage.string
    let text = textView.string
//    let resolver = ThemeResolver(theme)

    ts.beginEditing()

    //    var attrWithDebug = defaults
    //    attrWithDebug.updateValue(
    //      NSFont.monospacedSystemFont(ofSize: 13, weight: .medium), forKey: .font
    //      NSColor.blue.withAlphaComponent(0.18), forKey: .backgroundColor
    //    )

    //    print("Font attributes: ", thing.keys)

    ts.setAttributes(defaults, range: affectedRange)

    /// Apply each highlighted range's attributes
    for run in runs {

      let range = run.nsRange(in: text)?.intersection(affectedRange)
      guard let range else { continue }

//      let resolved = resolver.resolveStyleToken(for: run)
      var attrs = run.attributes
      
      let traits = attrs[.fontTraits]
      let adjustedFont = traits?.constructFont(font: font, sizeScale: 0.94)

      attrs[.font] = adjustedFont

      print("Attributes for \(run.syntax.name, default: "No fragment desc").")
      //      print("Range preview: \(run.range.withPreview(in: text))")
      print("\(attrs.description)\n")

      ts.setAttributes(attrs.toNSAttributes, range: range)

    }

    textView.syncTypingAttributes()

    ts.endEditing()

  }

}
