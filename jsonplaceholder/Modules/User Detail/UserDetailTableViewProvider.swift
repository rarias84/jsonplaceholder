//
//  UserDetailTableViewProvider.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 06-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation
import UIKit

class UserDetailTableViewProvider: NSObject, TableViewProvider {
    // MARK: Properties
    var albums = [Album]()

    var didSelectItem: ((_ atItem: Album) -> Void)?

    // MARK: UITableViewDatasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.showEmptyView(show: albums.isEmpty ? true : false)
        return albums.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "AlbumsCell")
        if !albums.isEmpty {
            let data = albums[indexPath.row]
            cell.textLabel?.text = data.title?.capitalized
            cell.textLabel?.font = .boldSystemFont(ofSize: 12)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if albums.indices.contains(indexPath.row) {
            let data = albums[indexPath.row]
            self.didSelectItem!(data)
        }
    }
}
