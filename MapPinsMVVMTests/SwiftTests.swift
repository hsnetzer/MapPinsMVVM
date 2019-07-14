//
//  SwiftTests.swift
//  MapPinsMVVMTests
//
//  Created by Harry Netzer on 7/14/19.
//  Copyright © 2019 Harry Netzer. All rights reserved.
//

import XCTest
@testable import MapPinsMVVM

class MapPinsMVVMTests: XCTestCase {
    var mapViewModel: MapViewModel?
    var listViewModel: ListViewModel?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let model = TestModel()
        model.downloadPins()
        mapViewModel = MapViewModel(pinModel: model)
        listViewModel = ListViewModel(pinModel: model)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // when we remove a cell from the list, the MapViewModel should reflect this
    func testPinRemoval() {
        guard let mapViewModel = mapViewModel, let listViewModel = listViewModel else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(listViewModel.countRows(), 5)
        
        let firstIndex = IndexPath(row: 0, section: 0)
        for _ in 0..<5 {
            let removedPin = listViewModel.deleteRowAt(indexPath: firstIndex)!
            XCTAssertEqual(mapViewModel.lastRemovedPinName(), removedPin.name)
        }
    }
}

class TestModel: PinModelProtocol {
    var pins = [Pin]()
    
    var lastRemoved: Pin?
    
    func removePinAt(indexPath: IndexPath) -> Pin? {
        lastRemoved = pins.remove(at: indexPath.row)
        return lastRemoved
    }
    
    func downloadPins() {
        let string = """
[{"id":1,"name":"Cadman Plaza Park","latitude":40.697817,"longitude":-73.990732,"description":"A nice park with an astro turf field in the area"},{"id":2,"name":"Borough Hall Station","latitude":40.693003,"longitude":-73.989809,"description":"Nearby subway station with access to the 2,3,4,5 subway lines"},{"id":3,"name":"Dos Toros","latitude":40.691832,"longitude":-73.991488,"description":"Credit card only Chipotle style Mexican food place."},{"id":4,"name":"Jay St. Metro Tech","latitude":40.691694,"longitude":-73.987472,"description":"Nearby subway stations with access to the A,C, and F subway lines."},{"id":5,"name":"Golden Fried Dumplings","latitude":40.690937,"longitude":-73.984563,"description":"Cash only super cheap hole in the wall authentic Chinese food."}]
"""
        guard let data = string.data(using: .utf8) else { return }
        guard let pins = try? JSONDecoder().decode([Pin].self, from: data) else { return }
        self.pins = pins
    }
    
    
}
