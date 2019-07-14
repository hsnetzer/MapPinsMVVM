//
//  MapViewModel.swift
//  MapPinsMVVM
//
//  Created by Harry Netzer on 7/11/19.
//  Copyright © 2019 Big Hike. All rights reserved.
//

import Foundation
import Mapbox

@objcMembers public class MapViewModel: NSObject {
    let pinModel: PinModelProtocol
    
    public init(pinModel: PinModelProtocol) {
        self.pinModel = pinModel
    }
    
    public func makeAnnotations() -> [MGLPointAnnotation] {
        return pinModel.pins.map { pin in
            let annotation = MGLPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
            annotation.title = pin.name
            annotation.subtitle = pin.desc
            return annotation
        }
    }
    
    public func lastRemovedPinName() -> String? {
        return pinModel.lastRemoved?.name
    }
    
    public func resetPins() {
        pinModel.downloadPins()
    }
}
