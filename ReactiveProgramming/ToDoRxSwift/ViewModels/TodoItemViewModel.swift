//
//  TodoItemViewModel.swift
//  ToDoRxSwift
//

import Foundation


class TodoItemViewModel {
    let todoItem: Item
    
    init(todoItem: Item) {
        self.todoItem = todoItem
    }
    
    func changeComplete() {
        TodoItemRepository.shared.changeCompleted(isCompleted: !todoItem.completed, id: todoItem.id)
    }
}
