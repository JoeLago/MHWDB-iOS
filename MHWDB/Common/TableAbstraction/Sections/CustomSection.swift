//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit

class CustomSection<T, U: CustomCell<T>>: DetailSection {
    var rows: [T]? {
        didSet {
            populateNumRows()
        }
    }

    var selectionBlock: ((T) -> Void)?
    var viewControllerBlock: ((T) -> UIViewController)?
    var identifier: String = "cell" // override

    convenience init(title: String?, data: [T], cellType: U.Type, header: HeaderView? = nil, showCount: Bool = false, selectionBlock: ((T) -> Void)? = nil) {
        self.init(title: title, data: data, header: header, showCount: showCount, selectionBlock: selectionBlock)
    }

    init(title: String?, data: [T], header: HeaderView? = nil, showCount: Bool = false, selectionBlock: ((T) -> Void)? = nil) {
        super.init()
        self.title = title
        self.rows = data
        self.headerView = header
        self.selectionBlock = selectionBlock
        showCountMinRows = showCount ? 2 : -1
        populateNumRows()
    }

    func populateNumRows() {
        numberOfRows = rows?.count ?? 0
    }

    override func initialize() {
        super.initialize()
        register(U.self)
    }

    override func cell(row: Int) -> UITableViewCell? {
        return dequeueCell(identifier: identifier) ?? U()
    }

    override func populate(cell: UITableViewCell, row: Int) {
        (cell as? U)?.model = rows?[row]
        cell.selectionStyle = selectionBlock == nil ? .none : .default
    }

    override func selected(row: Int, navigationController: UINavigationController?) {
        if let model = rows?[row] {
            selected(model: model, navigationController: navigationController)
        }
    }

    func selected(model: T, navigationController: UINavigationController?) {
        if let selectionBlock = selectionBlock {
            selectionBlock(model)
        } else if let viewControllerBlock = viewControllerBlock {
            navigationController?.pushViewController(viewControllerBlock(model), animated: true)
        }
    }
}
