//
//  File.swift
//  
//
//  Created by RuLi on 2024/7/29.
//

import Foundation
import Vapor

struct ResponseErrorMiddleware:AsyncMiddleware{
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        do{
            let response = try await next.respond(to: request)
            return response
        }catch let error{
            var retval = Response.init(status: .accepted)
            var body: Response.Body = .init()
            do {
                body = .init(
                    buffer: try JSONEncoder().encodeAsByteBuffer(ResponseTemplete<String>.failure(message: "\(error)"), allocator: request.byteBufferAllocator),
                    byteBufferAllocator: request.byteBufferAllocator
                )
                retval.headers.contentType = .json
            } catch let error{
                body = .init(string: "Oops: \(String(describing: error))\nWhile encoding error: \(error)", byteBufferAllocator: request.byteBufferAllocator)
                retval.headers.contentType = .plainText
            }
            retval.body = body
            return retval
        }
    }
}
