//
//  ViewController.swift
//  MyFirst
//
//  Created by 高松美香 on 2020/03/23.
//  Copyright © 2020 高松美香. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // (1) ラベルに文字を入れる
        outputLabel.text = "Hello Swift!"
    }


    @IBOutlet weak var outputLabel: UILabel!
}

