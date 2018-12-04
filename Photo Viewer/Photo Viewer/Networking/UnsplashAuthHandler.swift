//
//  UnsplashAuthHandler.swift
//  Photo Viewer
//
//  Created by Tristan Darwent on 2018-12-03.
//  Copyright © 2018 Tristan Darwent. All rights reserved.
//

import Foundation
import Alamofire

class UnsplashAuthHandler {
    private var baseURL: String
    
    public init(baseURL: String) {
        self.baseURL = baseURL
    }
}

extension UnsplashAuthHandler: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        // Adding Unsplash Access Key to each call using UnsplashWebCallsService sessionManager
        urlRequest.setValue("Client-ID " + Configuration.unsplashAccessKey, forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
}
