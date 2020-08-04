//
//  NSObject+Rx.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import SnapKit
import UIKit
import RxSwift
import RxCocoa

final class LoginView: UIView {
    // MARK: - Properties
    var bag = DisposeBag()
    
    private let logoImageView = UIImageView(image: UIImage(named: "logoZeplinClient"))
    private lazy var logoContainer: UIView = .container(logoImageView, centerHorizontally: true)
    
    private let loginButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("LOGIN", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont.semiBold(16)
        view.cornerRadius = 24
        view.backgroundColor = Colors.loginButtonBlue.color
        view.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        return view
    }()
    
    private lazy var verticalStack: UIStackView = .create(arrangedSubViews: [logoContainer, loginButton], axis: .vertical, alignment: .fill, distribution: .fill, spacing: 96)
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        
        [verticalStack].forEach(addSubview(_:))
        
        verticalStack.snp.makeConstraints { $0.center.equalToSuperview() }
        loginButton.snp.makeConstraints {
            $0.leading.trailing
                .equalTo(self)
                .inset(UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView {
    func onLogin() -> ControlEvent<Void> {
        return loginButton.rx.tap
    }
}
