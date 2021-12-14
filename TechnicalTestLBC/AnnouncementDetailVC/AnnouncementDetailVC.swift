//
//  AnnouncementDetailVC.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/9.
//

import UIKit

final class AnnouncementDetailVC: UIViewController {
    var announcement: Response?
    var safeArea: UILayoutGuide!
    
    var imageThumb = UIImageView()
    var titleLabel = UILabel()
    var priceLabel = UILabel()
    var dateLabel = UILabel()
    var descriptionTextView = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        setupImage()
        setupTitle()
        setupPriceLabel()
        setupDateLabel()
        setupDescription()
    }

    /// Prepare  data with announcement from AnnouncementListVC
    func prepareView() {
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        guard let announcement = announcement else { return }
        guard let image = announcement.imagesURL.thumb else { return }
        let strDate = DateFormatter.getDateFromString(date: announcement.creationDate)
        let dateStr = DateFormatter.getDateToString(from: strDate)
        self.imageThumb.downloaded(from: image)
        self.titleLabel.text = announcement.title
        self.priceLabel.text = "\(announcement.price.stringWithoutZeroFraction) €"
        self.dateLabel.text = dateStr
        self.descriptionTextView.text = announcement.annoncementDescription
    }
    
    // MARK: - Set Constraint for each View

    func setupImage() {
        view.addSubview(imageThumb)
        
        imageThumb.translatesAutoresizingMaskIntoConstraints                        = false
        imageThumb.contentMode = .scaleAspectFill
        imageThumb.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive   = true
        imageThumb.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageThumb.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive   = true
    }
    
    func setupTitle() {
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints                                     = false
        titleLabel.topAnchor.constraint(equalTo: imageThumb.bottomAnchor, constant: 35).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive            = true
        titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive          = true
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "helvetica", size: 22)
    }
    
    func setupPriceLabel() {
        view.addSubview(priceLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints                                    = false
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive           = true
    }
    
    func setupDateLabel() {
        view.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints                                    = false
        dateLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive           = true
    }
    
    
    func setupDescription() {
        view.addSubview(descriptionTextView)
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints                                    = false
        descriptionTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive           = true
        descriptionTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive         = true
        descriptionTextView.numberOfLines = 0
    }
}
