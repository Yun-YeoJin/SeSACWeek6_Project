//
//  CardCollectionViewCell.swift
//  SeSACWeek6_Project
//
//  Created by 윤여진 on 2022/08/09.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        setupUI()
    }

    func setupUI() {
        cardView.backgroundColor = .clear
        cardView.posterImageView.backgroundColor = .lightGray
        cardView.posterImageView.layer.cornerRadius = 12
        cardView.likeButton.tintColor = .systemPink
    }
    
}
