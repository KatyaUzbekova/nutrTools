//
//  ParticularChatConfigurator.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 24.05.2021.
//

import Foundation


protocol ParticularChatConfiguratorProtocol {
    func configure(with viewController: ParticularChatViewController)
}


class ParticularChatConfigurator: ParticularChatConfiguratorProtocol {
        func configure(with viewController: ParticularChatViewController) {
            let presenter = ParticularChatPresenter(view: viewController)
            viewController.presenter = presenter
        }
}


