//
//  CardView.swift
//  SeSACWeek6_Project
//
//  Created by 윤여진 on 2022/08/09.
//

import UIKit

/*
 XIB : Xml Interface Builder
 1. UIView의 Custom Class 지정
 2. File's owner > 활용도 / 여러 View 제약
 */

/*
 View: 인터페이스 빌더 UI 초기화 구문 <=> 코드 UI 초기화 구문
 required init() : 프로토콜 초기화 구문 = 초기화 구문이 프로토콜로 명시되어 있음
 */

class CardView: UIView {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    
    // 인터페이스 빌더 UI 초기화 구문
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds //모서리 맞춰주기
        view.backgroundColor = .lightGray
        self.addSubview(view)
        
        //true로 나오는 이유: 인터페이스 기반으로 잡았으나 let view로 코드로 초기화 해주었기 때문에.
        //true -> 오토레이아웃이 적용되는 관점보다 오토리사이징이 내부적으로 제약조건으로 처리가 됨.
        
        print(view.translatesAutoresizingMaskIntoConstraints)
    }
    
}
    
