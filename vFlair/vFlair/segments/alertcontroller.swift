//
//  alertcontroller.swift
//  vFlair
//
//  Created by Prajwal V.v on 19/10/18.
//  Copyright © 2018 fluid. All rights reserved.
//

import UIKit

class AlertController {
    static func showAlert( inViewController: UIViewController, title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        inViewController.present(alert, animated: true, completion: nil)
    }
}

