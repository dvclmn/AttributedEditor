//
//  RegexShape+Range.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 3/1/2026.
//

import AppKit

extension RegexShape {

  /// Explode a regex match into semantic fragments and their ranges.
  /// This is the *only* place where we cast to concrete regex output types.
  public func fragmentRanges(
    from match: Regex<AnyRegexOutput>.Match
  ) throws -> [Fragment: Range<String.Index>] {

    switch self {

      // MARK: - Single
      case .single:
        guard let values = match.output.extractValues(as: Single.self) else {
          throw RegexError.failedValueExtraction(for: self)
        }
        return [.content(.single): values.indexRange]

      // MARK: - Wrap

      case .wrap:
        guard let values = match.output.extractValues(as: Wrap.self) else {
          throw RegexError.failedValueExtraction(for: self)
        }
        return [
          .leading: values.leading.indexRange,
          .content: values.content.indexRange,
          .trailing: values.trailing.indexRange,
        ]

      // MARK: - Prefix
      case .prefix:
        guard let values = match.output.extractValues(as: Prefix.self) else {
          throw RegexError.failedValueExtraction(for: self)
        }
        return [
          .prefix: values.prefix.indexRange,
          .content: values.content.indexRange,
        ]

      // MARK: - Code Block
      case .codeBlock:
        guard let values = match.output.extractValues(as: CodeBlock.self) else {
          throw RegexError.failedValueExtraction(for: self)
        }

        var fragments: [Fragment: Range<String.Index>] = [
          .leading: values.leading.indexRange,
          .content(.code): values.code.indexRange,
          .trailing: values.trailing.indexRange,
        ]

        guard let langHint = values.languageHint, !langHint.isEmpty else { return fragments }
        fragments[.metadata(.languageHint)] = langHint.indexRange

        return fragments

      // MARK: - Image/Link
      case .linkOrImage:
        guard let values = match.output.extractValues(as: LinkOrImage.self) else {
          throw RegexError.failedValueExtraction(for: self)
        }
        var fragments: [Fragment: Range<String.Index>] = [
          .leading:
            values.leading.indexRange,

          .content(.label):
            values.label.indexRange,

          .trailing:
            values.trailing.indexRange,

          .syntax(.syntaxLeadingSecondary):
            values.leadingSecondary.indexRange,

          .metadata(.url):
            values.url.indexRange,

          .syntax(.syntaxTrailingSecondary):
            values.trailingSecondary.indexRange,
        ]

        guard let exclam = values.exclamation, !exclam.isEmpty else { return fragments }
        fragments[.metadata(.exclamation)] = exclam.indexRange

//        fragments[.metadata(.exclamation)] = values.exclamation?.indexRange

        return fragments

      // MARK: - Callout
      case .callout:
        guard let values = match.output.extractValues(as: Callout.self) else {
          throw RegexError.failedValueExtraction(for: self)
        }

        return [
          .prefix:
            values.prefix.indexRange,

          .leading:
            values.leading.indexRange,

          .metadata(.exclamation):
            values.exclamation.indexRange,

          .content(.label):
            values.label.indexRange,

          .trailing:
            values.trailing.indexRange,

          .content(.heading):
            values.title.indexRange,

          .content:
            values.content.indexRange,
        ]
    }
  }
}

//extension Regex where Output == AnyRegexOutput {
//  public subscript<T>(
//    as type: T.Type,
//    _ paths: (KeyPath<T, Substring>) -> Void
////    keypath: KeyPath<T, Substring>
//  ) -> Range<String.Index> {
//
//  }
//}

//extension RegexShape {
//
//  /// Return a range for a given Regex Match and shape part
//  /// `text` is the original main text being searched for matches
//  ///
//  /// This throws to indicate failure to cast values to concrete Regex shape,
//  /// and is optional to represent e.g. image/link, which has an optional
//  /// `exclamation` character, depending which it is.
//  public func range(
//    for match: Regex<AnyRegexOutput>.Match,
//    fragment: Fragment,
//  ) throws -> Range<String.Index>? {
//    switch self {
//      // MARK: - Warp
//      case .wrap:
//        guard let values = match.output.extractValues(as: Wrap.self) else {
//          throw RegexError.failedValueExtraction(self, fragment)
//        }
//
//        return switch fragment {
//          case .syntax(.syntaxLeadingPrimary):
//            values.syntaxLeadingPrimary.indexRange
//
//          case .content(.general):
//            values.content.indexRange
//
//          case .syntax(.syntaxTrailingPrimary):
//            values.syntaxTrailingPrimary.indexRange
//
//          default: fatalError("Fragment \(fragment) not supported for RegexShape \(self.name)")
//        }
//      // MARK: - Prefix
//      case .prefix:
//        guard let values = match.output.extractValues(as: Prefix.self) else {
//          throw RegexError.failedValueExtraction(self, fragment)
//        }
//        return switch fragment {
//          case .syntax(.prefix):
//            values.prefix.indexRange
//
//          case .content(.general):
//            values.content.indexRange
//
//          default: fatalError("Fragment \(fragment) not supported for RegexShape \(self.name)")
//        }
//
//      // MARK: - Single
//      case .single:
//        guard let values = match.output.extractValues(as: Single.self) else {
//          throw RegexError.failedValueExtraction(self, fragment)
//        }
//        return switch fragment {
//          case .content(.single): values.indexRange
//          default: fatalError("Fragment \(fragment) not supported for RegexShape \(self.name)")
//        }
//
//      // MARK: - Code Block
//      case .codeBlock:
//        guard let values = match.output.extractValues(as: CodeBlock.self) else {
//          throw RegexError.failedValueExtraction(self, fragment)
//        }
//        return switch fragment {
//          case .syntax(.syntaxLeadingPrimary):
//            values.syntaxLeadingPrimary.indexRange
//
//          case .metadata(.languageHint):
//            values.langHint.indexRange
//
//          case .content(.code):
//            values.code.indexRange
//
//          case .syntax(.syntaxTrailingPrimary):
//            values.syntaxTrailingPrimary.indexRange
//
//          default: fatalError("Fragment \(fragment) not supported for RegexShape \(self.name)")
//        }
//
//      // MARK: - Link
//      case .linkOrImage:
//        guard let values = match.output.extractValues(as: LinkOrImage.self) else {
//          throw RegexError.failedValueExtraction(self, fragment)
//        }
//        return switch fragment {
//          case .metadata(.exclamation):
//            values.exclamation?.indexRange  // Present only for Image, not Link
//
//          case .syntax(.syntaxLeadingPrimary):
//            values.syntaxLeadingPrimary.indexRange
//
//          case .content(.label):
//            values.label.indexRange
//
//          case .syntax(.syntaxTrailingPrimary):
//            values.syntaxTrailingPrimary.indexRange
//
//          case .syntax(.syntaxLeadingSecondary):
//            values.syntaxLeadingSecondary.indexRange
//
//          case .metadata(.url):
//            values.url.indexRange
//
//          case .syntax(.syntaxTrailingSecondary):
//            values.syntaxTrailingSecondary.indexRange
//
//          default: fatalError("Fragment \(fragment) not supported for RegexShape \(self.name)")
//
//        }
//
//      // MARK: - Callout
//      case .callout:
//        guard let values = match.output.extractValues(as: Callout.self) else {
//          throw RegexError.failedValueExtraction(self, fragment)
//        }
//        return switch fragment {
//          case .syntax(.prefix):
//            values.prefix.indexRange  // Present only for Image, not Link
//
//          case .syntax(.syntaxLeadingPrimary):
//            values.syntaxLeadingPrimary.indexRange
//
//          case .metadata(.exclamation):
//            values.exclamation.indexRange
//
//          case .content(.label):
//            values.label.indexRange
//
//          case .syntax(.syntaxTrailingPrimary):
//            values.syntaxTrailingPrimary.indexRange
//
//          case .content(.heading):
//            values.title.indexRange
//
//          case .content(.general):
//            values.content.indexRange
//
//          default: fatalError("Fragment \(fragment) not supported for RegexShape \(self.name)")
//
//        }
//    }
//  }
//
//  /// Return a range for a given Regex Match and shape part
//  /// `text` is the original main text being searched for matches
//  public func nsRange(
//    for match: Regex<AnyRegexOutput>.Match,
//    fragment: Fragment,
//    in text: String,
//  ) -> NSRange? {
//    let stringRange = try? self.range(for: match, fragment: fragment)
//    return stringRange?.toNSRange(in: text)
//  }
//}
