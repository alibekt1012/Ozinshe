//
//  TextFieldWithPadding.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 04.08.2023.
//

import UIKit

class TextFieldWithPadding: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 44)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
