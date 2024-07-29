//
//  File.swift
//  
//
//  Created by RuLi on 2024/7/29.
//

import Foundation
import Vapor

struct ResponseTemplete<T:Content>:Content{
    
    let code:Int
    
    let message:String
    
    let data:T?
    
    
    init(code: Int, message: String, data: T?) {
        self.code = code
        self.message = message
        self.data = data
    }
    
    
    static func success(data:T?)->ResponseTemplete<T>{
        let retval = ResponseTemplete<T>.init(code: 0, message: "success", data: data)
        return retval
    }
    
    
    static func failure(message:String)->ResponseTemplete<T>{
        return .init(code: -1, message: message, data: nil)
    }
}
