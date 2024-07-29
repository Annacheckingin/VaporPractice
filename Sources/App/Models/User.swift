//
//  File.swift
//  
//
//  Created by RuLi on 2024/7/29.
//

import Foundation
import Fluent

final class User:Model,@unchecked Sendable{
    
    static let schema: String = "user"
    
    static let nameColunmName = "user_name"
    
    static let passwordColumnName = "user_password"
    
    @ID(key: .id)
    var id:UUID?
    
    @Field(key:.init(stringLiteral: User.nameColunmName))
    var name:String?
    

    @Field(key: .init(stringLiteral: User.passwordColumnName))
    var password:String?
    
    
    required init(name:String,password:String,id:UUID? = nil){
        self.id = id
        self.name = name
        self.password = password
    }
    
    init(){}
    
    
    func toDTO()->UserDTO{
      var retval = UserDTO()
       retval.id = self.id
       retval.name = self.name
      return retval
    }
}
