//
//  LoginCallbackResponse.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import UIKit
import HandyJSON

class LoginCallbackResponse: HandyJSON {
    var user: User?
    var token: String?
    
    required init() {}
}
