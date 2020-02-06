//
//  AlertDisplayer.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

protocol AlertDisplayer: AnyObject {
    func displaySuccessAlert(title: String, message: String)
    func displayErrorAlert(title: String, message: String)
}

extension AlertDisplayer where Self: UIViewController {
    func displaySuccessAlert(title: String, message: String) {
        let alert = MessageView.viewFromNib(layout: .messageView)
        alert.configureTheme(.success)
        alert.configureDropShadow()
        alert.configureContent(title: "", body: "\(title) \(message)")
        alert.backgroundColor = .greenAlert
        alert.button?.isHidden = true
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .top
        config.duration = SwiftMessages.Duration.seconds(seconds: 3.0)
        DispatchQueue.main.async(execute: {
            SwiftMessages.show(config: config, view: alert)
        })
    }

    func displayErrorAlert(title: String, message: String) {
        let alert = MessageView.viewFromNib(layout: .messageView)
        alert.configureTheme(.success)
        alert.configureDropShadow()
        alert.configureContent(title: "", body: "\(title) \(message)")
        alert.backgroundColor = .redAlert
        alert.button?.isHidden = true
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .top
        config.duration = SwiftMessages.Duration.seconds(seconds: 3.0)
        DispatchQueue.main.async(execute: {
            SwiftMessages.show(config: config, view: alert)
        })
    }
}
