//
//  AddNewTodo.swift
//  ToDoRxSwift
//
//  Created by giora krasilshchik on 08/11/2020.
//

import UIKit
import Combine

class AddNewTodo: UIViewController {

    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    private let viewModel = AddNewTodoViewModel()
    private var cancellables:Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAdd.layer.cornerRadius = 10
        btnCancel.layer.cornerRadius = 10
        
        textFieldTitle.onTextChange()
            .assign(to: \.title, on: viewModel)
            .store(in: &cancellables)
        
        btnAdd.publisher(for: .touchUpInside).sink { [weak self] _ in
            self?.viewModel.addTask()
            self?.dismiss(animated: true) {}
        }.store(in: &cancellables)
        
        
        btnCancel.publisher(for: .touchUpInside).sink { [weak self] _ in
            self?.dismiss(animated: true) {}
        }.store(in: &cancellables)
    }
}
