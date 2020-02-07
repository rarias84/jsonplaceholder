//
//  UsersListContract.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewUsersListProtocol {
    func setTableViewProvider(_ provider: TableViewProvider)
    func reloadData()
    func onFetchDataSuccess()
    func onFetchDataFailure(error: String)
    func showErrorMessage(_ message: String)
    func updateSegmentedControl(index: Int)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterUsersListProtocol {
    var view: PresenterToViewUsersListProtocol? { get set }
    var interactor: PresenterToInteractorUsersListProtocol? { get set }
    var router: PresenterToRouterUsersListProtocol? { get set }
    
    func viewDidLoad()
    func refresh()
    func didSelectRowAt(index: Int)
    func setContentTableViewProvider()
    func changeControlSelection(_ sender: UISegmentedControl)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorUsersListProtocol {
    var presenter: InteractorToPresenterUsersListProtocol? { get set }
    func loadUsers(isRefreshing: Bool)
    func loadFavUsers()
    func retrieveUser(at index: Int)
    func cancel()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterUsersListProtocol {
    func fetchDataSuccess(data: Users)
    func fetchDataFailure(errorCode: Error)
    func getDataSuccess(_ data: User)
    func getDataFailure()
    func getFavDataFailure()
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterUsersListProtocol {
    static func createModule() -> UIViewController
    func pushToDetail(on view: PresenterToViewUsersListProtocol, with data: User)
}
