//
//  Extensions.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import RxSwift

var appVersion: String {
    guard let dictionary = Bundle.main.infoDictionary,
        let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
    return version
}

var appName: String {
    let name = Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as? String
    return name ?? ""
}

var bundleID: String {
    return Bundle.main.bundleIdentifier ?? ""
}

extension Date {
    func daysUntil(to: Date) -> String {
        let between =  Calendar.current.dateComponents([.year, .month, .day], from: self, to: to)
        
        if between.year ?? 0 > 0 {
            return "\(between.year ?? 0)y"
        } else if between.month ?? 0 > 0 {
            return "\(between.month ?? 0)m"
        } else {
            return "\(between.day ?? 1)d"
        }
    }
}

extension UINavigationController {
    func setupStyling() {
        navigationBar.backgroundColor = Colors.windowBackgroundBlack.color
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [.font: UIFont.semiBold(17)]
        navigationBar.tintColor = Colors.mustardYellow.color
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [.font: UIFont.semiBold(17)]
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = Colors.windowBackgroundBlack.color
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
        }
    }
}

extension UIImageView {
    func withAlpha(_ alpha: CGFloat) -> UIImageView {
        self.alpha = alpha
        return self
    }
}

extension UIFont {
    static func semiBold(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    static func bold(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    static func regular(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func medium(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
}

extension WKWebView {
    func cleanAllCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
    
    func refreshCookies() {
        self.configuration.processPool = WKProcessPool()
    }
}

public protocol OptionalType {
    associatedtype Wrapped
    
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { return self }
}

extension Observable where Element: OptionalType {
    func ignoreNil() -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Observable<Element.Wrapped>.just($0) } ?? Observable<Element.Wrapped>.empty()
        }
    }
}

extension UIView {
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
}
