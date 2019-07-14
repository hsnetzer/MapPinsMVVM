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
    
    // creates MGLPointAnnotations from the model
    public func makeAnnotations() -> [MGLPointAnnotation] {
        return pinModel.pins.map { pin in
            let annotation = MGLPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
            annotation.title = pin.name
            annotation.subtitle = pin.desc
            return annotation
        }
    }
    
    // so the map knows which pin to remove when the user deletes a row from the list view
    public func lastRemovedPinName() -> String? {
        return pinModel.lastRemoved?.name
    }
    
    // called when the user refreshes the pins from the server
    public func resetPins() {
        pinModel.downloadPins()
    }
}
