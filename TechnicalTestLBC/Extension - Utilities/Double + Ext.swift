//
//  Double + Ext.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/8.
//

import Foundation

/// remove extra trailling zero
extension Double {
    var stringWithoutZeroFraction: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
