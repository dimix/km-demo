//
//  JobDetailViewController.swift
//  iosApp
//
//  Created by Dimitri Giani on 15/04/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import apple_common
import ios_common
import ios_composable
import UIKit
import shared

class JobDetailViewController: BaseViewController {
    enum Item {
        case header(job: Job)
        case task(task: Task)
    }

    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var layout: TableViewLayoutManager?
    private var model: [Item] = []

    let job: Job

    init(job: Job) {
        self.job = job
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareModel()
        setupUI()
    }

    private func prepareModel() {
        model = [
            .header(job: job)
        ]

        model.append(contentsOf: job.tasks.map { Item.task(task: $0) })
    }

    private func setupUI() {
        title = job.name

        tableView.backgroundColor = .white
        tableView.backgroundView?.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        view.addSubviewAndFit(tableView)

        layout = TableViewLayoutManager(tableView: tableView)
        layout?.numberOfRowsInSection = { [weak self] _ in
            self?.model.count ?? 0
        }
        layout?.cellForIndexPath = { [weak self] indexPath in
            guard let self = self else { return UITableViewCell() }

            let item = self.model[indexPath.row]
            switch item {
            case .header(let job):
                let cell: JobHeaderCell = JobHeaderCell.dequeue(from: self.tableView, at: indexPath)
                cell.job = job
                return cell
            case .task(let task):
                let cell: TaskCell = TaskCell.dequeue(from: self.tableView, at: indexPath)
                cell.task = task
                return cell
            }
        }
    }
}
