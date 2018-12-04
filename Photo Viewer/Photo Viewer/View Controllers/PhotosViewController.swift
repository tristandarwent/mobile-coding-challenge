//
//  PhotosViewController.swift
//  Photo Viewer
//
//  Created by Tristan Darwent on 2018-12-03.
//  Copyright © 2018 Tristan Darwent. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var photos: [Photo] = []
    let photoCellIdentifier = "photo cell"
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        UnsplashWebCallsService.shared().getPhotos(success: { photos in
            self.photos = photos
            self.collectionView.reloadData()
        }, failure: {
            // TODO: - Add error handling
            print("Call failed")
        })
    }
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        return cell
    }
}

