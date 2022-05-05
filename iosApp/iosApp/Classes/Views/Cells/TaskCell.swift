//
//  TaskCell.swift
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

class TaskCell: BaseTableViewCell {
    private let titleLabel = UILabel().font(UIFont.systemFont(ofSize: 17, weight: .semibold)).textColor(.black)
    private let fromLabel = UILabel().font(UIFont.systemFont(ofSize: 14, weight: .semibold)).textColor(.gray)
    private let toLabel = UILabel().font(UIFont.systemFont(ofSize: 14, weight: .semibold)).textColor(.gray)
    private let timeLabel = UILabel().font(UIFont.systemFont(ofSize: 14, weight: .regular)).textColor(.black)
    private let conjImage = UIImageView().image(UIImage(named: "icon_conjunction")).size(width: 20).contentMode(.scaleAspectFit)

    var task: Task? {
        didSet {
            updateUI()
        }
    }

    override func configureView() {
        super.configureView()

        let view = VView(spacing: 4, views: {

            titleLabel

            UIView.containing(HView(alignment: .center, spacing: 4, views: {
                fromLabel
                conjImage
                toLabel
            }), constraint: [LC.leading, LC.top, LC.bottom])

            timeLabel
        })

        containerView.addSubview(view, constraints: LC.fit(constant: 16))
        addBottomDividerLine()
    }

    override func updateUI() {
        super.updateUI()

        guard let task = task else { return }

        titleLabel.text = task.name
        fromLabel.text = task.startDateFormatted
        toLabel.text = task.endDateFormatted
        timeLabel.text = task.timePerDayFormatted
    }
}
