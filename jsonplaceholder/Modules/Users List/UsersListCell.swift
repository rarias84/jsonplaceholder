//
//  UsersListCell.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import UIKit

class UsersListCell: UITableViewCell {
    // MARK: - IBOutlet
        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var usernameLabel: UILabel!
        // MARK: - Properties
        var data: User? {
            didSet {
                nameLabel.text = data?.name
                usernameLabel.text = data?.username
            }
        }
        // MARK: - View Lifecycle
        override func awakeFromNib() {
            super.awakeFromNib()
            self.selectionStyle = .none
        }

        override func prepareForReuse() {
            super.prepareForReuse()
            self.nameLabel.text   = ""
            self.usernameLabel.text  = ""
        }
    }
