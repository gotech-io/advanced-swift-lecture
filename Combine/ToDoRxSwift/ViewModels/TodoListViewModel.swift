//
//  TodoListViewModel.swift
//  ToDoRxSwift
//
//  Created by giora krasilshchik on 08/11/2020.
//

import Foundation
import Combine

class TodoListViewModel {
    @Published private var items: [TodoItemViewModel] = []
    @Published var showCompleted = false
    private var cancellables: Set<AnyCancellable> = []
    var filteredItems: [TodoItemViewModel] = []
    let onReload = PassthroughSubject<Void, Never>()
    
    init() {
        TodoItemRepository.shared.$items
            .map { items in
                return items.map { item in
                    TodoItemViewModel(todoItem: item)
                }
            }.assign(to:\.items , on: self)
            .store(in: &cancellables)
        
        Publishers.CombineLatest($items, $showCompleted).map { items, showCompleted  -> [TodoItemViewModel] in
            if !showCompleted {
                return items.filter { !$0.todoItem.completed }
            }
            return items
        }.sink(receiveValue: {[weak self] items in
            self?.filteredItems = items
            self?.onReload.send()
        })
        .store(in: &cancellables)
    }
}
