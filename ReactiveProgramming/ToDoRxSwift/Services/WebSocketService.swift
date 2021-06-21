//
//  WebSocketService.swift
//  ToDoRxSwift
//

import UIKit
import Starscream

extension Dictionary where Key == String, Value == Any {
    func prettyPrint() -> String {
        var string: String = ""
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted){
            if let nstr = NSString(data: data, encoding: String.Encoding.utf8.rawValue){
                string = nstr as String
            }
        }
        return string
    }
}

extension String {
    func fromJson() -> [String: Any] {
        do {
            let data = Data(self.utf8)
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? [String: Any]()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        return [String: Any]()
    }
}

struct WebSocketMessage {
    let action: String
    let data: String
    let routeKey: String
    
    var json:String{
        get{
            ["action":action,"data":data,"routeKey":routeKey].prettyPrint()
        }
    }
}

class WebSocketService: WebSocketDelegate {
    static let shared = WebSocketService()
    var socket: WebSocket?
    let routeKey: String = "1q2w3e4r"
    let webSocketQueue = DispatchQueue(label: "webSocketQueue", qos:.userInitiated)
    
    init() {
        connect()
    }
    
    func connect() {
        webSocketQueue.async { [weak self] in
            guard let _ = self else { return }
            let url = "wss://39dv7ire8c.execute-api.us-east-2.amazonaws.com/Prod/?routeKey=\(self!.routeKey)"
            var request = URLRequest(url: URL(string: url)!)
            request.timeoutInterval = 5
            self?.socket = WebSocket(request: request)
            self?.socket?.delegate = self
            self?.socket?.connect()
        }
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            recieveData(data: string)
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled: break
            
        case .error(let error):
            print("Received text: \(String(describing: error))")
            break
        }
    }
    
    func recieveData(data: String) {
        let json = data.fromJson()
        let id = UUID(uuidString: json["id"] as! String)!
        let completed = json["completed"]! as! Int != 0
        
        if TodoItemRepository.shared.itemExists(id: id) {
            TodoItemRepository.shared.changeCompleted(isCompleted: completed, id: id, notify: false)
        } else {
            TodoItemRepository.shared.addItem(title: json["title"] as! String, id: id, notify: false)
        }
        
    }
    
    func sendData(item: Item) {
        webSocketQueue.async { [weak self] in
            if let _ = self{
                self!.socket?.write(string: self!.sendDataPacket(item: item), completion: {
                })
            }
        }
    }
    
    func sendDataPacket(item: Item) -> String {
        let data = ["id": item.id.uuidString,
                    "title": item.title,
                    "completed": item.completed].prettyPrint()
        
        return WebSocketMessage(action: "sendmessage", data: "\(data)", routeKey: self.routeKey).json
    }
}
