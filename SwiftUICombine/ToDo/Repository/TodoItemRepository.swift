//
//  ItemService.swift
//  ToDo
//
//  Created by giora krasilshchik on 19/10/2020.
//

import Foundation
import Combine

class TodoItemRepository {
    
    static let shared = TodoItemRepository()
    

    @Published private (set) var items = [Item(id: UUID(uuidString: "e1741d12-db24-4c19-83ba-eb39c4691c10")!, title: "buy food"),
                                          Item(id: UUID(uuidString: "acb623ea-9723-42b9-a370-a701f367478a")!, title: "call doctor" ),
                                          Item(id: UUID(uuidString: "81db856b-ce74-4ad9-8a8f-13c1e7b7ad32")!, title: "prepare for oracle",completed: true )
    ]
    
    func addItem(title: String, id: UUID = UUID(), notify: Bool = true) {
        let newItem = Item(id: id, title: title)
        items.append(newItem)
        
        if notify {
            WebSocketService.shared.sendData(item: newItem)
        }
    }
    
    func itemExists(id: UUID) -> Bool {
        return items.contains(where: { $0.id == id})
    }
    
    func changeCompleted( isCompleted: Bool , id: UUID, notify: Bool = true) {
        if let index = items.firstIndex(where: { $0.id == id}) {
            items[index].completed = isCompleted
            
            if notify {
                WebSocketService.shared.sendData(item: items[index])
            }
        }
    }
}
