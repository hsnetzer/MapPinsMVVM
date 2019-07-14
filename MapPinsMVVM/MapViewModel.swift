//
//  MapViewModel.swift
//  MapPinsMVVM
//
//  Created by Harry Netzer on 7/11/19.
//  Copyright © 2019 Big Hike. All rights reserved.
//

import Foundation
import Mapbox

public class MapViewModel: NSObject {
    let pinModel: PinModelProtocol
    
    @objc public init(pinModel: PinModelProtocol) {
        self.pinModel = pinModel
    }
    
    @objc public func makeAnnotations() -> [MGLPointAnnotation] {
        return pinModel.pins.map { pin in
            let annotation = MGLPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
            annotation.title = pin.name
            annotation.subtitle = pin.desc
            return annotation
        }
    }
    
    @objc public func lastRemovedPinName() -> String? {
        return pinModel.lastRemoved?.name
    }
    
    @objc public func resetPins() {
        pinModel.downloadPins()
    }
}
