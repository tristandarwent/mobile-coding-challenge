//
//  PhotoCollectionViewCell.swift
//  Photo Viewer
//
//  Created by Tristan Darwent on 2018-12-03.
//  Copyright © 2018 Tristan Darwent. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Remove any processing or images being displayed after cell is dequeued, helps with images displaying incorrectly
        imageView.af_cancelImageRequest()
        imageView.image = nil
    }
}
