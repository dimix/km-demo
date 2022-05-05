//
//  JobCell.swift
//  iosApp
//
//  Created by Dimitri Giani on 02/04/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import apple_common
import ios_common
import ios_composable
import UIKit
import shared

class JobCell: BaseTableViewCell {
    private let titleLabel = UILabel().font(UIFont.systemFont(ofSize: 17, weight: .semibold)).textColor(.black)
    private let fromLabel = UILabel().font(UIFont.systemFont(ofSize: 14, weight: .semibold)).textColor(.gray)
    private let toLabel = UILabel().font(UIFont.systemFont(ofSize: 14, weight: .semibold)).textColor(.gray)
    private let tasksStatusLabel = UILabel().font(UIFont.systemFont(ofSize: 14, weight: .regular)).textColor(.black)
    private let typeLabel = UILabel().font(UIFont.systemFont(ofSize: 14, weight: .bold)).textColor(.white)
    private let conjImage = UIImageView().image(UIImage(named: "icon_conjunction")).size(width: 20).contentMode(.scaleAspectFit)
    private let progressBar = UIProgressView()

    var job: Job? {
        didSet {
            updateUI()
        }
    }

    override func configureView() {
        super.configureView()

        typeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        let view = VView(spacing: 4, views: {

            HView(spacing: 0, views: {
                titleLabel
                UIView.containing(typeLabel, constraint: LC.fit(constant: 8))
                    .cornerRadius(16)
                    .backgroundColor(.systemBlue)
            })

            UIView.containing(HView(alignment: .center, spacing: 4, views: {
                fromLabel
                conjImage
                toLabel
            }), constraint: [LC.leading, LC.top, LC.bottom])

            tasksStatusLabel
        })

        progressBar.setDimensionContraints(width: nil, height: 4)
        progressBar.trackTintColor = UIColor.lightGray
        progressBar.progressTintColor = UIColor.systemBlue

        containerView.addSubview(view, constraints: LC.fitTop(constant: 16))
        containerView.addSubview(progressBar, constraints: [
            LC.top(view: view, constant: 16),
            LC.trailing,
            LC.leading,
            LC.bottom
        ])
    }

    override func updateUI() {
        super.updateUI()

        guard let job = job else { return }

        titleLabel.text = job.name
        fromLabel.text = job.startDateFormatted
        toLabel.text = job.endDateFormatted
        tasksStatusLabel.text = job.tasksStatusFormatted
        typeLabel.text = job.type.title
        progressBar.progress = job.taskStatusPercentage
    }
}
