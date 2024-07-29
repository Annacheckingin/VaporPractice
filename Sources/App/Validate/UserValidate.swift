//
//  File.swift
//  
//
//  Created by RuLi on 2024/7/29.
//

import Foundation
import Vapor

struct UserValidate:Validatable{
    
    
    static func validations(_ validations: inout Vapor.Validations) {
        validations.add("id", as: UUID.self,required: false)
    }
    
    
}
