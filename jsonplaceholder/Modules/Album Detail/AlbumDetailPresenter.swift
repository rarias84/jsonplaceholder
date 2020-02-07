//
//  AlbumDetailPresenter.swift
//  jsonplaceholder
//
//  Created by Reinaldo Arias on 05-02-20.
//  Copyright © 2020 Reinaldo Arias. All rights reserved.
//

import Foundation
import UIKit

class AlbumDetailPresenter: ViewToPresenterAlbumDetailProtocol {
    // MARK: Properties
    var view: PresenterToViewAlbumDetailProtocol?
    var interactor: PresenterToInteractorAlbumDetailProtocol?
    var router: PresenterToRouterAlbumDetailProtocol?
    
    private var album: Album
    init(with album: Album) {
        self.album = album
    }
    
    func viewDidLoad() {
        print("Presenter is being notified that the View was loaded.")
        getData()
    }
    
    func getData() {
        interactor?.loadData(with: "\((self.album.id)!)")
    }
}

extension AlbumDetailPresenter: InteractorToPresenterAlbumDetailProtocol {
    func fetchDataSuccess(data: Photo) {
        print("Presenter receives the result from Interactor after it's done its job.")
        view?.updateUI(with: data)
    }
    
    func fetchDataFailure(errorCode: Error) {
        print("Presenter receives the result from Interactor after it's done its job.")
        view?.showErrorMessage("Couldn't fetch data: \(errorCode)")
    }
}

