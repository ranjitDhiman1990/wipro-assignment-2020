//
//  UIViewController+Extension.swift
//  Wipro Assignment
//
//  Created by Dhiman Ranjit on 19/07/20.
//  Copyright © 2020 Dhiman Ranjit. All rights reserved.
//

import UIKit

typealias AlertButtionActionHandler = ((UIAlertAction) -> Void)?

extension UIViewController {
    // MARK:- UIAlert Views
    func showAlertWithSingleButton(title: String?, message: String?, okButtonText: String?, okButtonAction: AlertButtionActionHandler?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: okButtonText, style: UIAlertAction.Style.default, handler: okButtonAction ?? nil))
        self.present(alert, animated: true, completion: nil)
    }
}
