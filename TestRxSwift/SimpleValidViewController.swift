//
//  SimpleValidViewController.swift
//  TestRxSwift
//
//  Created by macbook on 2018/11/23.
//  Copyright © 2018年 HSG. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class SimpleValidViewController: UIViewController {
    @IBOutlet weak var useNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameNotValidLabel: UILabel!
    @IBOutlet weak var passwordNotValidLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       let useNameSignal = useNameTextField.rx.text.orEmpty
        .map {  (value) -> Bool in
                let r = value.count >= 5
                print("userNameSignal count")
                return r
        }.share(replay: 1) //如果不加share,map中的事件会执行多次，如本例子是执行2次, rx默认是无状态的
        
        useNameSignal.bind(to: userNameNotValidLabel.rx.isHidden)
            .disposed(by: rx.disposeBag)
        
       let passwordSignal = passwordTextField.rx.text.orEmpty
            .map { $0.count >= 5 }
        
         passwordSignal.bind(to: passwordNotValidLabel.rx.isHidden)
            .disposed(by: rx.disposeBag)
        
        Observable.combineLatest(useNameSignal, passwordSignal) { (userValid, passwordValid) -> Bool in
            return userValid && passwordValid
        }
        .bind(to: loginButton.rx.isEnabled)
        .disposed(by: rx.disposeBag)
        
        loginButton.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
        .disposed(by: rx.disposeBag)
    }
    
    func showAlert() {
        let alertView = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        
        alertView.show()
    }
}
