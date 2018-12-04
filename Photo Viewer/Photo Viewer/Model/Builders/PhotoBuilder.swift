//
//  PhotoBuilder.swift
//  Photo Viewer
//
//  Created by Tristan Darwent on 2018-12-03.
//  Copyright © 2018 Tristan Darwent. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PhotoBuilder {
    static let kKeyUrls = "urls"
    static let kKeyRegularUrl = "regular"
    
    static func buildPhotoArray(_ json: JSON) -> [Photo] {
        var photoArray: [Photo] = []
        
        if let photoJsonArray = json.array {
            for photoJson in photoJsonArray {
                if let photo = buildPhoto(photoJson) {
                    photoArray.append(photo)
                }
            }
        }
        
        return photoArray
    }
    
    static func buildPhoto(_ json: JSON) -> Photo? {
        if let urlString = json[kKeyUrls][kKeyRegularUrl].string,
            let url = URL(string: urlString) {
            
            let photo = Photo(imageUrl: url)
            return photo
        }
        
        return nil
    }
}
