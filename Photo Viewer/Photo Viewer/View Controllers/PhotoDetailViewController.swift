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
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    // MARK: - Properties
    
    var index: Int?
    var photo: Photo?
    let detailsViewPreviewLengthSeconds: Double = 3
    var manuallyHidDetailsView = false

    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let photo = photo else {
            return
        }
    
        imageView.af_setImage(withURL: photo.imageUrl)
        descriptionLbl.text = photo.description ?? ""
        
        let imageViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(imageViewGestureRecognizer)
        
        let detailsViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(detailsTapped))
        detailsView.addGestureRecognizer(detailsViewGestureRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // details view is displayed on opening of view, and will automatically hide after set seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + detailsViewPreviewLengthSeconds) {
            if !self.manuallyHidDetailsView {
                self.detailsView.isHidden = true
            }
        }
    }
    
    func toggleDetailsView() {
        manuallyHidDetailsView = true
        detailsView.isHidden = !detailsView.isHidden
    }
    
    @objc func imageTapped() {
        toggleDetailsView()
    }
    
    @objc func detailsTapped() {
        toggleDetailsView()
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}
