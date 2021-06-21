//
//  UITextField+Extension.swift
//  ToDoRxSwift
//
//  Created by giora krasilshchik on 26/05/2021.
//

import Foundation
import Combine
import UIKit

extension UITextField {
    func onTextChange() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map( {
                ($0.object as? UITextField)?.text ?? ""
            })
            .receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
}
