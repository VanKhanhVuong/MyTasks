//
//  UITextField+Extension.swift
//  MyTasks
//
//  Created by Richard Van on 10/12/2023.
//

import UIKit

extension UITextField {
    func configureTextField(text: String, font: UIFont, textColor: UIColor, placeholderColor: UIColor) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: placeholderColor
        ]
        let attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
        self.attributedPlaceholder = attributedPlaceholder
        self.font = font
        self.textColor = textColor
    }
}

