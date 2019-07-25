//
//  ViewController.swift
//  Swiffee VR
//
//  Created by Laksh Bhambhani on 7/20/19.
//  Copyright © 2019 Laksh Bhambhani. All rights reserved.
//

import UIKit
import WebKit
import CoreMotion



class ViewController: UIViewController, WKUIDelegate {
    
   var manager = CMMotionManager()
    var loadView: WKWebView!
    
    let ip = "192.168.0.33"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        loadView = WKWebView(frame: .init(x: 1000, y: 1000, width: 0, height: 0), configuration: webConfiguration)
        loadView.uiDelegate = self
        
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        let localfilePath = Bundle.main.url(forResource: "home", withExtension: "html");
        let myRequest = NSURLRequest(url: localfilePath!);
        webView.load(myRequest as URLRequest);
        self.view.addSubview(webView)
        
        gyroscope()
    }
    
    func gyroscope(){
        manager.gyroUpdateInterval = 1.0 / 25.0
        manager.startGyroUpdates(to: OperationQueue.current!){ (data, error) in
        print(data as Any)
            if let trueData = data{
                self.view.reloadInputViews()
                let x =  trueData.rotationRate.x
                let y =  trueData.rotationRate.y
                let z =  trueData.rotationRate.z
                
                var lastMotion = ""
                
                if y < 0.5{
                    if lastMotion != "bendBack" && lastMotion != "bow"{
                        self.bendBackAction()
                        lastMotion = "bendBack"
                    }
                    else{
                        self.homeAction()
                        lastMotion =  "homePos"
                    }
                }
                if y > -0.5 {
                    if lastMotion != "bow" && lastMotion != "bendBack"{
                        self.bowAction()
                        lastMotion = "bow"
                    }
                    else{
                        self.homeAction()
                        lastMotion = "homePos"
                    }
                }
                
                if x > 0.5{
                    if lastMotion != "right"{
                        self.rightAction()
                        lastMotion = "right"
                    }
                }
                if y < -0.5 {
                    if lastMotion != "left"{
                        self.leftAction()
                        lastMotion = "left"
                    }
                }
//                print("x: \(Double(x).rounded(toPlaces :3))")
//                print("y: \(Double(y).rounded(toPlaces :3))")
//                print("z: \(Double(z).rounded(toPlaces :3))")
            }
        }
    }
    
    func leftAction() {
        print("Left Clicked")
        let url = URL(string: "http://" + ip + "/turnLeft");
        let request = URLRequest(url: url!);
        loadView.load(request);
        print(url)
    }
    
    func rightAction() {
        print("Right Clicked")
        let url = URL(string: "http://" + ip + "/turnRight");
        let request = URLRequest(url: url!);
        loadView.load(request);
        print(url)
    }
    
    func bowAction() {
        print("Bow Clicked")
        let url = URL(string: "http://" + ip + "/bow");
        let request = URLRequest(url: url!);
        loadView.load(request);
        print(url)
    }
    
    func bendBackAction() {
        print("Bend Back Clicked")
        let url = URL(string: "http://" + ip + "/bendBack");
        let request = URLRequest(url: url!);
        loadView.load(request);
        print(url)
    }
    
    func homeAction() {
            print("Home Clicked")
            let url = URL(string: "http://" + ip + "/homePos");
            let request = URLRequest(url: url!);
            loadView.load(request);
            print(url)
        }
    

}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

