//
//  AnnouncmentCell.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/7.
//

import UIKit

class AnnouncmentCell: UITableViewCell {

    var urlImageView = UIImageView()
    var priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(urlImageView)
        addSubview(priceLabel)
        
        configureUrlImageView()
        configureUrlImageView()
        
        setImageConstraints()
        setPriceLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(response: Response) {
//        urlImageView.image = UIImageView().load(url: URL(string: response.imagesURL.small!)!)
        priceLabel.text = "\(response.price)"
    
        
        
    }
    
    func configureUrlImageView() {
        urlImageView.layer.cornerRadius = 10
        urlImageView.clipsToBounds = true
    }
    
    func configurePriceLabel() {
        priceLabel.numberOfLines = 1
        priceLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setImageConstraints() {
        urlImageView.translatesAutoresizingMaskIntoConstraints                                             = false
        urlImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                             = true
        urlImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive               = true
        urlImageView.heightAnchor.constraint(equalToConstant: 80).isActive                                 = true
        urlImageView.widthAnchor.constraint(equalTo: urlImageView.heightAnchor, multiplier: 16/9).isActive = true

    }
    
    func setPriceLabelConstraints() {
        priceLabel.translatesAutoresizingMaskIntoConstraints                                                = false
        priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                = true
        priceLabel.leadingAnchor.constraint(equalTo: urlImageView.trailingAnchor, constant: 20).isActive    = true
        priceLabel.heightAnchor.constraint(equalToConstant: 80).isActive                                    = true
        priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive               = true
    }
}
