//___FILEHEADER___

import UIKit

class ___FILEBASENAMEASIDENTIFIER___TableViewModel: BaseTableViewModel {
    func build() -> Void {
        //TODO: build section and cell model
        let section = BaseTableSectionModel()
	//TODO:new your cell model
        let cell = ___FILEBASENAMEASIDENTIFIER___CellModel()
        section.cellModels = [cell]
        self.data = [section]
    }
}


class ___FILEBASENAMEASIDENTIFIER___: ___VARIABLE_cocoaTouchSubclass___ {
    @IBOutlet weak var tableView: UITableView!

    var tableViewModel: ___FILEBASENAMEASIDENTIFIER___TableViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

	//TODO:Register your cells
        tableView.register(___FILEBASENAMEASIDENTIFIER___Cell.self) 
        tableViewModel = ___FILEBASENAMEASIDENTIFIER___TableViewModel(table: tableView)
        tableViewModel.cellDidSelected = {[weak self](indexPath, model) -> Void in
            if let weakself = self {
     
            }
        }
        tableViewModel.build()
        tableViewModel.reload()

    }

}
