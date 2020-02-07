//
//  AlbumDetailViewController.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import UIKit
import Kingfisher

class AlbumDetailViewController: UIViewController, AlertDisplayer {
    
    // MARK: - Lifecycle Methods
    override func loadView() {
        view = AlbumDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        presenter?.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterAlbumDetailProtocol?
    lazy var customView = view as? AlbumDetailView
}

extension AlbumDetailViewController: PresenterToViewAlbumDetailProtocol {    
    func showErrorMessage(_ message: String) {
        if isModal {
            self.displayErrorAlert(title: "", message: message)
        }
    }
    
    func updateUI(with data: Photo) {
        print("View receives the response from Presenter and updates itself.")
         DispatchQueue.main.async {
            self.title = "Album"
            self.customView?.titleLabel.text = data.title
            self.customView?.thumbnail.kf.setImage(with: URL(string: data.url!))
        }
    }    
}
