//
//  MainViewController.swift
//  SeSACWeek6_Project
//
//  Created by 윤여진 on 2022/08/09.
//

import UIKit

class MainViewController: UIViewController {
    
    let color: [UIColor] = [.systemMint, .systemBrown, .lightGray, .yellow, .blue, .green]
    
    let numberList: [[Int]] = [
        [Int](100...110),
        [Int](55...75),
        [Int](500...506),
        [Int](90...99),
        [Int](123...145)
    ]
    
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
        
    }
    
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .yellow
        cell.contentCollectionView.backgroundColor = .lightGray
        
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        // 각 셀 구분 짓기
        cell.contentCollectionView.tag = indexPath.section // section이 10개고, row가 1개라서.
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 3 ? 350 : 190
    }
    
    
}

//하나의 프로토콜, 메서드에서 여러 컬렉션뷰의 delegate, datasource 구현해야함
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == bannerCollectionView ? color.count : numberList[collectionView.tag].count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell() }
        
        
        if collectionView == bannerCollectionView {
            cell.cardView.posterImageView.backgroundColor = color[indexPath.item]
        } else {
            cell.cardView.posterImageView.backgroundColor = .black
            cell.cardView.contentLabel.textColor = .white
            cell.cardView.contentLabel.text = "\( numberList[collectionView.tag][indexPath.item])"
            
        }
        
        
        
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
