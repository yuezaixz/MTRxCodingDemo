//
//  ZeplinService.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import Alamofire

protocol HasZeplinService {
    var zeplinServices: ZeplinService { get }
}

class ZeplinService: HasPreferenceService {
    
    let preferenceServices = PreferenceService()
    
    func getProjects() {
        AF.request(ZeplinAPI.getProjects.path, method: ZeplinAPI.getProjects.method, headers: ZeplinAPI.getProjects.headers).responseJSON { (response) in
            print(response)
        }
    }
}
