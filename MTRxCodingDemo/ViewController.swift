//
//  ViewController.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HasPreferenceService {

    let preferenceServices = PreferenceService()

    override func viewDidLoad() {
        super.viewDidLoad()
        if preferenceServices.isLoggedIn() {
            self.navigationController?.setViewControllers([ProjectsViewController()], animated: true)
        } else {
            let viewController = LoginViewController.instantiate(withViewModel: LoginViewModel())
            self.navigationController?.setViewControllers([viewController], animated: true)
        }
    }

}

