//
//  UserDetailView.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 06-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import UIKit

class UserDetailView: UIView {
    // MARK: Private properties
    private(set) var tableView: UITableView!
    private(set) var activity: UIActivityIndicatorView!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    private(set) var nameLabel: UILabel!
    private(set) var nameValue: UILabel!
    private(set) var usernameLabel: UILabel!
    private(set) var usernameValue: UILabel!
    private(set) var emailLabel: UILabel!
    private(set) var emailValue: UILabel!
    private(set) var addressLabel: UILabel!
    private(set) var addressValue: UILabel!
    private(set) var phoneLabel: UILabel!
    private(set) var phoneValue: UILabel!
    private(set) var websiteLabel: UILabel!
    private(set) var websiteValue: UILabel!
    private(set) var companyLabel: UILabel!
    private(set) var companyValue: UILabel!
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
        nameLabel = UILabel(frame: .zero)
        nameValue = UILabel(frame: .zero)
        usernameLabel = UILabel(frame: .zero)
        usernameValue = UILabel(frame: .zero)
        emailLabel = UILabel(frame: .zero)
        emailValue = UILabel(frame: .zero)
        addressLabel = UILabel(frame: .zero)
        addressValue = UILabel(frame: .zero)
        phoneLabel = UILabel(frame: .zero)
        phoneValue = UILabel(frame: .zero)
        websiteLabel = UILabel(frame: .zero)
        websiteValue = UILabel(frame: .zero)
        companyLabel = UILabel(frame: .zero)
        companyValue = UILabel(frame: .zero)
        
        nameLabel.text = "Name:"
        usernameLabel.text = "Username:"
        emailLabel.text = "Email:"
        addressLabel.text = "Address:"
        phoneLabel.text = "Phone:"
        websiteLabel.text = "Website:"
        companyLabel.text = "Company:"
        
        let nameView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        nameView.axis = .horizontal
        nameView.distribution = .fill
        nameView.alignment = .fill
        nameView.spacing = 5
        nameView.addArrangedSubview(nameLabel)
        nameView.addArrangedSubview(nameValue)
        self.addSubview(nameView)
        
        let usernameView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        usernameView.axis = .horizontal
        usernameView.distribution = .fill
        usernameView.alignment = .fill
        usernameView.spacing = 5
        usernameView.addArrangedSubview(usernameLabel)
        usernameView.addArrangedSubview(usernameValue)
        self.addSubview(usernameView)
        
        let emailView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        emailView.axis = .horizontal
        emailView.distribution = .fill
        emailView.alignment = .fill
        emailView.spacing = 5
        emailView.addArrangedSubview(emailLabel)
        emailView.addArrangedSubview(emailValue)
        self.addSubview(emailView)
        
        let addressView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        addressView.axis = .horizontal
        addressView.distribution = .fill
        addressView.alignment = .fill
        addressView.spacing = 5
        addressView.addArrangedSubview(addressLabel)
        addressView.addArrangedSubview(addressValue)
        self.addSubview(addressView)
        
        let phoneView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        phoneView.axis = .horizontal
        phoneView.distribution = .fill
        phoneView.alignment = .fill
        phoneView.spacing = 5
        phoneView.addArrangedSubview(phoneLabel)
        phoneView.addArrangedSubview(phoneValue)
        self.addSubview(phoneView)
        
        let websiteView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        websiteView.axis = .horizontal
        websiteView.distribution = .fill
        websiteView.alignment = .fill
        websiteView.spacing = 5
        websiteView.addArrangedSubview(websiteLabel)
        websiteView.addArrangedSubview(websiteValue)
        self.addSubview(websiteView)
        
        let companyView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        companyView.axis = .horizontal
        companyView.distribution = .fill
        companyView.alignment = .fill
        companyView.spacing = 5
        companyView.addArrangedSubview(companyLabel)
        companyView.addArrangedSubview(companyValue)
        self.addSubview(companyView)
        
        let containerView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width,
                                                      height: nameView.frame.height + usernameView.frame.height + emailView.frame.height + addressView.frame.height + phoneView.frame.height + websiteView.frame.height + companyView.frame.height))
        containerView.axis = .vertical
        containerView.distribution = .fill
        containerView.alignment = .fill
        containerView.spacing = 5
        containerView.addArrangedSubview(nameView)
        containerView.addArrangedSubview(usernameView)
        containerView.addArrangedSubview(emailView)
        containerView.addArrangedSubview(addressView)
        containerView.addArrangedSubview(phoneView)
        containerView.addArrangedSubview(websiteView)
        containerView.addArrangedSubview(companyView)
        self.addSubview(containerView)


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

        NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView!, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
        NSLayoutConstraint(item: tableView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        
        self.layoutIfNeeded()
    }
    
    private func registerTableViewCells() {
        //tableView.register(UITableViewCell.self)
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
extension UserDetailView {
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

