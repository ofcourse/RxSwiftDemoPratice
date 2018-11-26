//
//  ViewController.swift
//  TestRxSwift
//
//  Created by macbook on 2018/11/22.
//  Copyright © 2018年 HSG. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class ViewController: UIViewController {

    @IBOutlet weak var lightSwith: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lightSwith.rx.isOn
        .subscribe(onNext: { enabled in
            print( enabled ? "it's ON" : "it's OFF" )
        }).disposed(by: rx.disposeBag)
        
       let observable: Observable<Int> = Observable<Int>.just(1)
        
        observable.subscribe(onNext: { value in
            print(value)
        }).disposed(by: rx.disposeBag)
        
        Observable<Int>.just(2).subscribe(onNext: { value in
            print(value)
        }).disposed(by: rx.disposeBag)
        
        Observable.just(3).subscribe(onNext: { (value) in
            print(value)
        }).disposed(by: rx.disposeBag)
        
        
        let stringObservable = Observable.just("❤️")
        let fruitObservable = Observable.from(["🍎", "🍐", "🍊"])
        let animalObservable = Observable.of("🐶", "🐱", "🐭", "🐹")
        
        Observable.combineLatest([stringObservable, fruitObservable, animalObservable]) {
            "\($0[0]) \($0[1]) \($0[2])"
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: rx.disposeBag)
    }

}

