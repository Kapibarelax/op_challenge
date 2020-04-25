//
//  ViewController.swift
//  MyMap
//
//  Created by 高松美香 on 2020/03/30.
//  Copyright © 2020 learning-swift. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITextFieldDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputText.delegate = self
    }
    
    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var dispMap: MKMapView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.resignFirstResponder()
        
        if let searchKey = textField.text{
            print(searchKey)
        
        
        let geocoder = CLGeocoder()
        
        // 入力された文字から位置情報を取得
        geocoder.geocodeAddressString(searchKey, completionHandler: {(placemarks, error) in
            
            // 位置情報が存在する場合は、unwrapPlacemarksに取り出す
            if let unwrapPlacemarks = placemarks{
                
                // 1件目の情報を取り出す
                if let firstPlacemark = unwrapPlacemarks.first {
                    
                    // 位置情報取得
                    if let location = firstPlacemark.location {
                        
                        // 位置情報から緯度経度をtargetCoordinateに取り出す
                        let targetCoordinate = location.coordinate
                        
                        // 緯度経度をデバッグエリアに表示
                        print(targetCoordinate)
                        
                        // MKPointAnnotationのインスタンスを取得し、ピン生成
                        let pin = MKPointAnnotation()
                        
                        // ピンを置く場所に緯度経度設定
                        pin.coordinate = targetCoordinate
                        
                        // ピンのタイトルを設定
                        pin.title = searchKey
                        
                        // ピンを地図に置く
                        self.dispMap.addAnnotation(pin)
                        
                        // 緯度経度を中心に半径500mの範囲を表示
                        self.dispMap.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                 
                    }
                }
            }
        })
        
        }
        return true
    }

    @IBAction func changeMapButton(_ sender: Any) {
        if dispMap.mapType == .standard {
            dispMap.mapType = .satellite
        }else if dispMap.mapType == .satellite {
            dispMap.mapType = .hybrid
        }else if dispMap.mapType == .hybrid {
            dispMap.mapType = .satelliteFlyover
        }else if dispMap.mapType == .satelliteFlyover {
            dispMap.mapType = .hybridFlyover
        }else if dispMap.mapType == .hybridFlyover {
            dispMap.mapType = .mutedStandard
        }else {
            dispMap.mapType = .standard
        }
    }
}
