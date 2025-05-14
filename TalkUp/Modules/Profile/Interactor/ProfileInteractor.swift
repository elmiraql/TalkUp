//
//  ProfileInteractor.swift
//  Super easy dev
//
//  Created by Elmira Qurbanova on 29.04.25
//

protocol ProfileInteractorProtocol: AnyObject {
}

class ProfileInteractor: ProfileInteractorProtocol {
    weak var presenter: ProfilePresenterProtocol?
}
