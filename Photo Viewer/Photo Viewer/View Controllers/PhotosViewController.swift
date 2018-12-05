//
//  PhotosViewController.swift
//  Photo Viewer
//
//  Created by Tristan Darwent on 2018-12-03.
//  Copyright © 2018 Tristan Darwent. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var photos: [Photo] = []
    var pageNumber = 0
    var isLoadingPhotos = false
    var selectedIndex: Int?
    let photoCellIdentifier = "photo cell"
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getPhotos()
    }
    
    func getPhotos() {
        isLoadingPhotos = true
        pageNumber += 1
        
        UnsplashWebCallsService.shared().getPhotos(page: pageNumber, success: { photos in
            self.photos.append(contentsOf: photos)
            self.collectionView.reloadData()
            self.isLoadingPhotos = false
        }, failure: {
            // TODO: - Add error handling
            print("Call failed")
            self.isLoadingPhotos = false
        })
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoDetail" {
            if let vc = segue.destination as? PhotoDetailPageViewController,
                let selectedIndex = selectedIndex {
                vc.photos = photos
                vc.currentIndex = selectedIndex
                self.selectedIndex = nil
            }
        }
    }
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        cell.imageView.af_setImage(withURL: photos[indexPath.row].imageUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "toPhotoDetail", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row >= photos.count - 1 && !isLoadingPhotos {
            getPhotos()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.bounds.size.width / 2
        
        return CGSize(width: width, height: width)
    }
}

