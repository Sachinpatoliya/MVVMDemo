//
//  Common.swift
//  PracticalTask
//
//  Created by Nikunj on 18/03/21.
//  Copyright © 2021 Nikunj. All rights reserved.
//

import Foundation
import UIKit

//Show Alerts
func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
    let action = UIAlertAction(title: title, style: .default) { (action) in
        topViewController()!.dismiss(animated: true, completion: nil)
    }
    alertController.addAction(action)
    topViewController()!.present(alertController, animated: true, completion: nil)
}

//Get topmost view controller
func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let navigationController = controller as? UINavigationController {
        return topViewController(controller: navigationController.visibleViewController)
    }
    if let tabController = controller as? UITabBarController {
        if let selected = tabController.selectedViewController {
            return topViewController(controller: selected)
        }
    }
    if let presented = controller?.presentedViewController {
        return topViewController(controller: presented)
    }
    return controller
}
