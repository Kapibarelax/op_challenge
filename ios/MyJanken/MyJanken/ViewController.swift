//
//  ViewController.swift
//  MyJanken
//
//  Created by 高松美香 on 2020/03/25.
//  Copyright © 2020 learning-swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var answerImageView: UIImageView!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    //ジャンケン（数字）
    var answerNumber = 0
    
    @IBAction func shuffleAction(_ sender: Any) {

        //新しいジャンケンの結果を一時的に格納する変数を設ける
        var newAnswerNumber = 0
        
        repeat {
            //0,1,2をランダムに算出
            newAnswerNumber = Int.random(in: 0..<3)
            
        } while answerNumber == newAnswerNumber //前回と同じ結果の場合リピート、異なる場合抜ける
        
        answerNumber = newAnswerNumber
        
        if answerNumber == 0 {
            //グー
            answerLabel.text = "グー"
            answerImageView.image = UIImage(named: "gu")
            
        } else if answerNumber == 1 {
            //チョキ
            answerLabel.text = "チョキ"
            answerImageView.image = UIImage(named: "choki")
        
        } else if answerNumber == 2 {
            //パー
            answerLabel.text = "パー"
            answerImageView.image = UIImage(named: "pa")
        }
        
    }
}

