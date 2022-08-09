//
//  ViewController.swift
//  SeSACWeek6_Project
//
//  Created by 윤여진 on 2022/08/08.
//

import UIKit

import Alamofire
import SwiftyJSON


/*
 1. html tag <> </> 기능 활용
 2. 문자열 대체 메서드
 * response에서 처리하는 것과 보여지는 셀 등에서 처리하는 것의 차이?
 */

/*
 TableView의 특징: AutomaticDimension
 - 컨텐츠 양에 따라서 셀 높이가 자유롭게
 - 조건: Label.numberOfLines = 0
 - 조건: tableView Height AutomaticDimension
 */

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var bloglist: [String] = []
    var cafelist: [String] = []
    
    var isExpanded = false //false면 2줄, true면 0줄
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension // 모든 섹션과 셀에 대해서 유동적으로 잡겠다.
        
        searchBlog()
        
    }
    
    func searchBlog() {
        
        KakaoAPIManager.shared.callRequest(type: .blog, query: "삼겹살") { json in
            print(json)
            
            for item in json["documents"].arrayValue {
                self.bloglist.append(item["contents"].stringValue)
            }
           
            self.searchCafe() //네트워크 통신 한 번 더 하려고 한다.
            
           
        }
        
    }
    
    func searchCafe() {
        
        KakaoAPIManager.shared.callRequest(type: .cafe, query: "삼겹살") { json in
            print(json)
            
            for item in json["documents"].arrayValue {
//                self.cafelist.append(item["contents"].stringValue)
                
                let value = item["contents"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                
                self.cafelist.append(value)
            }
            print(self.bloglist)
            print(self.cafelist)
            // 다 받은 시점에서 reload
            self.tableView.reloadData()
            
        }
        
    }
    @IBAction func expandCell(_ sender: UIBarButtonItem) {
        
        isExpanded = !isExpanded
        tableView.reloadData()
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //Section 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bloglist.count
        } else {
            return cafelist.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "kakaoCell", for: indexPath) as? kakaoCell else { return UITableViewCell() }
        
        cell.testLabel?.numberOfLines = isExpanded == true ? 0 : 2
        cell.testLabel?.text = indexPath.section == 0 ? bloglist[indexPath.row] : cafelist[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "블로그 검색결과" : "카페 검색결과"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

class kakaoCell: UITableViewCell {
    
    @IBOutlet weak var testLabel: UILabel!
    
}
