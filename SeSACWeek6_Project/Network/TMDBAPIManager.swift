//
//  TMDBAPIManager.swift
//  SeSACWeek6_Project
//
//  Created by 윤여진 on 2022/08/10.
//

import UIKit

import Alamofire
import SwiftyJSON

class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
    private init() { }
    
    let tvList = [
        ("환혼", 135157),
        ("이상한 변호사 우영우", 197067),
        ("인사이더", 135655),
        ("미스터 션사인", 75820),
        ("스카이 캐슬", 84327),
        ("사랑의 불시착", 94796),
        ("이태원 클라스", 96162),
        ("호텔 델루나", 90447)
    ]

    let imageURL = "https://image.tmdb.org/t/p/w500"
    
    func callRequest(query: Int, completionHandler: @escaping ([String]) -> () ) {
        
    // guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = "https://api.themoviedb.org/3/tv/\(query)/season/1?api_key=\(APIKey.TMDB)&language=ko-KR"

            AF.request(url, method: .get).validate().responseData { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
//                    var stillArray: [String] = []
                    
//                    for list in json["episodes"].arrayValue {
//                        let value = list["still_path"].stringValue
//                        stillArray.append(value)
//                    }
                    
                    let value = json["episodes"].arrayValue.map { $0["still_path"].stringValue }
                    
                    completionHandler(value)
                    
                case .failure(let error):
                print(error)
            }
        }
    
    }
    
    
    func requestImage(completionHandler: @escaping ([[String]]) -> ()) {

        var posterList: [[String]] = []

        TMDBAPIManager.shared.callRequest(query: tvList[0].1) { value in
            posterList.append(value)

            TMDBAPIManager.shared.callRequest(query: self.tvList[1].1) { value in
                posterList.append(value)

                TMDBAPIManager.shared.callRequest(query: self.tvList[2].1) { value in
                    posterList.append(value)

                    TMDBAPIManager.shared.callRequest(query: self.tvList[3].1) { value in
                        posterList.append(value)

                        TMDBAPIManager.shared.callRequest(query: self.tvList[4].1) { value in
                            posterList.append(value)

                            TMDBAPIManager.shared.callRequest(query: self.tvList[5].1) { value in
                                posterList.append(value)

                                TMDBAPIManager.shared.callRequest(query: self.tvList[6].1) { value in
                                    posterList.append(value)

                                    TMDBAPIManager.shared.callRequest(query: self.tvList[7].1) { value in
                                        posterList.append(value)
                                        
                                        completionHandler(posterList)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
//    func requestEpisodeImage() {
//
//         어떤 문제가 생길까요? =>
//         1. 순서 보장이 안됨!!!
//         2. 언제 끝날 지 모른다.
//        for item in tvList {
//            TMDBAPIManager.shared.callRequest(query: item.1) { stillpath in
//                print(stillpath)
//            }
//        }
//
//        let id = tvList[7].1 //호텔 델루나, 90447
//
//        TMDBAPIManager.shared.callRequest(query: id) { stillpath in
//
//            print(stillpath)
//            TMDBAPIManager.shared.callRequest(query: self.tvList[5].1) { stillpath in
//                print(stillpath)
//            }
//
//        }
//
//    }
    
    
}
