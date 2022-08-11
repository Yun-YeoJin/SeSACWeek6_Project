//
//  MainViewController.swift
//  SeSACWeek6_Project
//
//  Created by 윤여진 on 2022/08/09.
//

import UIKit

import Kingfisher

/*
 awakeFromNib: 셀 UI 초기화, 재사용 매커니즘에 의해 일정 횟수 이상 호춛되지 않음
 cellForItemAt:
 - 재사용 될 때마ㅏㄷ, 사용자에게 보일 때 마다 항상 실행됨
 - 화면과 데이터는 별개, 모든 indexpath.item에 대한 조건이 없다면 재사용시 오류가 발생할 수 있음
 prepareForReuse
 - 셀이 재사용 될 때 초기화 하고자 하는 값을 넣으면 오류를 해결할 수 있음, 즉 cellForItemAt에서 모든 indexpath.item에 대한 조건을 작성하지 않아도 댐
 CollectionView in TableView
 - 하나의 컬렉션뷰나 테이블뷰라면 문제가 없음
 - 복합적 구조라면 테이블셀도 재사용, 컬렉션 셀도 재사용이 되어야 함
 - Index > reloadData 를 사용해서 Index Out of Range 해결!
 
 
 */
class MainViewController: UIViewController {
    
    let color: [UIColor] = [.systemMint, .systemBrown, .lightGray, .yellow, .blue, .green]
    
    let numberList: [[Int]] = [
        [Int](100...120),
        [Int](55...75),
        [Int](500...526),
        [Int](90...99),
        [Int](123...135)
    ]
    
    var episodeList: [[String]] = []
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        
        bannerCollectionView.collectionViewLayout = collectionViewLayout()
        bannerCollectionView.isPagingEnabled = true // 디바이스의 width 기준으로 움직여준다.
        
        TMDBAPIManager.shared.requestImage { value in
            dump(value)
            //1. 네트워크 통신 => 2. 배열 생성 (episodeList) => 3. 배열 담기 => 4.뷰에 표현 => 5. TableView 갱신
            
            DispatchQueue.main.async {
                self.episodeList = value
                self.mainTableView.reloadData()
            }
        }
    }
    
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 1) 테이블뷰 섹션의 갯수 설정
    func numberOfSections(in tableView: UITableView) -> Int {
        return episodeList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    // 내부 매개변수 tableView를 통해 테이블뷰를 특정
    // 테이블뷰 객체가 하나일 경우에는 내부 매개변수를 황용하지 않아도 문제가 생기지 않는다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        print("MainViewController", #function, indexPath)
        
        cell.titleLabel.text = TMDBAPIManager.shared.tvList[indexPath.section].0 // 튜플의 앞 쪽에 있는 데이터 가져온다.
        
        cell.backgroundColor = .yellow
        cell.contentCollectionView.backgroundColor = .clear
        
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        cell.contentCollectionView.reloadData() //MARK: Index Out of Range 해결
        
        // 각 셀 구분 짓기
        cell.contentCollectionView.tag = indexPath.section // section이 10개고, row가 1개라서.
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    
}

//하나의 프로토콜, 메서드에서 여러 컬렉션뷰의 delegate, datasource 구현해야함
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // 2) 컬렉션뷰의 섹션안에 아이템 갯수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == bannerCollectionView ? color.count : episodeList[collectionView.tag].count
        
    }
    
    //collectionView가 bannerCollectionView OR CardCollectionView가 들어올 수 있다.
    //내부 매겨변수가 아닌 명확한 아웃렛을 사용할 경우, 셀이 재사용 되면 특정 컬렉션뷰 셀을 재사용하게 될 수 있음.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("MainViewController", #function, indexPath)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell() }
        
        
        if collectionView == bannerCollectionView {
            cell.cardView.posterImageView.backgroundColor = color[indexPath.item]
        } else {
            cell.cardView.posterImageView.backgroundColor = .black
            cell.cardView.contentLabel.textColor = .white
            // 3) 킹피셔를 이용한 image URL 설정
            let url = URL(string: "\(TMDBAPIManager.shared.imageURL)\(episodeList[collectionView.tag][indexPath.item])")
            cell.cardView.posterImageView.kf.setImage(with: url)
            cell.cardView.contentLabel.text = ""
            
        }
        
        //   if indexPath.item < 2 {
        // cell.cardView.contentLabel.text = "\( numberList[collectionView.tag][indexPath.item])"
        //   }
        //        else {
        //            cell.cardView.contentLabel.text = "HAPPY"
        //        }
        
        return cell
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: bannerCollectionView.frame.height)
        layout.estimatedItemSize = .zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return layout
    }
}


