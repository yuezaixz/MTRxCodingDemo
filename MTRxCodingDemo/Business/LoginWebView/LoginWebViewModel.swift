//
//  NSObject+Rx.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

final class LoginWebViewModel: ViewModel {
    
    // MARK: - Properties
    
    func dismissRequired() {
        // TODO
        //    steps.accept(WebLoginSteps.dismissed)
    }
    
    func completed(with response: LoginCallbackResponse) {
        //    steps.accept(WebLoginSteps.completed(response: response))
    }
}
