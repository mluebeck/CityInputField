//
//  CSVInputProcessor.swift
//  CityInputField
//
//  Created by Mario Rotz on 01.11.23.
//

import Foundation

public class CSVInputProcessor {
    
    private func makeFileURL(named name: String, file: StaticString = #filePath) -> URL {
        let url = URL(fileURLWithPath: String(describing: file))
            .deletingLastPathComponent()
            .appendingPathComponent("\(name).csv")
        print(url)
        return url
    }
    
    func open(file:String) throws {
        let url = self.makeFileURL(named: file)
        guard let storedSnapshotData = try? Data(contentsOf: url) else {
            throw NSError()
        }
    }
    
}
