//
//  UsersListView.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import UIKit

class UsersListView: UIView {
    // MARK: Private properties
    private(set) var tableView: UITableView!
    private(set) var activity: UIActivityIndicatorView!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    private(set) var segmentedControl: UISegmentedControl!
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
        registerTableViewCells()
        setupActivity()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    private func setupUI() {
        segmentedControl = UISegmentedControl(frame: CGRect(x: 16, y: 5, width: UIScreen.main.bounds.size.width - 32, height: 30))
        segmentedControl.translatesAutoresizingMaskIntoConstraints = true
        //segmentedControl.layer.borderColor = UIColor.black.cgColor
        segmentedControl.backgroundColor = .orangeApp
        segmentedControl.layer.borderWidth = 0
        segmentedControl.tintColor = .white
        segmentedControl.selectedSegmentTintColor = .grayApp
        //segmentedControl.removeBorders()
        segmentedControl.replaceSegments(segments: ["Todos", "Favoritos"])
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,
                                                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,
                                                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        addSubview(segmentedControl)

        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.rowHeight = 70
//        tableView.contentInset.bottom = 44.0
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.isHidden = true
        tableView.contentInsetAdjustmentBehavior = .never
        
        let viex = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 200))
        tableView.tableFooterView = viex
        tableView.sectionHeaderHeight = 0
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0.01))
        
        addSubview(tableView)
        tableView.addSubview(refreshControl)

        NSLayoutConstraint(item: segmentedControl!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView!, attribute: .top, relatedBy: .equal, toItem: segmentedControl, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
        NSLayoutConstraint(item: tableView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        
        self.layoutIfNeeded()
    }
    
    private func registerTableViewCells() {
        tableView.register(UsersListCell.self)
        tableView.register(LoadingCell.self)
    }
    
    private func setupActivity() {
        activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activity.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
    }
    
    func isActivityLoading() -> Bool {
        return activity.isAnimating
    }
    
    func showActivity() {
        DispatchQueue.main.async(execute: {
            self.tableView.tableFooterView = self.activity
            self.activity.startAnimating()
        })
    }
    
    func stopActivity() {
        if self.activity.isAnimating {
            self.activity.stopAnimating()
        }
    }
}

// MARK: Public methods
extension UsersListView {
    func reloadDataInTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setTableViewProvider(_ provider: TableViewProvider) {
        tableView.delegate = provider
        tableView.dataSource = provider
    }
}
