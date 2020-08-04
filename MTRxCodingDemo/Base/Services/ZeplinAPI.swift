//
//  ZeplinAPI.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import Foundation
import KeychainSwift
import Alamofire

enum ZeplinAPI {
    case getCurrentUser
    case getProjects
    case getScreens(project: Project)
}

extension ZeplinAPI {
    var baseURL: URL { URL(string: "https://api.relevantfruit.com/v1/zeplin")!
    }
    
    var path: String {
        switch self {
        case .getCurrentUser:
            return "/user/me"
        case .getProjects:
            return "/projects"
        case .getScreens(let project):
            return "/projects/\(project.id!)/screens"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCurrentUser, .getProjects, .getScreens:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        var fields: HTTPHeaders = ["Content-type": "application/json"]
        
        if let jwt = Keychain.get(.token) {
            fields["Authorization"] = jwt.value
        }
        
        return fields
    }
}
