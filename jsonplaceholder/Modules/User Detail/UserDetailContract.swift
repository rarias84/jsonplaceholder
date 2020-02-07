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
    func showSuccessMessage(_ message: String)
    func setupUI(with user: User)
    func favButtonShow(isFav: Bool)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterUserDetailProtocol {
    var view: PresenterToViewUserDetailProtocol? { get set }
    var interactor: PresenterToInteractorUserDetailProtocol? { get set }
    var router: PresenterToRouterUserDetailProtocol? { get set }
    
    func viewDidLoad()
    func refresh()
    func addFavorite()
    func removeFavorite()
    func didSelectRowAt(index: Int)
    func setContentTableViewProvider()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorUserDetailProtocol {
    var presenter: InteractorToPresenterUserDetailProtocol? { get set }
    func loadData(with userId: String)
    func retrieveAlbum(at index: Int)
    func addFavorite(at user: User)
    func removeFavorite(at user: User)
    func cancel()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterUserDetailProtocol {
    func fetchDataSuccess(data: Albums)
    func fetchDataFailure(errorCode: Error)
    func getDataSuccess(_ data: Album)
    func getDataFailure()
    func favAddedSuccess(with user: User)
    func favAddedFailure()
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterUserDetailProtocol {
    static func createModule(with data: User) -> UIViewController
    func pushToAlbumDetail(on view: PresenterToViewUserDetailProtocol, with data: Album)
}
