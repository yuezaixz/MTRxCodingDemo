//
//  UIViewController+Ex.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit
import SwiftEntryKit
import SnapKit

public protocol LoadableView where Self: UIView {
    func startAnimation()
    init()
}

public protocol LoadableController {
    var LoadingViewType: LoadableView.Type { get }
}

public extension Reactive where Base: UIViewController, Base: LoadableController {
    var showLoading: Binder<Bool> {
        return Binder(base, binding: { (target, isLoading) in
            if isLoading {
                if target.view.subviews.contains(where: { $0 is LoadableView }) { return }
                let loadingView = target.LoadingViewType.init()
                target.view.addSubview(loadingView)
                loadingView.snp.makeConstraints { $0.edges.equalTo(target.view) }
                loadingView.startAnimation()
            } else {
                target.view.subviews
                    .filter { $0 is LoadableView }
                    .forEach { $0.removeFromSuperview() }
            }
        })
    }
}

public struct ReactiveAlert {
    let message: String
}

public extension Reactive where Base: UIViewController {
    var showAlert: Binder<ReactiveAlert> {
        return Binder(base, binding: { (target, alert) in
            var attributes = EKAttributes.topFloat
            attributes.entryBackground = .color(color: .init(Colors.profileButtonsBackground.color))
            attributes.shadow = .active(with: .init(color: .init(UIColor.black),
                                                    opacity: 0.1, radius: 4,
                                                    offset: CGSize(width: 0, height: 2)))
            attributes.hapticFeedbackType = .warning
            attributes.displayDuration = 3
            
            let message = EKNoteMessageView(with: .init(text: alert.message,
                                                        style: .init(font: .regular(17), color: .white, alignment: .center)))
            SwiftEntryKit.display(entry: message, using: attributes)
        })
    }
}

public struct ReactiveAction {
    let image: UIImage
    let title: String
    let description: String
    let actionTitle: String
    let onAction: PublishSubject<Void>
}

public extension Reactive where Base: UIViewController {
    var showAction: Binder<ReactiveAction> {
        return Binder(base, binding: { (target, alert) in
            var attributes = EKAttributes.bottomFloat
            attributes.entryBackground = .color(color: .init(Colors.profileButtonsBackground.color))
            attributes.shadow = .active(with: .init(color: .init(UIColor.black),
                                                    opacity: 0.1, radius: 4,
                                                    offset: CGSize(width: 0, height: 2)))
            attributes.hapticFeedbackType = .error
            attributes.displayDuration = .infinity
            attributes.position = .bottom
            attributes.roundCorners = .all(radius: 32)
            attributes.screenBackground = .clear
            attributes.screenInteraction = .dismiss
            attributes.entryInteraction = .forward
            
            let image: EKPopUpMessage.ThemeImage = .init(image: .init(image: alert.image))
            let title: EKProperty.LabelContent = .init(text: alert.title,
                                                       style: .init(font: .bold(22), color: .init(.white), alignment: .center))
            
            let description: EKProperty.LabelContent = .init(text: alert.description,
                                                             style: .init(font: .regular(17), color: .white, alignment: .center))
            let button: EKProperty.ButtonContent = .init(label: .init(text: alert.actionTitle,
                                                                      style: .init(font: .semiBold(16), color: .white)),
                                                         backgroundColor: .init(Colors.loginButtonBlue.color),
                                                         highlightedBackgroundColor: .init(Colors.loginButtonBlue.color.withAlphaComponent(0.8)))
            
            let message = EKPopUpMessage.init(themeImage: image, title: title, description: description, button: button) {
                SwiftEntryKit.dismiss()
                alert.onAction.onNext(())
            }
            
            SwiftEntryKit.display(entry: EKPopUpMessageView(with: message), using: attributes)
        })
    }
}
