//
//  MainViewController.swift
//  RokidSDKDemoSwift
//
//  Created by Yock on 2017/11/29.
//  Copyright © 2017年 Rokid. All rights reserved.
//

import UIKit
import RokidSDK

class MainViewController: UIViewController {

    @IBOutlet weak var LabelSDKInitStatus: UILabel!
    
    @IBOutlet weak var LabelUID: UILabel!
    
    @IBOutlet weak var LabelToken: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        RokidMobileSDK.shared.initSDK(appKey: "rokid-demo", appSecret: "rokid-demo-secret") { (result, error) in
//            if let err_message = error?.message {
//                self.LabelSDKInitStatus.text = "\(result)" + " / " + err_message
//            } else {
//                self.LabelSDKInitStatus.text = "\(result)"
//            }
//            
//            if result {
//                RokidMobileSDK.account?.sdkLogin(name: "自己注册的账号", password: "自己注册的密码", complete: { (uidParam, tokenParam, errorParam) in
//                    if let uid = uidParam, let token = tokenParam {
//                        self.LabelUID.text = uid
//                        self.LabelToken.text = token
//
//                        RokidMobileSDK.device?.queryDeviceList(complete: { (device_list_optional, error_optional) in
//                            if let device_list = device_list_optional {
//                                print(device_list)
//                            } else if let error = error_optional {
//                                print(error)
//                            } else {
//                                print(".............")
//                            }
//                        })
//                    } else if let err_message = errorParam?.message {
//                        self.LabelUID.text = err_message
//                        self.LabelToken.text = err_message
//                    }
//                })
//            }
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

