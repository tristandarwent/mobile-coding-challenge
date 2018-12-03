//
//  UnsplashWebCallsService.swift
//  Photo Viewer
//
//  Created by Tristan Darwent on 2018-12-03.
//  Copyright © 2018 Tristan Darwent. All rights reserved.
//

import Foundation
import Alamofire

class UnsplashWebCallsService {
    
    // MARK: - Variables
    
    private let baseURL: String
    private let sessionManager = SessionManager()
    private let authHandler: UnsplashAuthHandler
    
    private static var sharedUnsplashWebCallsService: UnsplashWebCallsService = {
        let unsplashWebCallsService = UnsplashWebCallsService(baseURL: Configuration.unsplashAPIBaseUrl)
        return unsplashWebCallsService
    }()
    
    // MARK: - Init
    
    private init(baseURL: String) {
        self.baseURL = baseURL
        authHandler = UnsplashAuthHandler(baseURL: baseURL)
        
        sessionManager.adapter = authHandler
    }
    
    class func shared() -> UnsplashWebCallsService {
        return sharedUnsplashWebCallsService
    }
    
    // MARK: - API CALLS
    
    func getPhotos() {
        let url = baseURL + "photos"
        
        sessionManager.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
