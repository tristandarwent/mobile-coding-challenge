//
//  PhotoDetailPageViewController.swift
//  Photo Viewer
//
//  Created by Tristan Darwent on 2018-12-04.
//  Copyright © 2018 Tristan Darwent. All rights reserved.
//

/***
**** Technique to display full page image slideshow borrowed and modified from:
**** https://www.raywenderlich.com/560-uiscrollview-tutorial-getting-started
***/

import UIKit

class PhotoDetailPageViewController: UIPageViewController {
    
    // MARK: - Properties
    
    var photos: [Photo]?
    var currentIndex: Int?
    
    let photoDetailVCIndentifier = "PhotoDetailViewController"
    
    // MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard currentIndex != nil, photos != nil else {
            return
        }
        
        setupPageViewController()
    }
    
    func setupPageViewController() {
        dataSource = self
        
        // load first tapped image into PhotoDetailViewController and display in Page View Controller
        if let vc = viewPhotoDetailViewController(currentIndex!) {
            let viewControllers = [vc]
            setViewControllers(viewControllers,
                               direction: .forward,
                               animated: false,
                               completion: nil
            )
        }
    }
    
    // returns PhotoDetailViewController loaded with photo at index in photos array
    func viewPhotoDetailViewController(_ index: Int) -> PhotoDetailViewController? {
        guard let storyboard = storyboard,
            let page = storyboard.instantiateViewController(withIdentifier: photoDetailVCIndentifier) as? PhotoDetailViewController else {
            return nil
        }
        
        page.index = index
        page.photo = photos![index]
        
        return page
    }
}

extension PhotoDetailPageViewController: UIPageViewControllerDataSource {
    
    // loads PhotoDetailViewController before the currently displayed photo
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? PhotoDetailViewController,
            let index = viewController.index,
            index > 0 {
            return viewPhotoDetailViewController(index - 1)
        }
        
        return nil
    }
    
    // loads PhotoDetailViewController after the currently displayed photo
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? PhotoDetailViewController,
            let index = viewController.index,
            (index + 1) < photos!.count {
            return viewPhotoDetailViewController(index + 1)
        }
        
        return nil
    }
}
