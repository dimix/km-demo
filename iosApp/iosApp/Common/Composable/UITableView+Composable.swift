//
//  UITableView+Composable.swift
//
//  Created by Dimitri Giani on 03/05/21.
//

// 
// 
//import UIKit
//import Combine
//
//@available(iOS 13, *)
//public class Table<T>: UITableView {
//    private var layoutManager: TableViewLayoutManager!
//    private let composeView: (T) -> UIView
//    private var subscribers: [AnyCancellable] = []
//    
//    @Published public var model: [[T]]
//    
//    public init(style: UITableView.Style = .plain,
//         separatorStyle: UITableViewCell.SeparatorStyle = .none,
//         model: [[T]],
//         _ composeView: @escaping (T) -> UIView) {
//        self.model = model
//        self.composeView = composeView
//        
//        super.init(frame: .zero, style: style)
//        
//        self.separatorStyle = separatorStyle
//        
//        layoutManager = TableViewLayoutManager(tableView: self)
//        
//        $model.receive(on: DispatchQueue.main)
//            .sink { [weak self] _ in
//                self?.layoutManager.reloadData()
//            }
//            .store(in: &subscribers)
//        
//        setupLayout()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupLayout() {
//        layoutManager.numberOfSections = { return self.model.count }
//        layoutManager.numberOfRowsInSection = { section in return self.model[section].count }
//        layoutManager.cellForIndexPath = { indexPath in
//            let cell: BaseTableViewCell = BaseTableViewCell.dequeue(from: self, at: indexPath)
//            cell.selectionStyle = .none
//            let view = self.composeView(self.model[indexPath.section][indexPath.row])
//            cell.containerView.addSubviewAndFit(view)
//            return cell
//        }
//        
//        layoutManager.reloadData()
//    }
//}
