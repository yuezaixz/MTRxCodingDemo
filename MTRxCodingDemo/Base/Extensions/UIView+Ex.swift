//
//  UIView+Ex.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import UIKit
import SnapKit

public extension UIView {
    static func container(_ insertedView: UIView,
                          centerHorizontally: Bool = false,
                          centerVertically: Bool = false,
                          insets: UIEdgeInsets = .init()) -> UIView {
        let view = UIView()
        view.addSubview(insertedView)
        insertedView.snp.makeConstraints {
            if centerVertically {
                $0.centerY.leading.equalTo(view).inset(insets)
            } else if centerHorizontally {
                $0.centerX.top.bottom.equalTo(view).inset(insets)
            } else {
                $0.edges.equalTo(view).inset(insets)
            }
        }
        return view
    }
}
