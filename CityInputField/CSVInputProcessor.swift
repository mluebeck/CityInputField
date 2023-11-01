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
        let array = str.components(separatedBy: CharacterSet(charactersIn: ";\r\n"))
        array.enumerated().forEach {
            if $0.offset % 11 == 0 && $0.offset>0 {
                let city = City(city: array[$0.offset-11],
                                latitude: Double(array[$0.offset-9]) ?? 0.0,
                                longitude: Double(array[$0.offset-8]) ?? 0.0,
                                country:array[$0.offset-4] ,
                                population: Int(array[$0.offset-2]) ?? 0,
                                density:Double(array[$0.offset-1]) ?? 0.0)
                cities.append(city)
            }
        }
        return cities
    }
    
}
