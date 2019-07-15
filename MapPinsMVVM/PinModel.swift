//
//  PinModel.swift
//  MapPinsMVVM
//
//  PinModel is the data source for the app. It conforms to PinModelProtocol to satisfy the needs to the view models of the app. 
//
//  Created by Harry Netzer on 7/11/19.
//  Copyright © 2019 Big Hike. All rights reserved.
//

import Foundation

public class PinModel: NSObject, PinModelProtocol {
    public var pins: [Pin] = []
    public var lastRemoved: Pin? = nil // for the mapview to know what pin was removed
    
    public override init() {
        super.init()
        
        if let pins = PinModel.pinsFromArchive() { // first try to open pins from saved archive
            self.pins = pins
        } else {
            downloadPins()
        }
    }
    
    // called when pins finish downloading
    func pinsDidDownload(_ pins: [Pin]) {
        self.pins = pins
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pinsDidDownload"), object: nil)
    }
    
    // called by the ListViewModel when it removes a pin from the list
    public func removePinAt(indexPath: IndexPath) {
        lastRemoved = pins.remove(at: indexPath.row)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pinWasDeleted"), object: nil)
    }
    
    // fetch pins from server
    public func downloadPins() {
        let sesh = URLSession(configuration: .ephemeral)
        let url = URL(string: "https://annetog.gotenna.com/development/scripts/get_map_pins.php")!
        
        let task = sesh.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                print("error fetching data")
                return
            }
            guard let pins = try? JSONDecoder().decode([Pin].self, from: data) else {
                print("error decoding data")
                return
            }
            DispatchQueue.main.async {
                self.pinsDidDownload(pins)
            }
        })
        task.resume()
    }
    
    // deserialize pins array from json archive
    static func pinsFromArchive() -> [Pin]? {
        guard let jsonPath = try? FileManager.default
            .url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("pins.json") else { return nil }
        guard let data = try? Data(contentsOf: jsonPath) else {
            print("couldn't get data")
            return nil
        }
        do {
            return try JSONDecoder().decode([Pin].self, from: data)
        } catch {
            return nil
        }
        
    }
    
    // serialize pins to json and archive to documents directory
    @objc @discardableResult public func saveChanges() -> Bool {
        guard let jsonPath = try? FileManager.default
            .url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("pins.json") else { return false }
        guard let json = try? JSONEncoder().encode(pins) else { return false }
        
        do {
            try json.write(to: jsonPath, options: .atomic)
            print("Saved items to: \(jsonPath.path)")
            return true
        } catch {
            print("error encoding json")
            return false
        }
    }
}

@objc public protocol PinModelProtocol {
    var pins: [Pin] { get }
    var lastRemoved: Pin? { get }
    
    func removePinAt(indexPath: IndexPath)
    func downloadPins()
}

public class Pin: NSObject, Codable {
    let id: Int
    var name: String
    let latitude: Double
    let longitude: Double
    let desc: String
    
    // needed because NSObject has a property called "description"
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case latitude
        case longitude
        case desc = "description"
    }
}
