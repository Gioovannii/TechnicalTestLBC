//
//  AnnouncmentCell.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/7.
//

import UIKit

class AnnouncmentCell: UITableViewCell {
    var safeArea: UILayoutGuide!
    
    var thumbImageView = UIImageView()
    
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    let categoryLabel = UILabel()
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
        setupCategoryLabel()
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
        thumbImageView.clipsToBounds = true
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
    
    func setupCategoryLabel() {
        addSubview(categoryLabel)
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints                                         = false
        categoryLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive                  = true
        categoryLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 5).isActive = true
        categoryLabel.backgroundColor = .orange
        categoryLabel.layer.cornerRadius = 5
        categoryLabel.layer.masksToBounds                                                               = true
    }
    
    func setupIsUrgentLabel() {
        addSubview(isUrgentLabel)
        
        isUrgentLabel.translatesAutoresizingMaskIntoConstraints                                           = false
        isUrgentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive              = true
        isUrgentLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 10).isActive = true
    }
}
