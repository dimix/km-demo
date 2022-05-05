//
//  MainViewController.swift
//  iosApp
//
//  Created by Dimitri Giani on 02/04/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import UIKit
import shared

class MainViewController: BaseViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var layout: TableViewLayoutManager?
    private var jobs: [Job] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configureLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        reloadModel()
    }

    private func setupUI() {
        loadingIndicatorView = UIActivityIndicatorView(style: .medium)

        title = "Jobs"
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.backgroundView?.backgroundColor = .white
        tableView.separatorStyle = .none
        loadingIndicatorView?.hidesWhenStopped = true

        view.addSubviewAndCenter(loadingIndicatorView!)
        view.addSubview(tableView, constraints: LC.fit)
    }

    override func setLoadingViewVisible(_ visible: Bool) {
        super.setLoadingViewVisible(visible)

        tableView.isHidden = visible
    }

    private func configureLayout() {
        layout = TableViewLayoutManager(tableView: tableView)
        layout?.numberOfRowsInSection = { [weak self] _ in
            return self?.jobs.count ?? 0
        }
        layout?.cellForIndexPath = { [weak self] indexPath in
            guard let self = self else { return UITableViewCell() }
            let cell: JobCell = JobCell.dequeue(from: self.tableView, at: indexPath)
            cell.job = self.jobs[indexPath.row]
            return cell
        }
        layout?.didSelectRowAtIndexPath = { [weak self] indexPath in
            guard let self = self else { return }
            self.tableView.deselectRow(at: indexPath, animated: true)

            let job = self.jobs[indexPath.row]
            let controller = JobDetailViewController(job: job)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    private func reloadModel() {
        setLoadingViewVisible(true)
        Network().getJobs { [weak self] jobs, error in
            self?.setLoadingViewVisible(false)
            if let error = error {
                self?.showError(title: "Error", body: error.localizedDescription)
            } else {
                self?.jobs = jobs ?? []
                self?.layout?.reloadData()
            }
        }
    }

    private func showError(title: String, body: String) {
        UIAlertController.presentAlert(self, title: title, message: body, confirmAction: UIAlertAction.genericOkAction())
    }
}
