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
        guard let data = UserDefaults.standard.retrieve(object: Users.self, fromKey: UserDefaultsKeys.usersFav.rawValue), !data.isEmpty else {
            self.view?.favButtonShow(isFav: false)
            return
        }
        let dataUser = data.filter({ (usr) -> Bool in
            return usr.id == user.id
        })
        self.view?.favButtonShow(isFav: dataUser.first?.isFavorite == nil ? false : (dataUser.first?.isFavorite)!)
    }
    
    func refresh() {
        print("Presenter is being notified that the View was refreshed.")
        removeContentDataInView()
        getData()
    }
    
    func addFavorite() {
        self.interactor?.addFavorite(at: user)
    }
    
    func removeFavorite() {
        self.interactor?.removeFavorite(at: user)
    }

    func getData() {
        removeContentDataInView()
        setLoadingTableView()
        interactor?.loadData(with: "\((self.user.id)!)")
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
    
    func favAddedSuccess(with user: User) {
        view?.showSuccessMessage("Favorito guardado/eliminado exitosamente.")
        self.user = user
        print(user)
        self.view?.favButtonShow(isFav: user.isFavorite == nil ? false : (user.isFavorite)!)
//        DispatchQueue.main.async {
//            guard let data = UserDefaults.standard.retrieve(object: Users.self, fromKey: UserDefaultsKeys.usersFav.rawValue), !data.isEmpty else {
//                self.view?.favButtonShow(isFav: false)
//                return
//            }
//            let dataUser = data.filter({ (usr) -> Bool in
//                return usr.id == user.id
//            })
//            self.view?.favButtonShow(isFav: dataUser.first?.isFavorite == nil ? false : (dataUser.first?.isFavorite)!)
//        }
    }
    
    func favAddedFailure() {
        view?.showErrorMessage("Error guardar/eliminar favorito.")
    }
}
