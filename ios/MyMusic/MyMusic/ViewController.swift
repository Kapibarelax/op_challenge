//
//  ViewController.swift
//  MyMusic
//
//  Created by 高松美香 on 2020/03/28.
//  Copyright © 2020 learning-swift. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //シンバルの音源ファイルを指定
    let cymbalPath = Bundle.main.bundleURL.appendingPathComponent("cymbal.mp3")
    
    //シンバル用のプレイヤーインスタンスを作成
    var cymbalPlayer = AVAudioPlayer()

    @IBAction func cymbal(_ sender: Any) {
        do{
            //パス指定
            cymbalPlayer = try AVAudioPlayer(contentsOf: cymbalPath, fileTypeHint: nil)
            //音源再生
            cymbalPlayer.play()
            
        } catch {
            print("シンバルエラー")
        }
    }
    
    //ギターの音源ファイルを指定
    let guitarPath = Bundle.main.bundleURL.appendingPathComponent("guitar.mp3")
    
    //ギター用のプレイヤーインスタンスを作成
    var guitarPlayer = AVAudioPlayer()

    @IBAction func guitar(_ sender: Any) {
        do{
            //パス指定
            guitarPlayer = try AVAudioPlayer(contentsOf: guitarPath, fileTypeHint: nil)
            //音源再生
            guitarPlayer.play()
            
        } catch {
            print("ギターエラー")
        }
        
    }
    
    //バックミュージックの音源ファイルを指定
    let backmusicPath = Bundle.main.bundleURL.appendingPathComponent("backmusic.mp3")
    
    //バックミュージック用のプレイヤーインスタンスを作成
    var backmusicPlayer = AVAudioPlayer()
    
    @IBAction func play(_ sender: Any) {
        do{
            //パス指定
            backmusicPlayer = try AVAudioPlayer(contentsOf: backmusicPath, fileTypeHint: nil)
            //音源リピート再生
            backmusicPlayer.numberOfLoops = -1
            backmusicPlayer.play()
            
        } catch {
            print("playエラー")
        }
        
    }
    
    
    @IBAction func stop(_ sender: Any) {
        if backmusicPlayer.isPlaying {
            backmusicPlayer.stop()
        }
    }
}

