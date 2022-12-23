//
//  Alert+UIViewController.swift
//  Sample
//
//  Created by Jagadeesha on 21/12/22.
//

import Foundation
import UIKit

var vSpinner: UIView?

extension UIViewController {
    
    func alert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showSpinner(_ activityStyle: UIActivityIndicatorView.Style, color: UIColor? = nil) {
        if vSpinner == nil {
            let spinnerView = UIView.init(frame: self.view.bounds)
            let activityView = UIActivityIndicatorView(style: activityStyle)
            activityView.center = spinnerView.center
            if let color = color {
                activityView.color = color
            }
            activityView.startAnimating()
            DispatchQueue.main.async {
                spinnerView.addSubview(activityView)
                self.view.addSubview(spinnerView)
            }
            vSpinner = spinnerView
        }
    }
    
    func removeSpinner() {
         if vSpinner != nil {
             DispatchQueue.main.async {
                 vSpinner?.removeFromSuperview()
                 vSpinner = nil
             }
         }
     }
    
}

enum StoryboardName: String {
    case main = "Main"
}

extension UIViewController {
    static func instantiate<T: UIViewController>(_ appStoryboard: StoryboardName) -> T {
        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
