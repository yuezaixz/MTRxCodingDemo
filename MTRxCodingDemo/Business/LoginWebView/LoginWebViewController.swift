//
//  NSObject+Rx.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import RxSwift
import SnapKit
import UIKit
import WebKit

final class LoginWebViewController: UIViewController, ViewModelBased {
    
    // MARK: - Properties
    var viewModel: LoginWebViewModel!
    let viewSource = LoginWebView()
    let bag = DisposeBag()
    
    // MARK: - Life cycle
    override func loadView() {
        view = viewSource
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: viewSource.closeButton)
        navigationItem.titleView = UIImageView(image: UIImage(named: "logoZeplin"))
        
        // Setting fake user agent is important to enable logging in with Google.
        viewSource.webView.customUserAgent = kUserAgent
        
        if let url = URL(string: kCallbackUrl) {
            viewSource.webView.load(URLRequest(url: url))
        }
        
        observeDatasource()
    }
}

// MARK: - Observe Datasource
private extension LoginWebViewController {
    private func observeDatasource() {
        viewSource.webView.navigationDelegate = self
        
        viewSource.onClose()
            .asDriver()
            .drive(onNext: { _ in self.dismissRequired() })
            .disposed(by: viewSource.bag)
    }
}

// MARK: - WebView Delegate
extension LoginWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let path = webView.url?.absoluteString {
            if path.contains("/v1/zeplin") {
                
                webView
                    .evaluateJavaScript(kDocumentQueryPath, completionHandler: { (html: Any?, error: Error?) in
                        if let error = error {
                            return self.rx.showAlert.onNext(.init(message: "请求出错- \(error.localizedDescription)"))
                        }
                        
                        if let response = html as? String, let _ = LoginCallbackResponse.deserialize(from: response) {
                            self.navToProjects()
//                            self.viewModel.completed(with: callbackResponse)
                        } else {
                            self.rx.showAlert.onNext(.init(message: "Zeplin服务器出错."))
                        }
                    })
            }
        }
    }
}

// MARK: - Route
extension LoginWebViewController {
    func navToProjects() {
        if var vcs = self.navigationController?.viewControllers {
            vcs.removeLast()
            vcs.append(ProjectsViewController())
            self.navigationController?.setViewControllers(vcs, animated: true)
        }
    }
    
    func dismissRequired() {
        self.navigationController?.popViewController(animated: true)
    }
}
