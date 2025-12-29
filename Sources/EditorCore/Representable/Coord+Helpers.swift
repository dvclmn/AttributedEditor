//
//  Coord+Helpers.swift
//  MarkdownEditor
//
//  Created by Dave Coleman on 16/11/2025.
//

//import AppKit
//import Neon

//extension AttributedEditorView.Coordinator {
//  
//  func updateTextView() {
//    guard let textView else { return }
//    let highlighter = self.parent.highlighter
//    
//    let text = textView.string
//    let affectedRange = textView.documentNSRange
//    
//    Task {
//      await self.debouncer.execute { @MainActor in
//        
//        let runs = highlighter.buildStyles(in: text)
//        
//        //        highlighter.applyStyles(
//        //          runs: runs,
//        //          textView: textView,
//        //          affectedRange: affectedRange,
//        //          font: self.parent.font,
//        //          defaults: defaults
//        //        )
//        
//        //        textView.updateHighlighter(with: highlighter)
//        
//        /// Refresh line numbers
//        if self.parent.editorOptions.contains(.lineNumbers) {
//          textView.enclosingScrollView?.verticalRulerView?.needsDisplay = true
//          textView.needsDisplay = true
//        }
//      }
//    }
//  }
//}

//extension AttributedEditorView.Coordinator {
//  @MainActor
//  public func applyStyles(
//    runs: [SyntaxRun],
//    //    textView: NSTextView,
//    affectedRange: NSRange,
//    //    font: NSFont,
//    //    defaults: NSTextAttributes
//  ) {
//
//    guard let textView,
//      let tcs = textView.textContentStorage,
//      let ts = tcs.textStorage
//    else { return }
//    //    guard let textStorage = textView.textStorage else { return }
//    //    let text = textStorage.string
//    let text = textView.string
//    let defaults = self.parent.defaultAttributes
//    let font = self.parent.font
//    //    let resolver = ThemeResolver(theme)
//
//    ts.beginEditing()
//
//    //    var attrWithDebug = defaults
//    //    attrWithDebug.updateValue(
//    //      NSFont.monospacedSystemFont(ofSize: 13, weight: .medium), forKey: .font
//    //      NSColor.blue.withAlphaComponent(0.18), forKey: .backgroundColor
//    //    )
//
//    //    print("Font attributes: ", thing.keys)
//
//    ts.setAttributes(defaults, range: affectedRange)
//
//    /// Apply each highlighted range's attributes
//    for run in runs {
//
//      let range = run.nsRange(in: text)?.intersection(affectedRange)
//      guard let range else { continue }
//
//      //      let resolved = resolver.resolveStyleToken(for: run)
//      var attrs = run.attributes
//
//      let traits = attrs[.fontTraits]
//      let adjustedFont = traits?.constructFont(font: font, sizeScale: 0.94)
//
//      attrs[.font] = adjustedFont
//
//      print("Attributes for \(run.syntax.name, default: "No fragment desc").")
//      //      print("Range preview: \(run.range.withPreview(in: text))")
//      print("\(attrs.description)\n")
//
//      ts.setAttributes(attrs.toNSAttributes, range: range)
//
//    }
//
//    textView.syncTypingAttributes()
//
//    ts.endEditing()
//
//  }
//
//  func logTextKitMode(reason: String, verboseLog: Bool = false) {
//    guard let textView else { return }
//    var debugText = ""
//    if textView.textLayoutManager != nil {
//      /// Do nothing, only want to be alerted if not TK2
//      //      debugText = "🟢 TextKit 2 active (\(reason))"
//      //      if verboseLog {
//      //        debugText += " — textLayoutManager: \(tlm)"
//      //      }
//
//    } else if let lm = textView.layoutManager {
//      debugText = ("🔶 TextKit 1 compatibility mode (\(reason))")
//      if verboseLog {
//        debugText += " — layoutManager: \(lm)"
//      }
//    } else {
//      debugText = ("⚠️ No layout manager detected (\(reason))")
//    }
//    print(debugText)
//  }
//
//}
