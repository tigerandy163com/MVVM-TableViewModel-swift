//___FILEHEADER___

import UIKit

class ___FILEBASENAMEASIDENTIFIER___Model: TableCellModelInterface {
    var height: CGFloat = 40
}

extension ___FILEBASENAMEASIDENTIFIER___Model: TableCellProvider {
    func dequeueReusableCell(fromTableView tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(indexPath: indexPath) as ___FILEBASENAMEASIDENTIFIER___
    }
}

class ___FILEBASENAMEASIDENTIFIER___:  UITableViewCell, TableCellInterface {
    weak var delegate: NSObjectProtocol?

    var model: TableCellModelInterface? {
        didSet {
            if let cellModel = model as? ___FILEBASENAMEASIDENTIFIER___Model {
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
