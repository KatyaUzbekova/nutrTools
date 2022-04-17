//
//  UserProfileInteractor.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 06.04.2021.
//

import Foundation


class UserProfileInteractor: UserProfileInteractorProtocol {
    weak var presenter: UserProfilePresenterProtocol!
    
    required init(presenter: UserProfilePresenterProtocol) {
        self.presenter = presenter
        setupData()
    }
    
    var backPhotoImage: String {
        get {
            ""
        }
        set {
            print(newValue)
        }
    }
    
    var userDB: String {
        get {
            ""
        }
        set {
            presenter.setupDB(with:newValue)
        }
    }
    
    var userName: String {
        get {
            ""
        }
        set {
            presenter.setupName(with:newValue)
        }
    }
    
    var userEmail: String {
        get {
            ""
        }
        set {
            presenter.setupEmail(with:newValue)
        }
    }
    
    var userCoins: String {
        get {
            ""
        }
        set {
            presenter.setupCoins(with:newValue)
        }
    }
    
    var userMaleAvatar: String? {
        get {
            nil
        }
        set {
            presenter.setupAvatar(isMale: true, link: newValue)
        }
    }
    
    var userFemaleAvatar: String? {
        get {
            nil
        }
        set {
            presenter.setupAvatar(isMale: false, link: newValue)
        }
    }
        
    func setupData() {
        ApiService.shared.getAllUserInfoJsonMain { data, _ in
            if data != nil {
                UserDefaults.standard.set(data!.male, forKey: "isMale")
                let nameString = NSLocalizedString("UserProfilePresenter.Label.NameLogo", comment: "Greetings to user")
                let name = data!.name
                let greetingsString = String.localizedStringWithFormat(nameString, name)
                
                self.userName = greetingsString
                self.userEmail = data!.email
                self.userCoins = "\(data!.coins)"

                if data!.male {
                    self.userMaleAvatar = data!.avatarUrl
                }
                else {
                    self.userFemaleAvatar = data!.avatarUrl
                }
                self.userDB = data!.birthDate
            }
        }
    }
}
