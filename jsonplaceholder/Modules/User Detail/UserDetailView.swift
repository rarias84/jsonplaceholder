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
        nameLabel.font = .boldSystemFont(ofSize: 14)
        nameValue = UILabel(frame: .zero)
        nameValue.font = .systemFont(ofSize: 12)
        
        usernameLabel = UILabel(frame: .zero)
        usernameLabel.font = .boldSystemFont(ofSize: 14)
        usernameValue = UILabel(frame: .zero)
        usernameValue.font = .systemFont(ofSize: 12)
        
        emailLabel = UILabel(frame: .zero)
        emailLabel.font = .boldSystemFont(ofSize: 14)
        emailValue = UILabel(frame: .zero)
        emailValue.font = .systemFont(ofSize: 12)
        
        addressLabel = UILabel(frame: .zero)
        addressLabel.font = .boldSystemFont(ofSize: 14)
        addressValue = UILabel(frame: .zero)
        addressValue.font = .systemFont(ofSize: 12)
        
        phoneLabel = UILabel(frame: .zero)
        phoneLabel.font = .boldSystemFont(ofSize: 14)
        phoneValue = UILabel(frame: .zero)
        phoneValue.font = .systemFont(ofSize: 12)
        
        websiteLabel = UILabel(frame: .zero)
        websiteLabel.font = .boldSystemFont(ofSize: 14)
        websiteValue = UILabel(frame: .zero)
        websiteValue.font = .systemFont(ofSize: 12)
        
        companyLabel = UILabel(frame: .zero)
        companyLabel.font = .boldSystemFont(ofSize: 14)
        companyValue = UILabel(frame: .zero)
        companyValue.font = .systemFont(ofSize: 12)
        
        nameLabel.text = "Name:"
        usernameLabel.text = "Username:"
        emailLabel.text = "Email:"
        addressLabel.text = "Address:"
        phoneLabel.text = "Phone:"
        websiteLabel.text = "Website:"
        companyLabel.text = "Company:"
        
        let nameView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        nameView.axis = .vertical
        nameView.distribution = .fillEqually
        nameView.alignment = .fill
        nameView.spacing = 0
        nameView.addArrangedSubview(nameLabel)
        nameView.addArrangedSubview(nameValue)
        self.addSubview(nameView)
        
        let usernameView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        usernameView.axis = .vertical
        usernameView.distribution = .fillEqually
        usernameView.alignment = .fill
        usernameView.spacing = 0
        usernameView.addArrangedSubview(usernameLabel)
        usernameView.addArrangedSubview(usernameValue)
        self.addSubview(usernameView)
        
        let emailView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        emailView.axis = .vertical
        emailView.distribution = .fillEqually
        emailView.alignment = .fill
        emailView.spacing = 0
        emailView.addArrangedSubview(emailLabel)
        emailView.addArrangedSubview(emailValue)
        self.addSubview(emailView)
        
        let addressView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        addressView.axis = .vertical
        addressView.distribution = .fillEqually
        addressView.alignment = .fill
        addressView.spacing = 0
        addressView.addArrangedSubview(addressLabel)
        addressView.addArrangedSubview(addressValue)
        self.addSubview(addressView)
        
        let phoneView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        phoneView.axis = .vertical
        phoneView.distribution = .fillEqually
        phoneView.alignment = .fill
        phoneView.spacing = 0
        phoneView.addArrangedSubview(phoneLabel)
        phoneView.addArrangedSubview(phoneValue)
        self.addSubview(phoneView)
        
        let websiteView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        websiteView.axis = .vertical
        websiteView.distribution = .fillEqually
        websiteView.alignment = .fill
        websiteView.spacing = 0
        websiteView.addArrangedSubview(websiteLabel)
        websiteView.addArrangedSubview(websiteValue)
        self.addSubview(websiteView)
        
        let companyView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        companyView.axis = .vertical
        companyView.distribution = .fillEqually
        companyView.alignment = .fill
        companyView.spacing = 0
        companyView.addArrangedSubview(companyLabel)
        companyView.addArrangedSubview(companyValue)
        self.addSubview(companyView)
        
        let containerView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width,
                                                      height: nameView.frame.height + usernameView.frame.height + emailView.frame.height + addressView.frame.height + phoneView.frame.height + websiteView.frame.height + companyView.frame.height + 20))
        
        let albumLabel = UILabel(frame: .zero)
        albumLabel.text = "Albums"
        albumLabel.textAlignment = .center
        albumLabel.font = .boldSystemFont(ofSize: 16)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.axis = .vertical
        containerView.distribution = .fillEqually
        containerView.alignment = .fill
        containerView.spacing = 5
        containerView.addArrangedSubview(nameView)
        containerView.addArrangedSubview(usernameView)
        containerView.addArrangedSubview(emailView)
        containerView.addArrangedSubview(addressView)
        containerView.addArrangedSubview(phoneView)
        containerView.addArrangedSubview(websiteView)
        containerView.addArrangedSubview(companyView)
        containerView.addArrangedSubview(albumLabel)
        self.addSubview(containerView)


        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
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

        NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: tableView!, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
        NSLayoutConstraint(item: tableView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        
        self.layoutIfNeeded()
    }
    
    private func registerTableViewCells() {
        tableView.register(LoadingCell.self)
    }
    
    private func setupActivity() {
        activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activity.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
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
