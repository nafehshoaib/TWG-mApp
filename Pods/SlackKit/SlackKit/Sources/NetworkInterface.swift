//
// NetworkInterface.swift
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

internal struct NetworkInterface {
    
    private let apiUrl = "https://slack.com/api/"
    
    internal func request(endpoint: Endpoint, token: String? = nil, parameters: [String: AnyObject]?, successClosure: ([String: AnyObject])->Void, errorClosure: (SlackError)->Void) {
        var requestString = "\(apiUrl)\(endpoint.rawValue)?"
        if let token = token {
            requestString += "token=\(token)"
        }
        if let params = parameters {
            requestString += params.requestStringFromParameters
        }
        guard let url =  NSURL(string: requestString) else {
            errorClosure(SlackError.ClientNetworkError)
            return
        }
        let request = NSURLRequest(URL:url)
        NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, internalError) -> Void in
            self.handleResponse(data, response: response, internalError: internalError, successClosure: {(json) in
                successClosure(json)
            }, errorClosure: {(error) in
                errorClosure(error)
            })
        }.resume()
    }
    
    internal func customRequest(url: String, data: NSData, success: (Bool)->Void, errorClosure: (SlackError)->Void) {
        guard let requestString = url.stringByRemovingPercentEncoding, url =  NSURL(string: requestString) else {
            errorClosure(SlackError.ClientNetworkError)
            return
        }
        let request = NSMutableURLRequest(URL:url)
        request.HTTPMethod = "POST"
        let contentType = "application/json"
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.HTTPBody = data
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, internalError) -> Void in
            if internalError == nil {
                success(true)
            } else {
                errorClosure(SlackError.ClientNetworkError)
            }
            }.resume()
    }
    
    internal func uploadRequest(token: String, data: NSData, parameters: [String: AnyObject]?, successClosure: ([String: AnyObject])->Void, errorClosure: (SlackError)->Void) {
        var requestString = "\(apiUrl)\(Endpoint.FilesUpload.rawValue)?token=\(token)"
        if let params = parameters {
            requestString = requestString + params.requestStringFromParameters
        }
        guard let url =  NSURL(string: requestString) else {
            errorClosure(SlackError.ClientNetworkError)
            return
        }
        let request = NSMutableURLRequest(URL:url)
        request.HTTPMethod = "POST"
        let boundaryConstant = randomBoundary()
        let contentType = "multipart/form-data; boundary=" + boundaryConstant
        let boundaryStart = "--\(boundaryConstant)\r\n"
        let boundaryEnd = "--\(boundaryConstant)--\r\n"
        let contentDispositionString = "Content-Disposition: form-data; name=\"file\"; filename=\"\(parameters!["filename"])\"\r\n"
        let contentTypeString = "Content-Type: \(parameters!["filetype"])\r\n\r\n"

        let requestBodyData : NSMutableData = NSMutableData()
        requestBodyData.appendData(boundaryStart.dataUsingEncoding(NSUTF8StringEncoding)!)
        requestBodyData.appendData(contentDispositionString.dataUsingEncoding(NSUTF8StringEncoding)!)
        requestBodyData.appendData(contentTypeString.dataUsingEncoding(NSUTF8StringEncoding)!)
        requestBodyData.appendData(data)
        requestBodyData.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        requestBodyData.appendData(boundaryEnd.dataUsingEncoding(NSUTF8StringEncoding)!)
        
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.HTTPBody = requestBodyData

        NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, internalError) -> Void in
            self.handleResponse(data, response: response, internalError: internalError, successClosure: {(json) in
                successClosure(json)
            }, errorClosure: {(error) in
                errorClosure(error)
            })
        }.resume()
    }
    
    private func handleResponse(data: NSData?, response:NSURLResponse?, internalError:NSError?, successClosure: ([String: AnyObject])->Void, errorClosure: (SlackError)->Void) {
        guard let data = data, response = response as? NSHTTPURLResponse else {
            errorClosure(SlackError.ClientNetworkError)
            return
        }
        do {
            guard let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: AnyObject] else {
                errorClosure(SlackError.ClientJSONError)
                return
            }
            
            switch response.statusCode {
            case 200:
                if (json["ok"] as! Bool == true) {
                    successClosure(json)
                } else {
                    if let errorString = json["error"] as? String {
                        throw SlackError(rawValue: errorString) ?? .UnknownError
                    } else {
                        throw SlackError.UnknownError
                    }
                }
            case 429:
                throw SlackError.TooManyRequests
            default:
                throw SlackError.ClientNetworkError
            }
        } catch let error {
            if let slackError = error as? SlackError {
                errorClosure(slackError)
            } else {
                errorClosure(SlackError.UnknownError)
            }
        }
    }
    
    private func randomBoundary() -> String {
        return String(format: "slackkit.boundary.%08x%08x", arc4random(), arc4random())
    }
    
}
