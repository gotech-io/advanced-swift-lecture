//
//  ViewController.swift
//  ToDoRxSwift
//

import UIKit
import RxCocoa
import RxSwift

class TodoList: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var tblTodo: UITableView!
    @IBOutlet weak var btnAddTask: UIButton!
    @IBOutlet weak var switchTasks: UISegmentedControl!
    
    let viewModel = TodoListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAddTask.layer.cornerRadius = 15
        viewModel.filteredItems.asDriver()
            .drive(tblTodo.rx.items(cellIdentifier: "TodoCell", cellType: TodoCell.self)) { row, model, cell in
                cell.setup(viewModel: model)
            }
            .disposed(by: disposeBag)
        
        tblTodo.rx.modelSelected(TodoItemViewModel.self).subscribe(onNext: { item in
            let vc = TodoDetails.initWithModel(vm: TodoDetailsViewModel(item: item.todoItem))
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.showCompleted.asDriver()
            .map { $0 ? 0 : 1 }
            .drive(switchTasks.rx.selectedSegmentIndex)
            .disposed(by: disposeBag)
        
        switchTasks.rx.selectedSegmentIndex
            .map { $0 == 0 }
            .bind(to: viewModel.showCompleted)
            .disposed(by: disposeBag)
    }
}


class TodoCell: UITableViewCell {
    var disposeBag = DisposeBag()
    private var viewModel: TodoItemViewModel?
    @IBOutlet weak var btnCompleted: UIButton!
    @IBOutlet weak var lblTaskText: UILabel!
    
    func setup(viewModel: TodoItemViewModel) {
        self.viewModel = viewModel
        self.btnCompleted.isSelected = viewModel.todoItem.completed
        self.lblTaskText.text = viewModel.todoItem.title
        
        // This is important, once we "get rid" of our old dispose bag, all subscriptions are of
        self.disposeBag = DisposeBag()
        btnCompleted.rx.tap.bind { [weak self] in
            self?.viewModel?.changeComplete()
        }.disposed(by: disposeBag)
    }
}


