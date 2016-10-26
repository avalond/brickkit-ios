//
//  StickingFooterBaseViewController.swift
//  BrickKit
//
//  Created by Ruben Cagnie on 6/3/16.
//  Copyright © 2016 Wayfair LLC. All rights reserved.
//

import BrickKit

private let StickySection = "Sticky Section"
private let FooterTitle = "FooterTitle"

class StickingFooterBaseViewController: BrickApp.BaseBrickController {

    override class var title: String {
        return "Sticking Footer"
    }

    override class var subTitle: String {
        return "Example of Sticking Footers"
    }

    let numberOfLabels = 50
    var repeatLabel: LabelBrick!

    override func viewDidLoad() {
        super.viewDidLoad()


        let layout = self.brickCollectionView.layout
        layout.zIndexBehavior = .BottomUp

        self.brickCollectionView.registerBrickClass(LabelBrick.self)

        let behavior = StickyFooterLayoutBehavior(dataSource: self)
        self.brickCollectionView.layout.behaviors.insert(behavior)

        let footerSection = BrickSection(StickySection, backgroundColor: UIColor.whiteColor(), bricks: [
            LabelBrick(FooterTitle, backgroundColor: .brickGray1, dataSource: LabelBrickCellModel(text: "Footer Title")),
            LabelBrick(width: .Ratio(ratio: 0.5), backgroundColor: .lightGrayColor(), dataSource: LabelBrickCellModel(text: "Footer Label 1")),
            LabelBrick(width: .Ratio(ratio: 0.5), backgroundColor: .lightGrayColor(), dataSource: LabelBrickCellModel(text: "Footer Label 2")),
            ], inset: 5, edgeInsets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))

        let section = BrickSection(backgroundColor: .whiteColor(), bricks: [
            LabelBrick(BrickIdentifiers.repeatLabel, width: .Ratio(ratio: 0.5), height: .Auto(estimate: .Fixed(size: 38)), backgroundColor: .brickGray1, dataSource: self),
            footerSection
            ])
        section.repeatCountDataSource = self

        self.setSection(section)
    }

}

extension StickingFooterBaseViewController: BrickRepeatCountDataSource {
    func repeatCount(for identifier: String, with collectionIndex: Int, collectionIdentifier: String) -> Int {
        if identifier == BrickIdentifiers.repeatLabel {
            return numberOfLabels
        } else {
            return 1
        }
    }
}

extension StickingFooterBaseViewController: LabelBrickCellDataSource {
    func configureLabelBrickCell(cell: LabelBrickCell) {
        cell.label.text = "BRICK \(cell.index + 1)"
        cell.configure()
    }
}


extension StickingFooterBaseViewController: StickyLayoutBehaviorDataSource {
    func stickyLayoutBehavior(stickyLayoutBehavior: StickyLayoutBehavior, shouldStickItemAtIndexPath indexPath: NSIndexPath, withIdentifier identifier: String, inCollectionViewLayout collectionViewLayout: UICollectionViewLayout) -> Bool {
        return identifier == StickySection
    }
}
