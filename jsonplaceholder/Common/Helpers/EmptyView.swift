//
//  EmptyView.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    // MARK: - View Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    // MARK: - Methods
    func initializeSubviews() {
        let view = Bundle.main.loadNibNamed(EmptyView.reuseIdentifier, owner: self, options: nil)?[0] as? UIView
        self.addSubview(view!)
        view!.frame = self.bounds
    }
}
