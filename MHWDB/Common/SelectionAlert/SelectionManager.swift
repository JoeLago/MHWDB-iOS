//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit

@objc class SelectionManager: NSObject {
    var parentController: UIViewController
    let title: String
    let options: [String]
    let selected: (Int, String) -> Void

    lazy var alert: UIAlertController = {
        return UIAlertController(options: options) { [weak self] (index: Int, selection: String) in
            self?.button.title = selection
            self?.selected(index, selection)
        }
    }()

    lazy var button: UIBarButtonItem = {
        return UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(buttonPressed))
    }()

    init(title: String, options: [String], parentController: UIViewController, selected: (@escaping (Int, String) -> Void)) {
        self.parentController = parentController
        self.title = title
        self.options = options
        self.selected = selected
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func buttonPressed() {
        parentController.navigationController?.present(alert, animated: true, completion: nil)
    }
}
