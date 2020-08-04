//
//  NSObject+Rx.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import SnapKit
import UIKit
import WebKit
import RxCocoa
import RxSwift

final class LoginWebView: UIView {
    // MARK: - Properties
    let bag = DisposeBag()
    
    let closeButton: UIButton = .create(title: "Close",
                                        titleColor: Colors.mustardYellow.color,
                                        font: .regular(17))
    
    private let webViewConfig: WKWebViewConfiguration = {
        let config = WKWebViewConfiguration()
        config.applicationNameForUserAgent = "Version/8.0.2 Safari/600.2.5"
        return config
    }()
    
    private(set) lazy var webView: WKWebView = WKWebView(frame: .zero, configuration: webViewConfig)
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        
        [webView].forEach(addSubview(_:))
        
        webView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginWebView {
    func onClose() -> ControlEvent<Void> {
        return closeButton.rx.tap
    }
}
