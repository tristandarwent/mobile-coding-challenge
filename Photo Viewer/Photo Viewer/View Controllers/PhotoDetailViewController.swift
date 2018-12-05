//
//  PhotoDetailViewController.swift
//  Photo Viewer
//
//  Created by Tristan Darwent on 2018-12-04.
//  Copyright © 2018 Tristan Darwent. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    
    var index: Int?
    var photo: Photo?

    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let photo = photo else {
            return
        }
    
        imageView.af_setImage(withURL: photo.imageUrl)
    }
}
