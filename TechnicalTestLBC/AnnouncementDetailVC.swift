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
        imageThumb.contentMode = .scaleAspectFit
        imageThumb.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                  = true
        imageThumb.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50).isActive        = true
        imageThumb.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5).isActive = true
        imageThumb.heightAnchor.constraint(equalTo: imageThumb.widthAnchor).isActive               = true
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
