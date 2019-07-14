//
//  ListViewModel.swift
//  MapPinsMVVM
//
//  Created by Harry Netzer on 7/11/19.
//  Copyright © 2019 Big Hike. All rights reserved.
//

import Foundation

public class ListViewModel: NSObject {
    let pinModel: PinModelProtocol
    
    @objc public init(pinModel: PinModelProtocol) {
        self.pinModel = pinModel
    }
    
    @objc public func configure(cell: PinCell, forIndexPath: IndexPath) {
        let pin = pinModel.pins[forIndexPath.row]
        cell.nameLabel.text = pin.name
        cell.descLabel.text = pin.desc
    }
    
    @objc public func countRows() -> Int {
        return pinModel.pins.count
    }
    
    @objc @discardableResult public func deleteRowAt(indexPath: IndexPath) -> Pin? {
        return pinModel.removePinAt(indexPath: indexPath)
    }
    
    @objc public func resetPins() {
        pinModel.downloadPins()
    }
}
