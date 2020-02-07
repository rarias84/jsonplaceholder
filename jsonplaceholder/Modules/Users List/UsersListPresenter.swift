//
//  UsersListPresenter.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation
import UIKit

class UsersListPresenter: ViewToPresenterUsersListProtocol {
    // MARK: Properties
    var view: PresenterToViewUsersListProtocol?
    var interactor: PresenterToInteractorUsersListProtocol?
    var router: PresenterToRouterUsersListProtocol?
    private var currentOpt = 0
    
    let loadingTableViewProvider = LoadingTableView()
    
    lazy var contentTableViewProvider: UsersListTableViewProvider = {
        let tableViewProvider = UsersListTableViewProvider()
        tableViewProvider.didSelectItem = { [unowned self] (atItem: User) in
            self.router?.pushToDetail(on: self.view!, with: atItem)
        }
        return tableViewProvider
    }()

    func viewDidLoad() {
        print("Presenter is being notified that the View was loaded.")
        getData(refresh: true)
    }
    
    func refresh() {
        print("Presenter is being notified that the View was refreshed.")
        switch currentOpt {
        case 1: getFavData()
        default: getData(refresh: true)
        }
    }

    func getData(refresh: Bool) {
        removeContentDataInView()
        setLoadingTableView()
        interactor?.loadUsers(isRefreshing: refresh)
    }
    
    func getFavData() {
        removeContentDataInView()
        setLoadingTableView()
        interactor?.loadFavUsers()
    }
    
    func removeContentDataInView() {
        interactor?.cancel()
        contentTableViewProvider.users.removeAll()
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
        interactor?.retrieveUser(at: index)
    }
    
    func changeControlSelection(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: if currentOpt != 0 { currentOpt = 0 }; getData(refresh: false)
        case 1: if currentOpt != 1 { currentOpt = 1 }; getFavData()
        default: currentOpt = 0; getData(refresh: false)
        }
    }
}

extension UsersListPresenter: InteractorToPresenterUsersListProtocol {
    func fetchDataSuccess(data: Users) {
        print("Presenter receives the result from Interactor after it's done its job.")
        setContentTableView()
        contentTableViewProvider.users = data
        view?.onFetchDataSuccess()
    }
    
    func fetchDataFailure(errorCode: Error) {
        print("Presenter receives the result from Interactor after it's done its job.")
        setContentTableView()
        view?.onFetchDataFailure(error: "Couldn't fetch data: \(errorCode)")
    }
    
    func getDataSuccess(_ data: User) {
        router?.pushToDetail(on: view!, with: data)
    }    
    
    func getDataFailure() {
        print("Couldn't retrieve data")
        view?.showErrorMessage("Error al obtener la información.")
    }
    
    func getFavDataFailure() {
        print("Empty data")
        removeContentDataInView()
        setContentTableView()
    }
}
