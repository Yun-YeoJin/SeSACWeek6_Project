//
//  ReusableViewProtocol.swift
//  SeSACWeek6_Project
//
//  Created by 윤여진 on 2022/08/10.
//

import UIKit

protocol ReusableViewProtocol {
    static var reuseIdentifier: String { get } //저장 프로퍼티이든 연산프로퍼티 이든 상관없다.
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self) //extension이라서 저장 프로퍼티를 사용하지 못한다.
    }
}
extension UITableViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
