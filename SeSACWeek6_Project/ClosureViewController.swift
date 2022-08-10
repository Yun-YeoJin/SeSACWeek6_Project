//
//  ClosureViewController.swift
//  SeSACWeek6_Project
//
//  Created by 윤여진 on 2022/08/08.
//

import UIKit

class ClosureViewController: UIViewController {

    
    @IBOutlet weak var card: CardView!
    
    @IBOutlet weak var orangeView: UIView!
    
    var sampleButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(orangeView.translatesAutoresizingMaskIntoConstraints)
        print(sampleButton.translatesAutoresizingMaskIntoConstraints)
        print(card.translatesAutoresizingMaskIntoConstraints)
        
        //버튼 위치, 크기, 추가
        /*
         오토리사이징을 오토레이아웃 제약조건처럼 설정해주는 기능이 내부적으로 구현되어 있음
         이 기능은 디폴트값이 true <=> 하지만 오토레이아웃을 지정해주면 오토리사이징을 안 쓰겠다는 의미인 false 상태로 내부적으로 변경됨.
         코드 기반 UI -> True
         인터페이스 빌더 기반 UI -> False
        */
        
        sampleButton.frame = CGRect(x: 100, y: 400, width: 100, height: 100)
        sampleButton.backgroundColor = .orange
        view.addSubview(sampleButton)
        
        card.posterImageView.backgroundColor = .red
        card.likeButton.backgroundColor = .yellow
        card.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)

    }
    @objc func likeButtonClicked() {
        print("버튼 클릭")
    }
    

    @IBAction func colorPickerButtonClicked(_ sender: UIButton) {
        
        showAlert(title: "컬러피커를 띄우겠습니까?", message: nil, okTitle: "띄우기") {
            let picker = UIColorPickerViewController()
            self.present(picker, animated: true)
        }
    }
    @IBAction func backgroundColorChangeButton(_ sender: UIButton) {
        showAlert(title: "배경색 변경", message: "배경색을 바꾸시겠습니까?", okTitle: "바꾸기") {
            self.view.backgroundColor = .gray
        }

    }
    

}

extension UIViewController {
    
    func showAlert(title: String, message: String?, okTitle: String, okAction: @escaping () -> () ) {
        
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let cancel = UIAlertAction(title: "취소", style: .cancel)
    let ok = UIAlertAction(title: okTitle, style: .default) { action in
        okAction()
    }
    
    alert.addAction(cancel)
    alert.addAction(ok)
    
    present(alert, animated: true)
    }
}
