//
//  MainTableViewCell.swift
//  SeSACWeek6_Project
//
//  Created by 윤여진 on 2022/08/09.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    // contentCollectionView도 delegate와 dataSource 필요. -> MainViewController (CellForRowAt)
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("MainTableViewCell", #function)
        setupUI()
    }

    
    func setupUI() {
        
        titleLabel.text = "넷플릭스 인기 콘텐츠"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.backgroundColor = .clear
        
        contentCollectionView.backgroundColor = .clear
        contentCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 240, height: 190)
        layout.estimatedItemSize = .zero
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        return layout
    }
    
}
