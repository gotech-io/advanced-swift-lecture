//
//  TodoItemViewModel.swift
//  ToDo
//
//  Created by giora krasilshchik on 25/10/2020.
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
