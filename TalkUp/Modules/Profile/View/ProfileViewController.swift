//
//  ProfileViewController.swift
//  Super easy dev
//
//  Created by Elmira Qurbanova on 29.04.25
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
}

class ProfileViewController: UIViewController {
    // MARK: - Public
    var presenter: ProfilePresenterProtocol?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - Private functions
private extension ProfileViewController {
    func initialize() {
    }
}

// MARK: - ProfileViewProtocol
extension ProfileViewController: ProfileViewProtocol {
}
