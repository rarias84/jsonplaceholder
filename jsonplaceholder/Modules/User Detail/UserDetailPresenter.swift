//
//  UserDetailPresenter.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation
import UIKit

class UserDetailPresenter: ViewToPresenterUserDetailProtocol {
    // MARK: Properties
    var view: PresenterToViewUserDetailProtocol?
    var interactor: PresenterToInteractorUserDetailProtocol?
    var router: PresenterToRouterUserDetailProtocol?
    private var currentOpt = 0
    
    let loadingTableViewProvider = LoadingTableView()
    
    lazy var contentTableViewProvider: UserDetailTableViewProvider = {
        let tableViewProvider = UserDetailTableViewProvider()
        tableViewProvider.didSelectItem = { [unowned self] (atItem: Album) in
            self.router?.pushToAlbumDetail(on: self.view!, with: atItem)
        }
        return tableViewProvider
    }()

    private var user: User
    init(with user: User) {
        self.user = user
    }
    
    func viewDidLoad() {
        print("Presenter is being notified that the View was loaded.")
        view?.setupUI(with: self.user)
        getData()
    }
    
    func refresh() {
        print("Presenter is being notified that the View was refreshed.")
        removeContentDataInView()
        getData()
    }

    func getData() {
        removeContentDataInView()
        setLoadingTableView()
        interactor?.loadData()
    }
    
    func removeContentDataInView() {
        interactor?.cancel()
        contentTableViewProvider.albums.removeAll()
        view?.reloadData()
    }
    
    func setLoadingTableView() {
        view?.setTableViewProvider(loadingTableViewProvider)
    }
    
    func setContentTableView() {
        view?.setTableViewProvider(contentTableViewProvider)
    }
    
    func setContentTableViewProvider() {
        setContentTableView()
    }
    
    func didSelectRowAt(index: Int) {
        interactor?.retrieveAlbum(at: index)
    }
}

extension UserDetailPresenter: InteractorToPresenterUserDetailProtocol {
    func fetchDataSuccess(data: Albums) {
        print("Presenter receives the result from Interactor after it's done its job.")
        setContentTableView()
        contentTableViewProvider.albums = data
        view?.onFetchDataSuccess()
    }
    
    func fetchDataFailure(errorCode: Error) {
        print("Presenter receives the result from Interactor after it's done its job.")
        setContentTableView()
        view?.onFetchDataFailure(error: "Couldn't fetch data: \(errorCode)")
    }
    
    func getDataSuccess(_ data: Album) {
        router?.pushToAlbumDetail(on: view!, with: data)
    }
    
    func getDataFailure() {
        print("Couldn't retrieve data")
        view?.showErrorMessage("Error al obtener la información.")
    }
}
