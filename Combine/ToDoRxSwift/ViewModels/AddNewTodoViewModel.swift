//
//  AddNewTodoViewModel.swift
//  ToDoRxSwift
//
//  Created by giora krasilshchik on 08/11/2020.
//

import Foundation

class AddNewTodoViewModel {
    
    var title: String = ""
    
    func addTask(){
        TodoItemRepository.shared.addItem(title: title)
    }
    
}
