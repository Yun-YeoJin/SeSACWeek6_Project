//
//  ClosureViewController.swift
//  SeSACWeek6_Project
//
//  Created by 윤여진 on 2022/08/08.
//

import UIKit

class ClosureViewController: UIViewController {

    
    @IBOutlet weak var card: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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