//
//  LoadingCell.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {
    @IBOutlet weak var titleView: ShimmerView!
    @IBOutlet weak var subtitleView: ShimmerView!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        titleView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20)
        subtitleView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20)
        titleView.backgroundColor = UIColor.grayApp.withAlphaComponent(0.3)
        subtitleView.backgroundColor = UIColor.grayApp.withAlphaComponent(0.3)
        titleView.layer.cornerRadius = 4
        subtitleView.layer.cornerRadius = 4
    }
}
