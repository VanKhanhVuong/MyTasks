//
//  String+Extension.swift
//  MyTasks
//
//  Created by Richard Van on 16/12/2023.
//

import UIKit

extension String {
    
    func getColorWith() -> UIColor {
        let colorName = "system" + self
        return UIColor(named: colorName) ?? UIColor.orange
    }
}
