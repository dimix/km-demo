//
//  JobHeaderCell.swift
//  iosApp
//
//  Created by Dimitri Giani on 15/04/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import UIKit
import shared

class JobHeaderCell: BaseTableViewCell {
    private let titleLabel = UILabel().font(UIFont.systemFont(ofSize: 17, weight: .regular)).textColor(.black).numberOfLines(0)
    private let fromLabel = UILabel().font(UIFont.systemFont(ofSize: 14, weight: .semibold)).textColor(.gray)
    private let toLabel = UILabel().font(UIFont.systemFont(ofSize: 14, weight: .semibold)).textColor(.gray)
    private let tasksLabel = UILabel().font(UIFont.systemFont(ofSize: 22, weight: .bold)).textColor(.black)
    private let typeLabel = UILabel().font(UIFont.systemFont(ofSize: 14, weight: .bold)).textColor(.white)
    private let conjImage = UIImageView().image(UIImage(named: "icon_conjunction")).size(width: 20).contentMode(.scaleAspectFit)

    var job: Job? {
        didSet {
            updateUI()
        }
    }

    override func configureView() {
        super.configureView()

        let typeView = UIView.containing(typeLabel, constraint: LC.fit(constant: 8)).cornerRadius(16).backgroundColor(.systemBlue)
        let typeViewContainer = UIView.containing(typeView, constraint:
                                                    [
                                                        equal(\.leadingAnchor, minimum: 8),
                                                        LC.trailing(constant: 8),
                                                        LC.top
                                                    ])

        let view = VView(spacing: 4, views: {

            HView(spacing: 8, views: {
                titleLabel
                typeViewContainer
            })

            UIView.containing(HView(alignment: .center, spacing: 4, views: {
                fromLabel
                conjImage
                toLabel
            }), constraint: [LC.leading, LC.top, LC.bottom])

            UIView.spacer()

            tasksLabel
        })

        containerView.addSubview(view, constraints: LC.fit(constant: 16))
    }

    override func updateUI() {
        super.updateUI()

        guard let job = job else { return }

        titleLabel.text = job.body
        fromLabel.text = job.startDateFormatted
        toLabel.text = job.endDateFormatted
        typeLabel.text = job.type.title
        tasksLabel.text = "tasks_title".localized
    }
}
