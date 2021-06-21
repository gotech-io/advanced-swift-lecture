//
//  AddNewTodoViewModel.swift
//  ToDo
//
//  Created by giora krasilshchik on 22/10/2020.
//


import SwiftUI
import Combine

// make our viewmodel extend ObservableObject to use combine feutures
class AddNewTodoViewModel: ObservableObject {

    //state property to signle ui change
    @Published var title = ""
    
    func addTask(){
        TodoItemRepository.shared.addItem(title: title)
    }
}

