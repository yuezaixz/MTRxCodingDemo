//
//  User.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import UIKit
import Kingfisher
import HandyJSON

class User: HandyJSON {
    var identifier: String!
    var email: String!
    var username: String!
    var emotar: String?
    var avatar: String?
    
    required init() {}
}

// MARK: - Helper functions
extension User {
    func getPrefix(maxLength: Int = 2, isUppercased: Bool = true) -> String {
        if isUppercased {
            return username.prefix(maxLength).uppercased()
        }
        return String(username.prefix(maxLength))
    }
    
    func getProfileImage(size: Int, emotarSize: CGFloat = 11, initialSize: CGFloat = 8) -> UIView {
        if let url = URL(string: avatar ?? "") {
            let imageView = UIImageView()
            imageView.backgroundColor = Colors.profileButtonsBackground.color
            imageView.kf.setImage(with: url)
            imageView.kf.indicatorType = .activity
            imageView.contentMode = .scaleAspectFill
            imageView.snp.makeConstraints { $0.size.equalTo(size) }
            imageView.cornerRadius = floor(CGFloat(size) / 2)
            return imageView
        } else if let emotar = emotar {
            let label = UILabel()
            label.text = emotar
            label.backgroundColor = Colors.profileButtonsBackground.color
            label.snp.makeConstraints { $0.size.equalTo(size) }
            label.textAlignment = .center
            label.sizeToFit()
            label.cornerRadius = floor(CGFloat(size) / 2)
            label.font = .medium(emotarSize)
            return label
        } else {
            let label = UILabel()
            label.text = getPrefix()
            label.backgroundColor = Colors.profileButtonsBackground.color
            label.font = .semiBold(initialSize)
            label.textAlignment = .center
            label.cornerRadius = floor(CGFloat(size) / 2)
            label.snp.makeConstraints { $0.size.equalTo(size) }
            label.sizeToFit()
            return label
        }
    }
}
