//
//  TodoListViewModel.swift
//  ToDo
//
//  Created by giora krasilshchik on 22/10/2020.
//

import Combine
import SwiftUI
// make our viewmodel extend ObservableObject to use combine feutures
class ToDoListViewModel: ObservableObject {
    //we can set this publisher to update ui when data is updated TodoItemRepository
    @Published var items: [Item] = []
    
    //thus publisher is changed from UI and when changes the publisher of the todo list
    @Published var showItems = 0 {
        didSet {
            getToDoList()
        }
    }

    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getToDoList()
    }
    
    func changeComplete( isCompleted: Bool , item: Item) {
        TodoItemRepository.shared.changeCompleted(isCompleted: !item.completed, id: item.id)
    }
}


private extension ToDoListViewModel {
    func getToDoList() {
        //we create a publisher that observe list of to do and filte this list based on showItems
        //we use sink to subsribe to items publisher
        //    the store method is available on the Cancellable protocol, which is explicitly set up to support saving off references that can be used to cancel a pipeline.
        TodoItemRepository.shared.$items.sink(receiveValue: { todoItems in
            if self.showItems == 0 {
                self.items = todoItems
            }else {
                self.items = todoItems.filter{ $0.completed == false}
            }
        }).store(in: &cancellables)
    }
}

