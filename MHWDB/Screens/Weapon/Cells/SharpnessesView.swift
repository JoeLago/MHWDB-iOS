//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit

class SharpnesesView: UIView {
    var sharpnessViewOne = SharpnessView()
    var sharpnessViewTwo = SharpnessView()

    var sharpnesses: [Sharpness]? {
        didSet {
            guard let sharpnesses = sharpnesses  else {
                isHidden = true
                return
            }

            isHidden = false
            sharpnessViewOne.sharpness = sharpnesses[0]
            sharpnessViewTwo.sharpness = sharpnesses[1]
        }
    }

    init() {
        super.init(frame: CGRect.zero)
        createViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createViews() {
        addSubview(sharpnessViewOne)
        addSubview(sharpnessViewTwo)

        sharpnessViewOne.paddingBottom = 1
        sharpnessViewTwo.paddingTop = 1
        useConstraintsOnly()

        addConstraints(
            formatStrings: ["H:|[one]|",
                            "H:|[two]|",
                            "V:|[one(==two)][two(==one)]|"],
            views: [
                "one": sharpnessViewOne,
                "two": sharpnessViewTwo
            ],
            metrics: [:])
    }
}
