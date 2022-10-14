//
//  UIView+Extensions.swift
//  Notes
//
//  Created by Daniel Akinniranye on 10/14/22.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set { self.layer.cornerRadius = newValue }
        get { return self.cornerRadius }
    }
}
