//
//  Colors.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import UIKit

enum Colors {
    case windowBackgroundBlack
    case mustardYellow
    case loginButtonBlue
    case descriptionGray
    case profileButtonsBackground
    case seperatorGray
    
    var color: UIColor {
        switch self {
        case .windowBackgroundBlack:
            return UIColor(named: "windowBackgroundBlack")!
        case .mustardYellow:
            return UIColor(named: "mustardYellow")!
        case .loginButtonBlue:
            return UIColor(named: "loginButtonBlue")!
        case .descriptionGray:
            return UIColor(named: "descriptionGray")!
        case .profileButtonsBackground:
            return UIColor(named: "profileButtonsBackground")!
        case .seperatorGray:
            return UIColor(named: "seperatorGray")!
        }
    }
}
