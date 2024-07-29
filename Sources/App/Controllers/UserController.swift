//
//  File.swift
//  
//
//  Created by RuLi on 2024/7/29.
//

import Foundation
import Fluent
import Vapor

struct UserController:RouteCollection{
    
    static let RoutePrefix = "user"
    
    func boot(routes: any Vapor.RoutesBuilder) throws {
        let group = routes.grouped(.init(stringLiteral: UserController.RoutePrefix))
        group.get(use: self.index)
        group.get("*", use: self.query)
        group.on(.POST, use: self.create)
    }
    
    @Sendable
    func index(req:Request) async throws ->[UserDTO]{
        do{
             try UserValidate.validate(query: req)
        }catch let error{
            throw NSError.init(domain: "\(error)", code: -1)
        }
        do{
            return try await User.query(on: req.db).all().map{$0.toDTO()}
        }catch{
            return []
        }
    }
    
    @Sendable
    func query(req:Request) async throws ->UserDTO{
        guard  let id = req.parameters.get("id",as: UUID.self) else {
            throw NSError.init(domain: "id值不对", code: -1)
        }
        guard let retval = try await User.find(id, on: req.db)?.toDTO() else {
            throw NSError.init(domain: "不存在该用户", code:  -1)
        }
        return retval
    }
    
    
    @Sendable
    func create(req:Request) async throws ->UserDTO{
        let user = try  req.content.decode(UserDTO.self)
        guard try await User.find(user.id, on: req.db) == nil else {
            throw NSError.init(domain: "该用户已存在", code:  -1)
        }
        try await user.toModel().save(on: req.db)
        return user
    }
    
    
}
