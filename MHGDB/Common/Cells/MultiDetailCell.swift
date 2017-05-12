//
// MIT License
// Copyright (c) Gathering Hall Studios
//


import UIKit

class MultiDetailCell: UITableViewCell {
    let stack = StackView(axis: .horizontal, spacing: 18)
    
    init(details: [SingleDetailView]) {
        super.init(style: .value2, reuseIdentifier: String(describing: SingleDetailCell.self))
        selectionStyle = .none
        initializeViews()
        for detail in details {
            addView(detail)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*func addDetail(label: String, value: Int?) {
        if let value = value {
            addDetail(label: label, value: "\(value)")
        }
    }*/
    
    /*func addDetail(label: String, value: String?) {
        if let value = value {
            addDetail(SingleDetail(label: label, value: value))
        }
    }*/
    
    func addDetail(_ detail: SingleDetailLabel) {
        addView(detail)
    }
    
    func addView(_ view: UIView) {
        stack.addArrangedSubview(view)
    }
    
    func initializeViews() {
        contentView.addSubview(stack)
        contentView.useConstraintsOnly()
        stack.matchParent(top: 4, left: 25, bottom: 4, right: 25)
    }
}

class SingleDetail {
    var label: String?
    var text: String?
    var attributedText: NSAttributedString?
    
    init(label: String?, value: NSAttributedString?) {
        self.label = label
        self.attributedText = value
    }
    
    init(label: String?, value: String?) {
        self.label = label
        self.text = value
    }
    
    init(label: String?, value: Int?) {
        self.label = label
        if let value = value {
            self.text = "\(value)"
        }
    }
}

class SingleDetailView: UIView {
    let labelView = UILabel()
    let label: String
    let detailView: UIView
    
    init(label: String, detailView: UIView) {
        self.label = label
        self.detailView = detailView
        super.init(frame: CGRect.zero)
        initializeViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeViews() {
        let stack = StackView(axis: .vertical, spacing: 3)
        labelView.text = label
        labelView.font = Font.subTitle
        labelView.textColor = Color.Text.primary
        labelView.numberOfLines = 0
        
        addSubview(stack)
        stack.matchParent()
        stack.addArrangedSubview(labelView)
        stack.addArrangedSubview(detailView)
        
        useConstraintsOnly()
    }
}

class SingleDetailLabel: SingleDetailView {
    let detail = UILabel()
    
    var detailModel: SingleDetail? {
        didSet {
            populate()
        }
    }
    
    convenience init(label: String, value: String?) {
        self.init(SingleDetail(label: label, value: value))
    }
    
    convenience init(label: String, value: Int?) {
        self.init(SingleDetail(label: label, value: value))
    }
    
    convenience init(label: String, attributedString: NSAttributedString?) {
        self.init(SingleDetail(label: label, value: attributedString))
    }
    
    init(_ model: SingleDetail) {
        super.init(label: "", detailView: detail)
        initializeViews()
        self.detailModel = model
        populate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initializeViews() {
        super.initializeViews()
        detail.numberOfLines = 0
        detail.font = Font.title
    }
    
    private func populate() {
        if detailModel?.text?.characters.count ?? 0 > 50 {
            detail.font = Font.title
        }
        
        labelView.text = detailModel?.label
        
        if let text = detailModel?.attributedText {
            detail.attributedText = text
        } else {
            detail.text = detailModel?.text
        }
    }
}
