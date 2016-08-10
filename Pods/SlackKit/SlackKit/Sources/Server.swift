//
// Server.swift
//
// Copyright © 2016 Peter Zignego. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import Swifter

internal enum Reply {
    case JSON(response: Response)
    case Text(body: String)
    case BadRequest
}

internal protocol Request {
    var responseURL: String { get }
}

public class Server {
    
    internal let http = HttpServer()
    internal let token: String
    
    internal init(token: String) {
        self.token = token
    }
    
    public func start(port: in_port_t = 8080, forceIPV4: Bool = false) {
        do {
            try http.start(port, forceIPv4: forceIPV4)
        } catch let error as NSError {
            print("Server failed to start with error: \(error)")
        }
    }
    
    public func stop() {
        http.stop()
    }
    
    internal func request(request:Request, reply: Reply) -> HttpResponse {
        switch reply {
        case .Text(let body):
            return .OK(.Text(body))
        case .JSON(let response):
            return .OK(.Json(response.json()))
        case .BadRequest:
            return .BadRequest(.Text("Bad request."))
        }
    }
    
    internal func dictionaryFromRequest(body: [UInt8]) -> [String: AnyObject]? {
        let string = NSString(data: NSData(bytes: body, length: body.count), encoding: NSUTF8StringEncoding)
        if let body = string?.componentsSeparatedByString("&") {
            var dict: [String: AnyObject] = [:]
            for argument in body {
                let kv = argument.componentsSeparatedByString("=")
                if let key = kv.first, value = kv.last {
                    dict[key] = value
                }
            }
            return dict
        }
        return nil
    }
    
    internal func jsonFromRequest(string: String) -> [String: AnyObject]? {
        guard let data = string.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        return (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? [String: AnyObject] ?? nil
    }
    
}
