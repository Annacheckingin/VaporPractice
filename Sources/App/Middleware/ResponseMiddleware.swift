//
//  File.swift
//
//
//  Created by RuLi on 2024/7/29.
//

import Foundation
import Vapor

struct ResponseMiddleware:AsyncMiddleware  {
    
    
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        let response = try await next.respond(to: request)
        print("""
              Middleware is
              
              \(response)
              
              
              """)
        return response
    }
    
    
}
