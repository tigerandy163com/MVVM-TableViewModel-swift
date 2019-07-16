//
//  TestCell.swift
//  MVVM-TableViewModel
//
//  Created by xx on 2019/7/9.
//  Copyright © 2019 tfb. All rights reserved.
//

import UIKit

class TestCellModel: TableCellModelInterface {
    var height: CGFloat = 40
    var title: String?
    var subTitle: String?
}

extension TestCellModel: TableCellProvider {
    func dequeueReusableCell(fromTableView tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(indexPath: indexPath) as TestCell
    }
}

class TestCell:  UITableViewCell, TableCellInterface {
    weak var delegate: NSObjectProtocol?

    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var subTitleLab: UILabel!
    
    var model: TableCellModelInterface? {
        didSet {
            if let cellModel = model as? TestCellModel {
                self.titleLab.text = cellModel.title
                self.subTitleLab.text = cellModel.subTitle
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
