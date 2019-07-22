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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        let localfilePath = Bundle.main.url(forResource: "home", withExtension: "html");
        let myRequest = NSURLRequest(url: localfilePath!);
        webView.load(myRequest as URLRequest);
        self.view.addSubview(webView)
    }
    
    func gyroscope(){
        manager.gyroUpdateInterval = 0.1
        manager.startGyroUpdates(to: OperationQueue.current!){ (data, error) in
        print(data as Any)
            if let trueData = data{
                self.view.reloadInputViews()
                let x =  trueData.rotationRate.x
                let y =  trueData.rotationRate.y
                let z =  trueData.rotationRate.z
                print(x + y + z)
            }
        }
    }
    
    

}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

