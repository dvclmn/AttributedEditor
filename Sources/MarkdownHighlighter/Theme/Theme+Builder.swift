//
//  Theme+Builder.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 29/12/2025.
//

@resultBuilder
public struct ThemeBuilder {
  public static func buildBlock(
    _ components: [SyntaxRoleDef]...
  ) -> [SyntaxRoleDef] {
    components.flatMap(\.self)
  }

  public static func buildArray(
    _ components: [[SyntaxRoleDef]]
  ) -> [SyntaxRoleDef] {
    components.flatMap(\.self)
  }
}

public struct SyntaxRoleDef {
  var syntax: Markdown.Syntax
  var roles: StyleRoles

  init(_ syntax: Markdown.Syntax, roles: StyleRoles) {
    self.syntax = syntax
    self.roles = roles
  }
}

func Syntax(
  _ syntax: [Markdown.Syntax],
  build: (inout StyleRoles) -> Void
) -> [SyntaxRoleDef] {
  var roles = StyleRoles()
  build(&roles)

  var defs: [SyntaxRoleDef] = []

  for syn in syntax {
    defs.append(SyntaxRoleDef(syn, roles: roles))
  }
  return defs
}
func Syntax(
  _ syntax: Markdown.Syntax...,
  build: (inout StyleRoles) -> Void
) -> [SyntaxRoleDef] {
  Syntax(syntax, build: build)
}

//func Headings(build: (inout StyleRoles) -> Void) -> [SyntaxRoleDef] {
//  Syntax(syntax, build: build)
//}
