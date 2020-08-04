//
//  NSObject+Rx.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Lottie

final class LoadingView: UIView, LoadableView {
    private let animationView: AnimationView = {
        let view = AnimationView(name: "loading-animation")
        view.contentMode = .scaleAspectFill
        view.loopMode = .loop
        return view
    }()
    private lazy var container: UIView = .container(animationView)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        [container].forEach(addSubview(_:))
        
        container.snp.makeConstraints { $0.center.equalToSuperview() }
        backgroundColor = Colors.windowBackgroundBlack.color.withAlphaComponent(0.75)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public attributes
extension LoadingView {
    func startAnimation() {
        animationView.play()
    }
}
