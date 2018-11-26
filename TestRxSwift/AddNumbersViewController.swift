//
//  AddNumbersViewController.swift
//  TestRxSwift
//
//  Created by macbook on 2018/11/23.
//  Copyright © 2018年 HSG. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class AddNumbersViewController: UIViewController {

    @IBOutlet weak var firstNumberTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         firstNumberTextField.rx.text.orEmpty
         .subscribe(onNext: { (value) in
            print(value)
        }).disposed(by: rx.disposeBag)
        
        secondTextField.rx.text.orEmpty
            .subscribe(onNext: { (value) in
                print(value)
            }).disposed(by: rx.disposeBag)
        
        thirdTextField.rx.text.orEmpty
            .subscribe(onNext: { (value) in
                print(value)
            }).disposed(by: rx.disposeBag)
        
        Observable.combineLatest(firstNumberTextField.rx.text.orEmpty, secondTextField.rx.text.orEmpty,thirdTextField.rx.text.orEmpty) { (first, seoncd,third) -> Int in
             return  (Int(first) ?? 0) + (Int(seoncd) ?? 0) + (Int(third) ?? 0)
            }.map { $0.description}
            .bind(to: totalLabel.rx.text).disposed(by: rx.disposeBag)
    }
    
}
