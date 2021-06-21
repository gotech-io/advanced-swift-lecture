//
//  TodoItemRepository.swift
//  ToDoRxSwift
//

import Foundation
import RxSwift
import RxCocoa

class TodoItemRepository {
    
    static let shared = TodoItemRepository()
    

    private (set) var items = BehaviorRelay<[Item]>(value: [Item(id: UUID(uuidString: "e1741d12-db24-4c19-83ba-eb39c4691c10")!, title: "buy food"),
                                                            Item(id: UUID(uuidString: "acb623ea-9723-42b9-a370-a701f367478a")!, title: "call doctor" ),
                                                            Item(id: UUID(uuidString: "81db856b-ce74-4ad9-8a8f-13c1e7b7ad32")!, title: "prepare for oracle",completed: true )
    ])
    
    func addItem(title: String, id: UUID = UUID(), notify: Bool = true) {
        let newItem = Item(id: id, title: title)
        let newValue = items.value + [newItem]
        items.accept(newValue)
        
        if notify {
            WebSocketService.shared.sendData(item: newItem)
        }
    }
    
    func itemExists(id: UUID) -> Bool {
        return items.value.contains(where: { $0.id == id})
    }
    
    func changeCompleted(isCompleted: Bool, id: UUID, notify: Bool = true) {
        if let index = items.value.firstIndex(where: { $0.id == id}) {
            var tmpItems = items.value
            tmpItems[index].completed = isCompleted
            items.accept(tmpItems)
            
            if notify {
                WebSocketService.shared.sendData(item: tmpItems[index])
            }
        }
    }
}
