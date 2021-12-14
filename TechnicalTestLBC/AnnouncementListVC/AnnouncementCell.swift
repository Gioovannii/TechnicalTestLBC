//
//  AnnouncmentCell.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/7.
//

/// Note: Most of my repo in github all public are using storyboard.
/// It was a big challenge to use only code, hope it will satisfy all your expectations

import UIKit

class AnnouncementCell: UITableViewCell {
    var safeArea: UILayoutGuide!
    
    var thumbImageView = UIImageView()
    
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    let categoryLabel = PaddingLabel()
    let categoryNameLabel = PaddingLabel()
    let isUrgentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        safeArea = layoutMarginsGuide
        setupImageView()
        setupNameLabel()
        setupPriceLabel()
        setupCategoryImageLabel()
        setupCategoryNameLabel()
        setupIsUrgentLabel()
    }
    
    // MARK: - Set constraints for each view
    func setupImageView() {
        addSubview(thumbImageView)
        
        thumbImageView.translatesAutoresizingMaskIntoConstraints                          = false
        thumbImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        thumbImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive     = true
        thumbImageView.widthAnchor.constraint(equalToConstant: 80).isActive               = true
        thumbImageView.heightAnchor.constraint(equalToConstant: 80).isActive              = true
        thumbImageView.layer.cornerRadius = 10
        thumbImageView.layer.borderWidth = 1
        thumbImageView.layer.borderColor = UIColor.gray.cgColor
        thumbImageView.clipsToBounds                                                      = true
    }
    
    func setupNameLabel() {
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints                                              = false
        titleLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 5).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive                         = true
        titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 5).isActive      = true
        titleLabel.numberOfLines = 0
    }
    
    func setupPriceLabel() {
        addSubview(priceLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints                            = false
        priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive     = true
    }
    
    func setupIsUrgentLabel() {
        addSubview(isUrgentLabel)
        
        isUrgentLabel.translatesAutoresizingMaskIntoConstraints                                           = false
        isUrgentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive              = true
        isUrgentLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 10).isActive = true
    }

    
    func setupCategoryImageLabel() {
        addSubview(categoryLabel)
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints                                         = false
        categoryLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 5).isActive     = true
        categoryLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 5).isActive = true
        categoryLabel.backgroundColor = .orange
        categoryLabel.paddingTop = 5
        categoryLabel.paddingLeft = 5
        categoryLabel.paddingRight = 5
        categoryLabel.paddingBottom = 5
        categoryLabel.layer.cornerRadius = 5
        categoryLabel.layer.masksToBounds = true
    }
    
    func setupCategoryNameLabel() {
        addSubview(categoryNameLabel)
        
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints                                               = false
        categoryNameLabel.heightAnchor.constraint(equalTo: categoryLabel.heightAnchor).isActive                   = true
        categoryNameLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 5).isActive           = true
        categoryNameLabel.trailingAnchor.constraint(equalTo: categoryLabel.leadingAnchor, constant: -10).isActive = true
    }
}
