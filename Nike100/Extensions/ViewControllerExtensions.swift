//
//  ViewControllerExtensions.swift
//  Nike100
//
//  Created by Jeffrey Haley on 9/20/19.
//  Copyright © 2019 Jeffrey Haley. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func displaySimpleAlert(message: String) {
        let alertVc = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVc, animated: true, completion: nil)
    }
}

