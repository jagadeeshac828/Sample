//
//  Alert+UIViewController.swift
//  Sample
//
//  Created by Jagadeesha on 21/12/22.
//

import Foundation
import UIKit

extension UIViewController {
    func alert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
