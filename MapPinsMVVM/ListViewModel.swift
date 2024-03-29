//
//  ListViewModel.swift
//  MapPinsMVVM
//
//  Created by Harry Netzer on 7/11/19.
//  Copyright © 2019 Big Hike. All rights reserved.
//

import Foundation

// view model for the uitableviewcontroller
@objcMembers public class ListViewModel: NSObject {
    let pinModel: PinModelProtocol
    
    public init(pinModel: PinModelProtocol) {
        self.pinModel = pinModel
    }
    
    // configure a table view cell
    public func configure(cell: PinCell, forIndexPath: IndexPath) {
        let pin = pinModel.pins[forIndexPath.row]
        cell.nameLabel.text = pin.name
        cell.descLabel.text = pin.desc
    }
    
    // number of rows in the tableview
    public func countRows() -> Int {
        return pinModel.pins.count
    }
    
    // called when user deletes a row from the tableview
    public func deleteRowAt(indexPath: IndexPath) {
        pinModel.removePinAt(indexPath: indexPath)
    }
    
    // called when user fetches pins from the server
    public func resetPins() {
        pinModel.downloadPins()
    }
}
