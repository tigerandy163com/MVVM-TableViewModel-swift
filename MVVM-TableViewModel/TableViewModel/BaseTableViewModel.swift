//
//  BaseTableViewModel.swift
//
//  Created by xx on 2019/4/25.
//

import Foundation
import UIKit
/** For SectionHeader and SectionFooter, using a simple process, no reuse mechanisms, not suitable for a large number of use, if you want to use reusable, should use UITableViewHeaderFooterView,Provides two UITableView extension: registerHeaderFooter and dequeueReusableHeaderFooter
*/
public protocol TableSectionModelInterface {
    var cellModels: [TableCellProvider]? {get set}
    /// Warning! Not a reusable header
    var header: UIView? {get set}
    var headerHeight: CGFloat {get set}
    /// Warning! Not a reusable footer
    var footer: UIView? {get set}
    var footerHeight: CGFloat {get set}
}

@objc public protocol TableCellModelInterface {
    var height: CGFloat {get set}
}

public extension TableCellModelInterface {
    func cellModel() -> TableCellModelInterface {
        return self
    }
}

public protocol TableCellProvider {
    func dequeueReusableCell(fromTableView tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func bindModel(_ cell :TableCellInterface)
    func setDelegate(_ cell :TableCellInterface, delegate: NSObjectProtocol)
    func cellHeight() -> CGFloat
    func cellModel() -> TableCellModelInterface
}

public extension TableCellProvider {
    func dequeueAndBind(fromTableView tableView: UITableView, indexPath: IndexPath,  cellDelegate: NSObjectProtocol) -> UITableViewCell {
        let cell = self.dequeueReusableCell(fromTableView: tableView, indexPath: indexPath)
        self.bindModel(cell as! TableCellInterface)
        self.setDelegate(cell as! TableCellInterface, delegate: cellDelegate)
        return cell
    }
    
    func bindModel(_ cell: TableCellInterface) {
        let cell = cell
        cell.model = self.cellModel()
    }
    
    func setDelegate(_ cell: TableCellInterface, delegate: NSObjectProtocol) {
        let cell = cell
        cell.delegate = delegate
    }
    
    func cellHeight() -> CGFloat {
        return cellModel().height
    }
}

@objc public protocol TableCellInterface {
    weak var delegate: NSObjectProtocol? {get set}
    var model: TableCellModelInterface? {get set}
}

/** For SectionHeader and SectionFooter, using a simple process, no reuse mechanisms, not suitable for a large number of use, if you want to use reusable, should use UITableViewHeaderFooterView,Provides two UITableView extension: registerHeaderFooter and dequeueReusableHeaderFooter
 */
open class BaseTableSectionModel: TableSectionModelInterface {
    
    /// Warning! Not a reusable header
    public var header: UIView?
    
    public var headerHeight: CGFloat = 0.0
    
    /// Warning! Not a reusable footer
    public var footer: UIView?
    
    public var footerHeight: CGFloat = 0.0
    
 
    public var cellModels: [TableCellProvider]?
    
    public init() {}
}

let PlainCellSeparatorZero = CGFloat(0.0)
let GroupCellSeparatorZero = CGFloat(0.01)

public typealias CellDidSelected = (_ indexPath: IndexPath, _ cellModel: Any?) -> Void

open class BaseTableViewModel: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    public init(table: UITableView) {
        super.init()
        tableView = table
        configTable()
    }
    
    public var tableView: UITableView! {
        didSet {
            configTable()
        }
    }
    
    public func configTable() -> Void {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        tableView?.tableFooterView = UIView()
        tableView?.tableHeaderView = UIView()
        tableView?.clipsToBounds = true
        if #available(iOS 11.0, *) {
            tableView?.contentInsetAdjustmentBehavior = .never
        }
    }
    
    public var cellDidSelected: CellDidSelected?
    
    public var data: Array<TableSectionModelInterface>?
    
    public func reload() -> Void {
        tableView.reloadData()
    }
    
    public func sectionModelOfIndex(_ index: Int) -> TableSectionModelInterface? {
        guard let section = data?[index] else {
            return nil
        }
        return section
    }
    
    public func cellModelOfIndexPath(_ indexPath: IndexPath) -> TableCellProvider? {
        guard let section = sectionModelOfIndex(indexPath.section), let cells = section.cellModels else {
            return nil
        }
        return cells[indexPath.row]
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return data?.count ?? 0
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sec = data?[section], let cells = sec.cellModels else {
            return 0
        }
        return cells.count
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cell = cellModelOfIndexPath(indexPath) else {
            return 0.0
        }
        return cell.cellHeight()
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionModelOfIndex(section)?.headerHeight ?? (tableView.style == .grouped ? GroupCellSeparatorZero : PlainCellSeparatorZero)
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionModelOfIndex(section)?.header
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sectionModelOfIndex(section)?.footerHeight ?? (tableView.style == .grouped ? GroupCellSeparatorZero : PlainCellSeparatorZero)
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return sectionModelOfIndex(section)?.footer
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cellModelOfIndexPath(indexPath) else {
            return UITableViewCell()
        }
        return cell.dequeueAndBind(fromTableView: tableView, indexPath: indexPath, cellDelegate: self)
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let selected = cellDidSelected {
            let model = cellModelOfIndexPath(indexPath)
            selected(indexPath, model)
        }
    }
}
