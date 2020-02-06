//
//  UITableView+Extension.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.NibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }

    func showEmptyView(show: Bool) {
        let scene = UIApplication.shared.connectedScenes.first
        guard let delegate: SceneDelegate = (scene?.delegate as? SceneDelegate), delegate.window != nil else { return }
        
        if show {
            let emptyView = EmptyView()
            emptyView.borders(for: [.bottom])
            self.backgroundView = emptyView
            
            delegate.window!.rootViewController!.view.addConstraintsWithFormat("H:|[v0]|", views: emptyView)
            delegate.window!.rootViewController!.view.addConstraintsWithFormat("V:|[v0(162)]|", views: emptyView)

            let xConstraintEmptyView = NSLayoutConstraint(item: emptyView, attribute: .centerX, relatedBy: .equal, toItem: self,
                                                          attribute: .centerX, multiplier: 1, constant: 0)
            let yConstraintEmptyView = NSLayoutConstraint(item: emptyView, attribute: .top, relatedBy: .equal, toItem: self,
                                                          attribute: .top, multiplier: 1, constant: 0)
            delegate.window!.rootViewController!.view.addConstraint(xConstraintEmptyView)
            delegate.window!.rootViewController!.view.addConstraint(yConstraintEmptyView)
            delegate.window!.rootViewController!.view.layoutIfNeeded()
        } else {
            self.restore()
        }
    }

    public func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}
