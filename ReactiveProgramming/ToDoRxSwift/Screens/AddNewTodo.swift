//
//  AddNewTodo.swift
//  ToDoRxSwift
//

import UIKit
import RxCocoa
import RxSwift

class AddNewTodo: UIViewController {

    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    let viewModel = AddNewTodoViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAdd.layer.cornerRadius = 10
        btnCancel.layer.cornerRadius = 10
        textFieldTitle.rx.text.bind(onNext: { text in
            if let aText = text {
                self.viewModel.title.accept(aText)
            }
        })
        .disposed(by: disposeBag)
        
        btnAdd.rx.tap.bind { [weak self] in
            self?.viewModel.addTask()
            self?.dismiss(animated: true) {}
        }
        .disposed(by: disposeBag)
        
        btnCancel.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true) {}
        }
        .disposed(by: disposeBag)
    }
}
