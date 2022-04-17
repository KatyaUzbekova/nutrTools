//
//  FDMStompManager.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 10.05.2021.
//

import Foundation
import SwiftStomp
import StompClientLib
import SwiftKeychainWrapper
import RxSwift

class FDMStompManager {
    private let token = KeychainWrapper.standard.string(forKey: "accessToken")!
    var socket: StompClientLib? = nil
    var roomId: CLong!
    static let shared = FDMStompManager()
    private var timer:Timer = Timer()
    
    var stompUrl: String = "wss://nutrtools.info:8443/wschat/websocket/"
   // var localStomp = "ws://10.242.26.111:8080/wschat/websocket"

    lazy var header = ["token": token, "heart-beat": "5000,60000"]

    /*
     Подписываемся на эндпоинт, который отвечает за подключение к чату. Нужно вызывать каждый раз при входе в конкретный чат. Однократно
    */

    
    func initConnection(withRoomId roomId: CLong) {
        let url = URL(string: stompUrl)!
        var request = URLRequest(url: url)
        request.setValue(token, forHTTPHeaderField: "access-token")
        request.setValue("5000,60000", forHTTPHeaderField: "heart-beat")

        socket = StompClientLib.init()
        self.roomId = roomId
        socket?.openSocketWithURLRequest(request: request as NSURLRequest, delegate: self, connectionHeaders: header)
    }
    
    func subscribeToChatConnection() {
        let chatConnectionPoint = "/chat/connect"
        socket?.subscribe(destination: chatConnectionPoint)
    }
    
    func connectToRoom() {
        let sendMessagePoint = "/app/chat/connect"
        let fullMessage = MessageBySockets(token: token, chatId: roomId, message: nil, messageType: MessageType.USER_JOIN, messageId: nil).nsDictionary
        sendEncodedMessage(fullMessage: fullMessage, sendMessagePoint: sendMessagePoint)
    }
    

    func reconnectStomp() {
        socket?.openSocketWithURLRequest(request: NSURLRequest(url: URL(string: stompUrl)!), delegate: self, connectionHeaders: header)
    }

    func stompDisconnect() {
        socket?.disconnect()
    }

    func sendMessageRead(with messageId: CLong) {
        let sendMessagePoint = "/app/chat/room/\(roomId!)"
        let fullMessage = MessageBySockets(token: token, chatId: roomId, message: nil, messageType: MessageType.MESSAGE_READ, messageId: messageId).nsDictionary
        sendEncodedMessage(fullMessage: fullMessage, sendMessagePoint: sendMessagePoint)
    }
    
    func sendEncodedMessage(fullMessage: NSDictionary, sendMessagePoint: String) {
        do {
            let theJSONData = try JSONSerialization.data(withJSONObject: fullMessage, options: JSONSerialization.WritingOptions())
            let theJSONText = String(data: theJSONData, encoding: String.Encoding.utf8)
            socket?.sendMessage(message: theJSONText!, toDestination: sendMessagePoint, withHeaders: [:], withReceipt: nil)
        }
        catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func sendTyping() {
        let sendMessagePoint = "/app/chat/room/\(roomId!)"
        let fullMessage = MessageBySockets(token: token, chatId: roomId, message: nil, messageType: MessageType.TYPING, messageId: nil).nsDictionary
        sendEncodedMessage(fullMessage: fullMessage, sendMessagePoint: sendMessagePoint)
    }
    
    func subscribeToChatMessages() {
        let subscribeMessagePoint = "/user/queue/messages"
        socket?.subscribe(destination: subscribeMessagePoint)
    }
    

    func sendMessage(text message: String) {
        let sendMessagePoint = "/app/chat/room/\(roomId!)"
        let fullMessage = MessageBySockets(token: token, chatId: roomId, message: message, messageType: MessageType.TEXT, messageId: nil).nsDictionary
        sendEncodedMessage(fullMessage: fullMessage, sendMessagePoint: sendMessagePoint)
    }
    
    @objc func sendHeartBeat() {
        if socket!.isConnected() {
            socket?.sendMessage(message: "Ping from IOS", toDestination: "", withHeaders: [:], withReceipt: nil)
        }
        else {
            initConnection(withRoomId: roomId)
        }
    }
    func disconnectSocket() {
        timer.invalidate()
    }
}


//MARK: delegate for socket
extension FDMStompManager: StompClientLibDelegate {
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("Connect: \(destination)")
        print("Connect: \(jsonBody)")
    }

    func stompClientDidDisconnect(client: StompClientLib!) {
        print("disconnect")
    }

    func stompClientDidConnect(client: StompClientLib!) {
        print("STOMP CLIENT IS CONNECTED")
        self.timer = Timer.scheduledTimer(timeInterval: 50, target: self, selector: #selector(self.sendHeartBeat), userInfo: nil, repeats: true)
        connectToRoom()
    }

    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
    }

    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
    }

    func serverDidSendPing() {
        print("Server ping")
    }
}
