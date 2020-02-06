//
//  UsersListRouter.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation
import UIKit

class UsersListRouter: PresenterToRouterUsersListProtocol {
    // MARK: Static methods
    static func createModule() -> UIViewController {
        let viewController = UsersListViewController()
        let presenter: ViewToPresenterUsersListProtocol & InteractorToPresenterUsersListProtocol = UsersListPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = UsersListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = UsersListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func pushToDetail(on view: PresenterToViewUsersListProtocol, with data: User) {
//        let userDetailViewController = UsersDetailViewController(data)
        let userDetailViewController = UserDetailRouter.createModule(with: data)
        let viewController = view as! UsersListViewController
        viewController.navigationController?.pushViewController(userDetailViewController, animated: true)
    }
}
