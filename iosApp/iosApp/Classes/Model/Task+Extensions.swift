//
//  Task+Extensions.swift
//  iosApp
//
//  Created by Dimitri Giani on 15/04/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation
import shared

extension Task {
    var startDateFormatted: String {
        guard let date = startDate else { return "" }
        return DateFormatter.localizedString(from: Date(timeIntervalSince1970: TimeInterval(date.epochSeconds)), dateStyle: .medium, timeStyle: .none)
    }

    var endDateFormatted: String {
        guard let date = endDate else { return "" }
        return DateFormatter.localizedString(from: Date(timeIntervalSince1970: TimeInterval(date.epochSeconds)), dateStyle: .medium, timeStyle: .none)
    }
}
