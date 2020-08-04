//
//  NSObject+Rx.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController, ViewModelBased, LoadableController {
    //MARK: - Properties
    var LoadingViewType: LoadableView.Type = LoadingView.self
    
    var viewModel: LoginViewModel!
    let viewSource = LoginView()
    let bag = DisposeBag()
    
    // MARK: - Life cycle
    override func loadView() {
        view = viewSource
        view.backgroundColor = Colors.windowBackgroundBlack.color
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeDatasource()
    }
}

// MARK: - Observe Datasource
extension LoginViewController {
    private func observeDatasource() {
        viewSource.onLogin()
            .asDriver()
            .do(onNext: { [weak self] _ in
                let viewController = LoginWebViewController.instantiate(withViewModel: LoginWebViewModel())
                self?.navigationController?.pushViewController(viewController, animated: true)
                //                viewController.modalPresentationStyle = .overFullScreen
                //                self?.present(viewController, animated: true, completion: nil)
            })
            .drive()
            .disposed(by: viewSource.bag)
    }
}
