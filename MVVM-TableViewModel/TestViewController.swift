//
//  TestViewController.swift
//  MVVM-TableViewModel
//
//  Created by xx on 2019/7/9.
//  Copyright © 2019 tfb. All rights reserved.
//

import UIKit

class TestViewControllerTableViewModel: BaseTableViewModel {
    func build() -> Void {
        //TODO: build section and cell model
        let section = BaseTableSectionModel()
	//TODO:new your cell model
        let cell = TestCellModel()
        cell.height = 50
        cell.title = "Test cell"
        cell.subTitle = "Test cell subtitle 0"
        
        let cell1 = Test1CellModel()
        cell1.height = 150
        cell1.title = "Test1 cell"
        cell1.subTitle = "Test1 cell subtitle 1"
        
        let cell2 = Test1CellModel()
        cell2.title = "Test1 cell"
        cell2.subTitle = "Test1 cell subtitle 2"
        
        let cell3 = TestCellModel()
        cell3.title = "Test cell"
        cell3.subTitle = "Test cell subtitle 3"
        
        section.cellModels = [cell, cell1, cell2, cell3]
        self.data = [section]
    }
}

extension TestViewControllerTableViewModel: Test1CellDelegate {
    func tapCell(cell: Test1Cell) {
        print("i know u! test1cell")
        if let model = cell.model as? Test1CellModel {
            print("title is \(model.title ?? "error"), sub is \(model.subTitle ?? "error")")
        }
    }
}


class TestViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var tableViewModel: TestViewControllerTableViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

	//TODO:Register your cells
        tableView.register(TestCell.self)
        tableView.register(Test1Cell.self)
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
        tableViewModel.build()
        tableViewModel.reload()

    }

}


