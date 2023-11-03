//
//  CSVInputProcessor.swift
//  CityInputField
//
//  Created by Mario Rotz on 01.11.23.
//

import Foundation

public struct City {
    let city : String
    let latitude : Double
    let longitude : Double
    let country : String 
    let population : Int
    let density : Double
}

public class CSVInputProcessor {
    
    private func makeFileURL(named name: String, file: StaticString = #filePath) -> URL {
        let url = URL(fileURLWithPath: String(describing: file))
            .deletingLastPathComponent()
            .appendingPathComponent("\(name).csv")
        print(url)
        return url
    }
    
    func open(file:String) throws -> [City]{
        var cities = [City]()
        let url = self.makeFileURL(named: file)
        guard let storedSnapshotData = try? Data(contentsOf: url) else {
            throw NSError()
        }
        let str = String(decoding: storedSnapshotData, as: UTF8.self)
        let linesArray = str.components(separatedBy: CharacterSet(charactersIn: "\n"))
        linesArray.forEach
        {
            let array = $0.components(separatedBy: CharacterSet(charactersIn: ";"))
            if array.count > 10 {
                let city = City(city: array[0],
                                latitude: Double(array[2]) ?? 0.0,
                                longitude: Double(array[3]) ?? 0.0,
                                country:array[7] ,
                                population: Int(array[9]) ?? 0,
                                density:Double(array[10].replacingOccurrences(of: "\r", with: "")) ?? 0.0)
                cities.append(city)
            }
        }
        return cities
    }
    
}
