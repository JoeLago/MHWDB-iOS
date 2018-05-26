//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit

class SimpleDetailSection<T: DetailCellModel>: DetailSection {

    var rows: [T]? {
        didSet {
            populateNumRows()
        }
    }

    var selectionBlock: ((T) -> Void)?
    var viewControllerBlock: ((T) -> UIViewController)?

    override init() {

    }

    init(data: [T], title: String? = nil, showCountMinRows: Int = 0, isCollapsed: Bool = false,
         defaultCollapseCount: Int = -1, selectionBlock: ((T) -> Void)? = nil) {
        super.init()
        self.showCountMinRows = showCountMinRows
        self.defaultCollapseCount = defaultCollapseCount
        self.cleanTitle = title
        self.rows = data
        self.selectionBlock = selectionBlock
        self.isCollapsed = isCollapsed
        populateNumRows()
    }

    convenience init(title: String? = nil, data: [T], showCountMinRows: Int = 0, isCollapsed: Bool = false, defaultCollapseCount: Int = -1, viewController: @escaping ((T) -> UIViewController)) {
        self.init(data: data, title: title, showCountMinRows: showCountMinRows, isCollapsed: isCollapsed, defaultCollapseCount: defaultCollapseCount, selectionBlock: nil)
        viewControllerBlock = viewController
    }

    func populateNumRows() {
        numberOfRows = rows?.count ?? 0
    }

    override func initialize() {
        super.initialize()
        register(DetailCell.self, identifier: DetailCell.identifier)
    }

    override func cell(row: Int) -> UITableViewCell? {
        let cell = dequeueCell(identifier: DetailCell.identifier) ?? DetailCell()
        return cell
    }

    override func populate(cell: UITableViewCell, row: Int) {
        (cell as? DetailCell)?.model = rows?[row]
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
