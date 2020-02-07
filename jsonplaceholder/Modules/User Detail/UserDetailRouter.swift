//
//  UserDetailRouter.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation
import UIKit

class UserDetailRouter: PresenterToRouterUserDetailProtocol {
    // MARK: Static methods
    static func createModule(with data: User) -> UIViewController {
        let viewController = UserDetailViewController()
        let presenter: ViewToPresenterUserDetailProtocol & InteractorToPresenterUserDetailProtocol = UserDetailPresenter(with: data)
        
        viewController.presenter = presenter
        viewController.presenter?.router = UserDetailRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = UserDetailInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func pushToAlbumDetail(on view: PresenterToViewUserDetailProtocol, with data: Album) {
        let albumDetailViewController = AlbumDetailRouter.createModule(with: data)
        let viewController = view as! UserDetailViewController
        viewController.navigationController?.pushViewController(albumDetailViewController, animated: true)
    }
}
