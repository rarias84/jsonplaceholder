//
//  AlbumDetailRouter.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation
import UIKit

class AlbumDetailRouter: PresenterToRouterAlbumDetailProtocol {
    // MARK: Static methods
    static func createModule(with data: Album) -> UIViewController {
        let viewController = AlbumDetailViewController()
        let presenter: ViewToPresenterAlbumDetailProtocol & InteractorToPresenterAlbumDetailProtocol = AlbumDetailPresenter(with: data)
        
        viewController.presenter = presenter
        viewController.presenter?.router = AlbumDetailRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = AlbumDetailInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
}
