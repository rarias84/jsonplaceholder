//
//  UsersListTableViewProvider.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation
import UIKit

class UsersListTableViewProvider: NSObject, TableViewProvider {
    // MARK: Properties
    var users = [User]()

    var didSelectItem: ((_ atItem: User) -> Void)?

    // MARK: UITableViewDatasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.showEmptyView(show: users.isEmpty ? true : false)
        return users.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersListCell.reuseIdentifier, for: indexPath) as? UsersListCell else {
            return UITableViewCell()
        }
        if !users.isEmpty {
            let data = users[indexPath.row]
            cell.data = data
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if users.indices.contains(indexPath.row) {
            let data = users[indexPath.row]
            self.didSelectItem!(data)
        }
    }
}
