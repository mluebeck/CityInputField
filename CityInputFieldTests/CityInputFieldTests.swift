//
//  CityInputFieldTests.swift
//  CityInputFieldTests
//
//  Created by Mario Rotz on 01.11.23.
//

import XCTest
@testable import CityInputField

final class CityInputFieldTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

     
    func test_openCVSFileAndGetCities() {
        let inputProcessor = CSVInputProcessor.init()
        do {
            let cities = try inputProcessor.open(file:"germany")
            XCTAssertTrue(cities.count>0,"loaded cities successfully")
            
        } catch {
            XCTAssertTrue(false,"input open error")
        }
    }
    
    func test_CityInputViewInit() {
        let civ = CityInputView(cities:[City]())
        XCTAssertNotNil(civ.cities)
        XCTAssertNotNil(civ.citiesSelectionList)
        XCTAssertNotNil(civ.inputField)
    }
    
    func test_CityInputViewInitWithNonzeroSize() {
        let civ = CityInputView(cities:[City](),frame: CGRect.init(x: 0, y: 0, width: 1000, height: 1000))
        XCTAssertEqual(civ.frame.width,1000)
        XCTAssertEqual(civ.frame.height,1000)
        XCTAssertEqual(civ.frame.origin.x,0)
        XCTAssertEqual(civ.frame.origin.y,0)

    }
    
    

}
