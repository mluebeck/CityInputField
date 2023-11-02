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
    
    func test_CityInputViewEmbedInViewcontroller() {
        let sut = makeSUT()
        if let cityInputView = sut.cityInputView {
            XCTAssertEqual(cityInputView.frame.size.height, 80.0)
            XCTAssertEqual(cityInputView.frame.size.width, sut.view.frame.size.width)
            XCTAssertEqual(cityInputView.frame.origin.x,0)
            XCTAssertEqual(cityInputView.frame.origin.y,0)
        } else {
            XCTAssertTrue(false)
        }
    }
    
    func test_CityInputViewHasSubviews() {
        let civ = CityInputView(cities:[City](),frame: CGRect.init(x: 0, y: 0, width: 1000, height: 1000))
        XCTAssertEqual(civ.subviews.count, 2)
    }
    
    func test_CityInputView_TextFieldIsEmptyAndListIsEmpty() {
        let civ = CityInputView(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 1000))
        XCTAssertEqual(civ.inputField.text!.count , 0 )
        XCTAssertEqual(civ.citiesSelectionList.frame.size.height, 0 )
    }
    
    func test_CityInputView_TextFieldIsNotEmptyAndListHeightNonZero() {
        let civ = CityInputView(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 1000))
        civ.typeInText("Ber")
        XCTAssertTrue(civ.inputField.text!.count ==  3 )
        XCTAssertTrue(civ.citiesSelectionList.frame.size.height>0 )
    }
    
    func test_CityInputView_TextFieldIsNotEmptyAndListIsNonZero() {
        let civ = CityInputView(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 1000))
        
        XCTAssertTrue(civ.cities.count>0)
        let text = "Be"
        civ.typeInText(text)
        XCTAssertTrue(civ.inputField.text!.count ==  text.count )
        XCTAssertTrue(civ.citiesSelectionList.numberOfRows(inSection: 0) == 6 )  // 6 Cities in Germany starts with "Be"
    }
    
    //MARK: Helper methods
    private func makeSUT() -> CityViewController {
        let controller = CityViewController()
        controller.loadViewIfNeeded()
        return controller
    }

}
