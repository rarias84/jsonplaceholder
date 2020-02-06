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
    
    func loadData() {
        print("Interactor receives the request from Presenter to load data from the server.")
        self.cancellable = AlbumServices.getAlbums()
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
                //UserDefaults.standard.save(customObject: value, inKey: UserDefaultsKeys.usersData.rawValue)
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
}

