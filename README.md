# MVVM-TableViewModel-swift
TableView MVVM use swift

## Usage
1.   You can use  the templates to create classes quickly
-   **Table Cell.xctemplate** creates **TableViewCell** and **TableViewCellModel**
-  **TableView Controller.xctemplate** creates  **ViewController with a TableView** and **TableViewModel**
- To eliminate errors, you should edit some code simply

2. Example code

        // 1.Register your cells
        tableView.register(TestCell.self)
        tableView.register(Test1Cell.self)

        // 2.Create TableViewModel
        tableViewModel = TestViewControllerTableViewModel(table: tableView)
        tableViewModel.cellDidSelected = {[weak self](indexPath, model) -> Void in
            if let weakself = self {
                if let cellModel = model as? TestCellModel {
                    print("a TestCell, title is \(cellModel.title ?? "error"), sub is \(cellModel.subTitle ?? "error")")
                } else if let cellModel = model as? Test1CellModel {
                    print("a Test1Cell,title is \(cellModel.title ?? "error"), sub is \(cellModel.subTitle ?? "error")")
                }
            }
        }

        // 3.Create SectionModels and CellModels
        tableViewModel.build()

        // 4.Reload TableView
        tableViewModel.reload()