//
//  URL+Extension.swift
//  SeSACWeek6_Project
//
//  Created by 윤여진 on 2022/08/08.
//

import Foundation

extension URL {
    static let baseURL = "https://dapi.kakao.com/v2/search/"
    
    static func makeEndPointString(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
}

