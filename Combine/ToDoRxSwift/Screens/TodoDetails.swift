//
//  TodoDetails.swift
//  ToDoRxSwift
//
//  Created by giora krasilshchik on 08/11/2020.
//

import UIKit



class TodoDetails: UIViewController {

    var viewModel: TodoDetailsViewModel?
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var imgDone: UIImageView!
    
    class func initWithModel(vm: TodoDetailsViewModel) -> TodoDetails {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TodoDetails") as! TodoDetails
        vc.viewModel = vm
        return vc
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblItem.text = viewModel?.item.title
        imgDone.isHidden = !(viewModel?.item.completed ?? false)
    }
}
