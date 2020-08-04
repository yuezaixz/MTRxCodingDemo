//
//  UIStackView+Ex.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import UIKit

extension UIStackView {
    static public func create(arrangedSubViews: [UIView] = [],
                              axis: NSLayoutConstraint.Axis = .vertical,
                              alignment: UIStackView.Alignment = .fill,
                              distribution: UIStackView.Distribution = .fill,
                              spacing: CGFloat = .leastNormalMagnitude) -> UIStackView {
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = spacing
        return stackView
    }
}
