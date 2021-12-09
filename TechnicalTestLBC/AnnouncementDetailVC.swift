//
//  AnnouncementDetailVC.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/9.
//

import UIKit

class AnnouncementDetailVC: UIViewController {
    var announcement: Response?
        
    var safeArea: UILayoutGuide!
    var imageThumb = UIImageView()
    var titleLabel = UILabel()
    var descriptionLabel = UITextView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        setupImage()
    }
    
    func prepareView() {
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        guard let announcement = announcement else { return }
        guard let image = announcement.imagesURL.thumb else { return }
        imageThumb.downloaded(from: image)
    }
    
    func setupImage() {
        view.addSubview(imageThumb)
        
        imageThumb.translatesAutoresizingMaskIntoConstraints                                       = false
        imageThumb.contentMode = .scaleAspectFill
        imageThumb.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageThumb.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func setupTitle() {
        view.addSubview(titleLabel)
        imageThumb.translatesAutoresizingMaskIntoConstraints                                       = false
        
    }
    
    func setupDescription() {
        view.addSubview(descriptionLabel)
        imageThumb.translatesAutoresizingMaskIntoConstraints                                       = false

        
        
    }
}
