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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    func setupView() {
        safeArea = layoutMarginsGuide
        setupImageView()
        setupNameLabel()
    }
    
    
    func setupImageView() {
        addSubview(thumbImageView)
        
        thumbImageView.translatesAutoresizingMaskIntoConstraints                            = false
        thumbImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive   = true
        thumbImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive       = true
        thumbImageView.widthAnchor.constraint(equalToConstant: 80).isActive                 = true
        thumbImageView.heightAnchor.constraint(equalToConstant: 80).isActive                = true
        thumbImageView.backgroundColor = .red
    }
    
    func setupNameLabel() {
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints                                              = false
        titleLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 5).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive                         = true
    }
}
