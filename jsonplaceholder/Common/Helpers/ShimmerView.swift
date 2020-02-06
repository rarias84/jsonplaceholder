//
//  ShimmerView.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import UIKit

class ShimmerView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAndStartShimmering()
    }
}
