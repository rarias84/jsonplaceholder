//
//  AlbumDetailView.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 07-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import UIKit

class AlbumDetailView: UIView {
    // MARK: Private properties
    private(set) var titleLabel: UILabel!
    private(set) var thumbnail: UIImageView!
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    private func setupUI() {
        titleLabel = UILabel(frame: .zero)
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        thumbnail = UIImageView(frame: .zero)
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        addSubview(thumbnail)

        NSLayoutConstraint(item: titleLabel!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: titleLabel!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: titleLabel!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: thumbnail!, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
        NSLayoutConstraint(item: thumbnail!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: thumbnail!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        
        self.layoutIfNeeded()
    }
}
