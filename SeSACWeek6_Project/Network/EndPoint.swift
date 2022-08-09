//
//  EndPoint.swift
//  SeSACWeek6_Project
//
//  Created by 윤여진 on 2022/08/08.
//

import Foundation
// enum에서 저장 프로퍼티는 못쓰고, 연산 프로퍼티는 쓸 수 있는 이유? => 메서드처럼 작동해서(메모리차이)
enum EndPoint {
    case blog
    case cafe
    
    var requestURL: String {
        switch self {
        case .blog: return URL.makeEndPointString("blog?query=")
        case .cafe: return URL.makeEndPointString("cafe?query=")
        }
    }
}




