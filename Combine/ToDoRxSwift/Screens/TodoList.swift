//
//  ViewController.swift
//  ToDoRxSwift
//
//  Created by giora krasilshchik on 08/11/2020.
//

import UIKit
import Combine
class TodoList: UIViewController {
    @IBOutlet weak var tblTodo: UITableView!
    @IBOutlet weak var btnAddTask: UIButton!
    @IBOutlet weak var switchTasks: UISegmentedControl!
    private var cancellables:Set<AnyCancellable> = []
    let viewModel = TodoListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAddTask.layer.cornerRadius = 15
        tblTodo.dataSource = self
        tblTodo.delegate = self
        
        viewModel.onReload
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
            self?.tblTodo.reloadData()
        }.store(in: &cancellables)
        
        switchTasks.publisher(for: \.selectedSegmentIndex).map {
            $0 == 0
        }.assign(to: \.showCompleted, on: viewModel)
        .store(in: &cancellables)
    }
}

extension TodoList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        cell.setup(viewModel: viewModel.filteredItems[indexPath.row])
        return cell
    }
}

extension TodoList: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = TodoDetails.initWithModel(vm: TodoDetailsViewModel(item: viewModel.filteredItems[indexPath.row].todoItem))
        navigationController?.pushViewController(vc, animated: true)
    }
}


class TodoCell: UITableViewCell {
    private var cancellable:Set<AnyCancellable> = []
    private var viewModel: TodoItemViewModel?
  
    @IBOutlet weak var btnCompleted: UIButton!
    @IBOutlet weak var lblTaskText: UILabel!
    
    func setup(viewModel: TodoItemViewModel) {
        self.viewModel = viewModel
        self.btnCompleted.isSelected = viewModel.todoItem.completed
        self.lblTaskText.text = viewModel.todoItem.title
        
        btnCompleted.publisher(for: .touchUpInside).sink { [weak self] _ in
            self?.viewModel?.changeComplete()
        }.store(in: &cancellable)
    }
}


