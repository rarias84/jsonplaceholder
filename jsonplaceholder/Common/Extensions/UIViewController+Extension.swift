//
//  UIViewController+Extension.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import UIKit

extension UIViewController: ReusableView {}

extension UIViewController {
    var isModal: Bool {
        if self.isViewLoaded || self.view!.window != nil || self.viewIfLoaded?.window != nil {
            return true
        }
        return false
    }
}
