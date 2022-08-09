//
//  KakaoAPIManager.swift
//  SeSACWeek6_Project
//
//  Created by 윤여진 on 2022/08/08.
//

import UIKit

import Alamofire
import SwiftyJSON


class KakaoAPIManager {
    
    static let shared = KakaoAPIManager()
    
    private init() { }
    
    let headers : HTTPHeaders = [ //어차피 싱글턴이기 때문에 한 곳에서 사용
        "Content-Type": "application/x-www-form-urlencoded;charset=utf-8",
        "Authorization": "KakaoAK \(APIKey.kakao)"
    ]
    
    func callRequest(type: EndPoint, query: String, completionHandler: @escaping (JSON) -> () ) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = type.requestURL + query
       
            AF.request(url, method: .get, headers: headers).validate().responseData { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    completionHandler(json)
                    
                case .failure(let error):
                print(error)
            }
        }
    
    }
}
