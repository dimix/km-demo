//
//  MapKit+Composable.swift
//  
//
//  Created by Dimitri Giani on 23/07/21.
//

import MapKit
import UIKit

public extension MKMapView {
    func delegate(_ delegate: MKMapViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
}
