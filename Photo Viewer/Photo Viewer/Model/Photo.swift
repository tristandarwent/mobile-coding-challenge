//
//  Photo.swift
//  Photo Viewer
//
//  Created by Tristan Darwent on 2018-12-03.
//  Copyright © 2018 Tristan Darwent. All rights reserved.
//

import Foundation

class Photo {
    let imageUrl: URL
    var description: String?
    
    init(imageUrl: URL) {
        self.imageUrl = imageUrl
    }
}
