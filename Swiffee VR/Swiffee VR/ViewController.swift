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
    
    let manager = CMMotionManager()
    var loadView: WKWebView!
    
    let ip = "192.168.5.1"
    var lastMotion = ""
    
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
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startDeviceMotionUpdates(to: OperationQueue.main){
            (data, error) in
            let roll = (data?.attitude.roll)!
            let yaw = (data?.attitude.yaw)!
            

                            if (roll < 1.0){
                                if !(self.lastMotion == "reverse"){
                                    reverseAction()
                                    self.lastMotion = "reverse"
                                }
                            }
                            if (roll > 1.8 ){
                                if !(self.lastMotion == "forward"){
                                    forwardAction()
                                    self.lastMotion = "forward"
                                }
                            }

                            if (yaw < -0.5){
                                if !(self.lastMotion == "right"){
                                    rightAction()
                                    self.lastMotion = "right"
                                }
                            }
                            if (yaw > 0.4) {
                                if !(self.lastMotion == "left"){
                                    leftAction()
                                    self.lastMotion = "left"
                                }
                            }
            if (roll > 1.0 && roll < 1.8 && yaw > -0.5 && yaw < 0.4){
                if (self.lastMotion != "home"){
                    homeAction()
                    self.lastMotion = "home"
                }
            }
       }
    
    func leftAction() {
        print("left")
        let url = URL(string: "http://" + ip + "/turnLeft");
        let request = URLRequest(url: url!);
        loadView.load(request);
        //print(url)
    }

    func rightAction() {
        print("right")
        let url = URL(string: "http://" + ip + "/turnRight");
        let request = URLRequest(url: url!);
        loadView.load(request);
        //print(url)
    }

    func forwardAction() {
        print("forward")
        let url = URL(string: "http://" + ip + "/forward");
        let request = URLRequest(url: url!);
        loadView.load(request);
        //print(url)
    }

    func reverseAction() {
        print("reverse")
        let url = URL(string: "http://" + ip + "/reverse");
        let request = URLRequest(url: url!);
        loadView.load(request);
        //print(url)
    }

    func homeAction() {
        print("home")
            let url = URL(string: "http://" + ip + "/stop");
            let request = URLRequest(url: url!);
            loadView.load(request);
           // print(url)
        }


}

//extension Double {
//    /// Rounds the double to decimal places value
//    func rounded(toPlaces places:Int) -> Double {
//        let divisor = pow(10.0, Double(places))
//        return (self * divisor).rounded() / divisor
//    }
//}

}
