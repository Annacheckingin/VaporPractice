//
//  File.swift
//  
//
//  Created by RuLi on 2024/7/29.
//

import Foundation
import Fluent

struct CreatUser:AsyncMigration {
    
    
    func prepare(on database: any FluentKit.Database) async throws {
         try await database.schema(User.schema)
             .id()
             .field(.init(stringLiteral: User.nameColunmName), .string, .required)
             .field(.init(stringLiteral: User.passwordColumnName), .string, .required)
             .create()
    }
    
    
    func revert(on database: any Database) async throws {
          try await database.schema(User.schema).delete()
    }
    
}
