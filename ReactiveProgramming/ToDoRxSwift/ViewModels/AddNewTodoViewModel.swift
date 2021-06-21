//
//  AddNewTodoViewModel.swift
//  ToDoRxSwift
//

import Foundation
import RxCocoa
import RxSwift

class AddNewTodoViewModel {
    
    let title: BehaviorRelay<String> = BehaviorRelay(value:"")
    
    
    func addTask(){
        TodoItemRepository.shared.addItem(title: title.value)
    }
    
}
