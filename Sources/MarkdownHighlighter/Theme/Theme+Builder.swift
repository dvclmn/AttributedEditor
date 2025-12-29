//
//  Theme+Builder.swift
//  AttributedEditor
//
//  Created by Dave Coleman on 29/12/2025.
//

@resultBuilder
public struct ThemeBuilder {
  public static func buildBlock(_ syntaxRoles: SyntaxRoleDef...) -> [SyntaxRoleDef] {
    syntaxRoles
  }
}

public struct SyntaxRoleDef {
  var syntax: Markdown.Syntax
  var role: StyleRole
}

func Syntax(
  _ syntax: Markdown.Syntax,
  build: (inout StyleRole) -> Void
) -> SyntaxRoleDef {
  var role = StyleRole()
  build(&role)
  return SyntaxRoleDef(
    syntax: syntax,
    role: role
  )
}
