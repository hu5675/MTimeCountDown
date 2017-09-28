//
//  ViewController.swift
//  MTimeCountDown
//
//  Created by hu5675 on 09/28/2017.
//  Copyright (c) 2017 hu5675. All rights reserved.
//

import UIKit
import MTimeCountDown

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let timer:MTimeCountDownTimeSource? = MTimeCountDownTimeSource()
        timer?.startCountDown(delay: 0, timeCount: 10, repeatBlock: { (left) -> (Void) in
            print("left:\(left)")
        }) { (left) -> (Void) in
            print("倒计时结束")
        }
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3) {
            timer?.cancelCountDown()
        }

        MTimeCountDownOperationManager.manager.startCountDown("1234", delay: 2, timeCount: 10, repeatBlock: { (left) in
            print("left:\(left)")
        }) { (left) in
            print("倒计时结束")
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            MTimeCountDownOperationManager.manager.cancelTask("1234")
        }
    }

}

