//
//  UserDetailViewController.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, AlertDisplayer {
    
    // MARK: - Lifecycle Methods
    override func loadView() {
        view = UserDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    // MARK: - Actions
    @objc func refresh() {
        presenter?.refresh()
    }
    
    @objc func addFavorite() {
        presenter?.addFavorite()
    }
    
    @objc func removeFavorite() {
        presenter?.removeFavorite()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterUserDetailProtocol?
    lazy var customView = view as? UserDetailView
}

extension UserDetailViewController: PresenterToViewUserDetailProtocol {
    func favButtonShow(isFav: Bool) {
        navigationItem.setRightBarButton(UIBarButtonItem(image: isFav ? .remove : .add, style: .plain, target: self, action: isFav ? #selector(removeFavorite) : #selector(addFavorite)), animated: true)        
    }
    
    func setupUI(with user: User) {
        overrideUserInterfaceStyle = .light
        DispatchQueue.main.async {
            self.title = user.name
            self.customView?.nameValue.text = user.name
            self.customView?.usernameValue.text = user.username
            self.customView?.emailValue.text = user.email
            self.customView?.addressValue.text = "\((user.address?.street)!), \((user.address?.city)!), \((user.address?.zipcode)!)"
            self.customView?.phoneValue.text = user.phone
            self.customView?.websiteValue.text = user.website
            self.customView?.companyValue.text = user.company?.name
        }
    }

    func showErrorMessage(_ message: String) {
        if isModal {
            self.displayErrorAlert(title: "", message: message)
        }
    }
    
    func showSuccessMessage(_ message: String) {
        if isModal {
            self.displaySuccessAlert(title: "", message: message)
        }
    }
    
    func setTableViewProvider(_ provider: TableViewProvider) {
        customView!.setTableViewProvider(provider)
        customView!.reloadDataInTableView()
    }

    func onFetchDataSuccess() {
        print("View receives the response from Presenter and updates itself.")
        customView!.reloadDataInTableView()
        customView!.refreshControl.endRefreshing()
    }
    
    func onFetchDataFailure(error: String) {
        print("View receives the response from Presenter with error: \(error)")
        customView!.refreshControl.endRefreshing()
        if isModal {
            self.displayErrorAlert(title: "", message: error)
        }
    }

    func reloadData() {
        customView!.reloadDataInTableView()
    }
}
