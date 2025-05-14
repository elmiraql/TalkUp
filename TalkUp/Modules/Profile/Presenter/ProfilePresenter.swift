//
//  ProfilePresenter.swift
//  Super easy dev
//
//  Created by Elmira Qurbanova on 29.04.25
//

protocol ProfilePresenterProtocol: AnyObject {
}

class ProfilePresenter {
    weak var view: ProfileViewProtocol?
    var router: ProfileRouterProtocol
    var interactor: ProfileInteractorProtocol

    init(interactor: ProfileInteractorProtocol, router: ProfileRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
}
