//
//  UIView + Ext.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/7.
//

import UIKit

extension UIView {
    func pin(to superview: UIView) {
        translatesAutoresizingMaskIntoConstraints                               = false
        topAnchor.constraint(equalTo: superview.topAnchor).isActive             = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive     = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive   = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive       = true

    }
}
