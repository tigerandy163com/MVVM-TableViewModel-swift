//
//  Test1Cell.swift
//  MVVM-TableViewModel
//
//  Created by xx on 2019/7/9.
//  Copyright © 2019 tfb. All rights reserved.
//

import UIKit

class Test1CellModel: TableCellModelInterface {
    var height: CGFloat = 110
    var title: String?
    var subTitle: String?
}

extension Test1CellModel: TableCellProvider {
    func dequeueReusableCell(fromTableView tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(indexPath: indexPath) as Test1Cell
    }
}

protocol Test1CellDelegate {
    func tapCell(cell: Test1Cell)
}

class Test1Cell:  UITableViewCell, TableCellInterface {
    weak var delegate: NSObjectProtocol?
    
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var subTitleLab: UILabel!
    
    var model: TableCellModelInterface? {
        didSet {
            if let cellModel = model as? Test1CellModel {
                self.titleLab.text = cellModel.title
                self.subTitleLab.text = cellModel.subTitle
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func tap(_ sender: Any) {
        if let delegate = delegate as? Test1CellDelegate {
            delegate.tapCell(cell: self)
        }
    }
}
