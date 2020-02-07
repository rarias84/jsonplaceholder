//
//  UsersListInteractor.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation
import Combine

class UsersListInteractor: PresenterToInteractorUsersListProtocol {
    // MARK: Properties
    var presenter: InteractorToPresenterUsersListProtocol?
    private var cancellable: AnyCancellable?
    var data: Users?
    
    func loadUsers(isRefreshing: Bool) {
        if isRefreshing {
            loadFromServer()
        } else {
            guard let data = UserDefaults.standard.retrieve(object: Users.self, fromKey: UserDefaultsKeys.usersData.rawValue), !data.isEmpty else {
                loadFromServer()
                return
            }
            self.presenter?.fetchDataSuccess(data: data)
        }
    }
    
    private func loadFromServer() {
        print("Interactor receives the request from Presenter to load data from the server.")
        self.cancellable = UserServices.getUsers()
        .print()
        .sink(receiveCompletion: { [weak self] completion in
            guard let self = self else { return }
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self.presenter?.fetchDataFailure(errorCode: error)
            }
        },
              receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.data = value
                DispatchQueue.main.async {
                    UserDefaults.standard.save(customObject: value, inKey: UserDefaultsKeys.usersData.rawValue) { (_) in }
                }
                self.presenter?.fetchDataSuccess(data: value)
        })
        withExtendedLifetime(self.cancellable, {})
    }
    
    //TODO: - refrescar lista de fav al actualizar estado
    func loadFavUsers() {
        guard let data = UserDefaults.standard.retrieve(object: Users.self, fromKey: UserDefaultsKeys.usersFav.rawValue), !data.isEmpty else {
            self.presenter?.getFavDataFailure()
            return
        }
        self.presenter?.fetchDataSuccess(data: data)        
    }
    
    func retrieveUser(at index: Int) {
        guard let data = self.data, data.indices.contains(index) else {
            self.presenter?.getDataFailure()
            return
        }
        self.presenter?.getDataSuccess(self.data![index])
    }
    
    func cancel() {
        self.cancellable?.cancel()
    }
}
