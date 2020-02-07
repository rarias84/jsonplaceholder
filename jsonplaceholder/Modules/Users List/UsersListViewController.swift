//
//  UsersListViewController.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController, AlertDisplayer {
    
    // MARK: - Lifecycle Methods
    override func loadView() {
        view = UsersListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    // MARK: - Actions
    @objc func refresh() {
        presenter?.refresh()
    }
    
    @objc func selectionDidChange(sender: UISegmentedControl) {
        presenter!.changeControlSelection(sender)
    }
    
    // MARK: - Properties
    var presenter: ViewToPresenterUsersListProtocol?
    lazy var customView = view as? UsersListView
}

extension UsersListViewController: PresenterToViewUsersListProtocol {
    func showErrorMessage(_ message: String) {
        if isModal {
            self.displayErrorAlert(title: "", message: message)
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
    
    func updateSegmentedControl(index: Int) {
        DispatchQueue.main.async {
            self.customView?.segmentedControl.selectedSegmentIndex = index
        }
    }
}

// MARK: - UI Setup
extension UsersListViewController {
    func setupUI() {
        overrideUserInterfaceStyle = .light
        title = "Users"
        customView?.segmentedControl.selectedSegmentIndex = 0
        customView?.segmentedControl.addTarget(self, action: #selector(selectionDidChange), for: .valueChanged) 
        customView?.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
}
