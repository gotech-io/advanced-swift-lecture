//
//  TodoListViewModel.swift
//  ToDoRxSwift
//

import Foundation
import RxSwift
import RxCocoa

class TodoListViewModel {
    private let disposeBag = DisposeBag()
    private let items: BehaviorRelay<[TodoItemViewModel]> = BehaviorRelay(value: [])
    let filteredItems: BehaviorRelay<[TodoItemViewModel]> = BehaviorRelay(value: [])
    let showCompleted: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
    init() {
        TodoItemRepository.shared.items
            .map { items in
                return items.map { item in
                    TodoItemViewModel(todoItem: item)
                }
            }
            .bind(to: items)
            .disposed(by: disposeBag)
        
        Observable
            .combineLatest(self.items, self.showCompleted) { latestItems, latestShowCompleted in
                if !latestShowCompleted {
                    return latestItems.filter { !$0.todoItem.completed }
                }
                return latestItems
            }
            .bind(to: filteredItems)
            .disposed(by: disposeBag)
    }
}
