//
//  Fragment+Metadata.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 3/1/2026.
//

extension Fragment {

  // MARK: - Content Kind
  public enum ContentKind: Sendable, CaseIterable {
    case general
    case label
    case code
    case heading
    case single  // E.g. horizontal rule
  }

  // MARK: - Syntax Kind
  public enum SyntaxKind: Sendable, CaseIterable {
    case prefix
    case wrapLeadingPrimary
    case wrapTrailingPrimary
    case wrapLeadingSecondary
    case wrapTrailingSecondary

    public var name: String {
      switch self {
        case .prefix: "Prefix"
        case .wrapLeadingPrimary: "Wrap Leading Primary"
        case .wrapTrailingPrimary: "Wrap Trailing Primary"
        case .wrapLeadingSecondary: "Wrap Leading Secondary"
        case .wrapTrailingSecondary: "Wrap Trailing Secondary"
      }
    }
  }

  // MARK: - Metadata
  public enum Metadata: Sendable, CaseIterable {
    case general
    case url
    case languageHint
    case exclamation

    public var name: String {
      switch self {
        case .general: "General"
        case .url: "URL"
        case .languageHint: "Language Hint"
        case .exclamation: "Exclamation"
      }
    }
  }

}
