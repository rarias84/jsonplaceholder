//
//  UserDetailInteractor.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation
import Combine

class UserDetailInteractor: PresenterToInteractorUserDetailProtocol {
    // MARK: Properties
    var presenter: InteractorToPresenterUserDetailProtocol?
    private var cancellable: AnyCancellable?
    var data: Albums?
    
    func loadData(with userId: String) {
        print("Interactor receives the request from Presenter to load data from the server.")
        self.cancellable = AlbumServices.getAlbums(with: userId)
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
                    UserDefaults.standard.save(customObject: value, inKey: UserDefaultsKeys.albumsData.rawValue) { (_) in }
                }
                self.presenter?.fetchDataSuccess(data: value)
        })
        withExtendedLifetime(self.cancellable, {})
    }
    
    func retrieveAlbum(at index: Int) {
        guard let data = self.data, data.indices.contains(index) else {
            self.presenter?.getDataFailure()
            return
        }
        self.presenter?.getDataSuccess(self.data![index])
    }
    
    func cancel() {
        self.cancellable?.cancel()
    }
    
    func addFavorite(at user: User) {
        let updatedUser = User(id: user.id!, name: user.name!, username: user.username!, email: user.name!, address: user.address!, phone: user.phone!, website: user.website!, company: user.company!, isFavorite: true)
        guard var data = UserDefaults.standard.retrieve(object: Users.self, fromKey: UserDefaultsKeys.usersFav.rawValue), !data.isEmpty else {
            UserDefaults.standard.save(customObject: [updatedUser], inKey: UserDefaultsKeys.usersFav.rawValue) { (success) in
                success ? self.presenter?.favAddedSuccess(with: updatedUser) : self.presenter?.favAddedFailure()
            }
            return
        }
        data.append(updatedUser)
        UserDefaults.standard.save(customObject: data, inKey: UserDefaultsKeys.usersFav.rawValue) { (success) in
            success ? self.presenter?.favAddedSuccess(with: updatedUser) : self.presenter?.favAddedFailure()
        }
    }
    
    func removeFavorite(at user: User) {
        let updatedUser = User(id: user.id!, name: user.name!, username: user.username!, email: user.name!, address: user.address!, phone: user.phone!, website: user.website!, company: user.company!, isFavorite: false)
        var data = UserDefaults.standard.retrieve(object: Users.self, fromKey: UserDefaultsKeys.usersFav.rawValue)

        if let index = data!.firstIndex(where: { $0.id == user.id }) {
            data?.remove(at: index)
        }
        
        UserDefaults.standard.save(customObject: data, inKey: UserDefaultsKeys.usersFav.rawValue) { (success) in
            success ? self.presenter?.favAddedSuccess(with: updatedUser) : self.presenter?.favAddedFailure()
        }
    }
}
