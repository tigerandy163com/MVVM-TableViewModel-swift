//
//  ViewController.swift
//  MVVM-TableViewModel
//
//  Created by xx on 2019/7/9.
//  Copyright © 2019 tfb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func test(_ sender: Any) {
        let vc = TestViewController()
        self.present(vc, animated: true)
    }
}

