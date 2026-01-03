//
//  SyntaxData.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 24/12/2025.
//

import CoreTools
import Foundation

extension MarkdownHighlighter {

//  func processFragment(
//    _ fragment: Fragment,
//    in range: Range<String.Index>,
//    //    _ match: Regex<AnyRegexOutput>.Match,
//    for syntax: Markdown.Syntax,
//    //    in text: String,
//    
//  ) throws -> SyntaxRun {
//
//    //    let shape = syntax.regexShape
//    //    let fragments = syntax.fragments
//    print("⏳ Processing fragment '\(fragment.name)', for syntax: \(syntax.name)\n")
//
//    /// Currently using the range as the sole marker for equality here
//    let runAlreadyExists = runs.contains(where: { $0.range == range })
//    guard !runAlreadyExists else { return }
//
//    /// If a run with this range is not already present, add a new one
//    let run = SyntaxRun(
//      syntax: syntax,
//      fragment: fragment,
//      range: range
//    )
//    
////    runs.append(run)
//    
//    return run

    //    print("⏳ Processing match for \(syntax.name), with fragments: \(fragments)\n")

    //    for fragment in fragments {
    //
    //      let range = try shape.range(for: match, fragment: fragment)
    //
    //      guard let range else {
    //        //        if fragment == .metadata(.exclamation)
    //        //        print("If there is no range for this fragment '\(fragment.name)', it's likely/possible that this is a link/image fragment, which has optional `exclamation`.")
    //      }
    //
    //      /// Currently using the range as the sole marker for equality here
    //      let runAlreadyExists = runs.contains(where: { $0.range == range })
    //      guard !runAlreadyExists else { continue }
    //
    //      /// If a run with this range is not already present, add a new one
    //      let run = SyntaxRun(
    //        syntax: syntax,
    //        fragment: fragment,
    //        range: range
    //      )
    //      print("🏃 Created new run:\n\(run.debugPreview(in: text))")
    //      runs.append(run)
    //    }
//  }

  //  func processMatch(
  //    _ match: Regex<AnyRegexOutput>.Match,
  //    for syntax: Markdown.Syntax,
  //    in text: String,
  //    runs: inout MarkdownRuns,
  //  ) throws {
  //
  //    let shape = syntax.regexShape
  //    let fragments = syntax.fragments
  //    print("⏳ Processing match for \(syntax.name), with fragments: \(fragments)\n")
  //
  //    for fragment in fragments {
  //
  //      let range = try shape.range(for: match, fragment: fragment)
  //
  //      guard let range else {
  ////        if fragment == .metadata(.exclamation)
  ////        print("If there is no range for this fragment '\(fragment.name)', it's likely/possible that this is a link/image fragment, which has optional `exclamation`.")
  //      }
  //
  //      /// Currently using the range as the sole marker for equality here
  //      let runAlreadyExists = runs.contains(where: { $0.range == range })
  //      guard !runAlreadyExists else { continue }
  //
  //      /// If a run with this range is not already present, add a new one
  //      let run = SyntaxRun(
  //        syntax: syntax,
  //        fragment: fragment,
  //        range: range
  //      )
  //      print("🏃 Created new run:\n\(run.debugPreview(in: text))")
  //      runs.append(run)
  //    }
  //  }

//  private func imageOrLink() {
//
//  }

}
