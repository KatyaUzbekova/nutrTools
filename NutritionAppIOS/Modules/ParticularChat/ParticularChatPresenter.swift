//
//  ParticularChatPresenter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 24.05.2021.
//

import Foundation
import RxSwift

protocol ParticularChatPresenterProtocol: class{
    func configureView(for roomId: CLong)
    func sendMessage(text message: String)
    func sendMessageRead(with messageId: CLong)
    func invalidateSocketConnection()
}

class ParticularChatPresenter:ParticularChatPresenterProtocol {

    func configureView(for roomId: CLong) {
        view.setupView()
        FDMStompManager.shared.initConnection(withRoomId: roomId)
        
    }
    
    func sendMessage(text message: String) {
        FDMStompManager.shared.sendMessage(text: message)
    }
    
    func invalidateSocketConnection() {
        FDMStompManager.shared.disconnectSocket()
    }
    func sendMessageRead(with messageId: CLong) {
        FDMStompManager.shared.sendMessageRead(with: messageId)
    }
    
    weak var view: ParticularChatViewControllerProtocol!
    
    required init(view: ParticularChatViewControllerProtocol) {
        self.view = view
    }
}
