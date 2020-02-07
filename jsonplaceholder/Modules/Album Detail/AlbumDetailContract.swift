//
//  AlbumDetailContract.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewAlbumDetailProtocol {
    func updateUI(with data: Photo)
    func showErrorMessage(_ message: String)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterAlbumDetailProtocol {
    var view: PresenterToViewAlbumDetailProtocol? { get set }
    var interactor: PresenterToInteractorAlbumDetailProtocol? { get set }
    var router: PresenterToRouterAlbumDetailProtocol? { get set }
    
    func viewDidLoad()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorAlbumDetailProtocol {
    var presenter: InteractorToPresenterAlbumDetailProtocol? { get set }
    func loadData(with id: String)
    func cancel()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterAlbumDetailProtocol {
    func fetchDataSuccess(data: Photo)
    func fetchDataFailure(errorCode: Error)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterAlbumDetailProtocol {
    static func createModule(with data: Album) -> UIViewController
}
