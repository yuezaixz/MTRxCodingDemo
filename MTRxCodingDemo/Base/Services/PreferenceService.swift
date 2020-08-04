//
//  PreferenceService.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol HasPreferenceService {
    var preferenceServices: PreferenceService { get }
}

class PreferenceService {
    let user = BehaviorRelay<User?>(value: nil)
    
    func isLoggedIn() -> Bool {
        return user.value != nil
    }
    
    func logout() {
        Keychain.delete([.token])
        user.accept(nil)
    }
    
    func login(with response: LoginCallbackResponse) {
        if let token = response.token {
            Keychain.save(credentials: [.token(token)])
            user.accept(response.user)
        }
    }
}
