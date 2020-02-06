//
//  UserDetailContract.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewUserDetailProtocol {
    func setTableViewProvider(_ provider: TableViewProvider)
    func reloadData()
    func onFetchDataSuccess()
    func onFetchDataFailure(error: String)
    func showErrorMessage(_ message: String)
    func setupUI(with user: User)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterUserDetailProtocol {
    var view: PresenterToViewUserDetailProtocol? { get set }
    var interactor: PresenterToInteractorUserDetailProtocol? { get set }
    var router: PresenterToRouterUserDetailProtocol? { get set }
    
    func viewDidLoad()
    func refresh()
    func didSelectRowAt(index: Int)
    func setContentTableViewProvider()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorUserDetailProtocol {
    var presenter: InteractorToPresenterUserDetailProtocol? { get set }
    func loadData()
    func retrieveAlbum(at index: Int)
    func cancel()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterUserDetailProtocol {
    func fetchDataSuccess(data: Albums)
    func fetchDataFailure(errorCode: Error)
    func getDataSuccess(_ data: Album)
    func getDataFailure()
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterUserDetailProtocol {
    static func createModule(with data: User) -> UIViewController
    func pushToAlbumDetail(on view: PresenterToViewUserDetailProtocol, with data: Album)
}
