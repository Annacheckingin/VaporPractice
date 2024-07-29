//
//  File.swift
//  
//
//  Created by RuLi on 2024/7/29.
//

import Foundation
import Vapor

struct UserDTO:Content{
    
    var id:UUID?
    
    var name:String?
   
    var password:String?
    
    func toModel()->User{
        let retval = User()
        retval.id = id
        retval.name = name
        retval.password = password
        return retval
    }
    
}
