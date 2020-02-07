//
//  AlbumDetailInteractor.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation
import Combine

class AlbumDetailInteractor: PresenterToInteractorAlbumDetailProtocol {
    // MARK: Properties
    var presenter: InteractorToPresenterAlbumDetailProtocol?
    private var cancellable: AnyCancellable?
    
    func loadData(with id: String) {
        print("Interactor receives the request from Presenter to load data from the server.")
        self.cancellable = AlbumServices.getPhotos(with: id)
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
                self.presenter?.fetchDataSuccess(data: value.first!)
        })
        withExtendedLifetime(self.cancellable, {})
    }
    
    func cancel() {
        self.cancellable?.cancel()
    }
}
