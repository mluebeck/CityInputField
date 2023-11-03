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
        civ.typeInText("Lüb")
        XCTAssertTrue(civ.inputField.text!.count ==  3 )
        XCTAssertTrue(civ.citiesSelectionList.frame.size.height>0 )
    }
    
    func test_CityInputView_TextFieldIsNotEmptyAndListIsNonZero() {
        let civ = CityInputView(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 1000))
        
        XCTAssertTrue(civ.cities.count>0)
        let text = "Lüb"
        civ.typeInText(text)
        XCTAssertTrue(civ.inputField.text!.count ==  text.count )
        XCTAssertTrue(civ.citiesSelectionList.numberOfRows(inSection: 0) == 4 )  // 6 Cities in Germany starts with "Be"
    }
    
    func test_CityInputView_ListVisibilityOn() {
        let civ = CityInputView(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 1000))
        XCTAssertTrue(civ.cities.count>0)
        let text = "Be"
        civ.typeInText(text)
        XCTAssertTrue(civ.citiesSelectionList.isHidden==false)
    }
    
    func test_CityInputView_CityNonExistent() {
        let civ = CityInputView(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 1000))
        XCTAssertTrue(civ.cities.count>0)
        let text = "BerlinerSchnauzeStadt"
        civ.typeInText(text)
        XCTAssertTrue(civ.citiesSelectionList.isHidden==true)
    }
    
    func test_CityInputView_ListVisibilityOff() {
        let civ = CityInputView(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 1000))
        XCTAssertTrue(civ.cities.count>0)
        XCTAssertTrue(civ.citiesSelectionList.isHidden==true)
    }
    
    func test_CityInputView_TableViewHeightWhenOnlyOneElement() {
        let civ = CityInputView(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 1000))
        XCTAssertTrue(civ.cities.count>0)
        let text = "Berlin"
        civ.typeInText(text)
        XCTAssertTrue(civ.citiesSelectionList.frame.size.height == CityInputView.cellHeight)
    }
    func test_CityInputView_TableViewHeightWhenMultipleElement() {
        let civ = CityInputView(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 1000))
        XCTAssertTrue(civ.cities.count>0)
        let text = "Lüb"
        civ.typeInText(text)
        let count = civ.filteredCity.count
        XCTAssertTrue(civ.citiesSelectionList.frame.size.height == CityInputView.cellHeight*CGFloat(count))
    }
    
    func test_CityInputView_TableViewHeightWhenMoreElementsThanCanBeVisible() {
        let civ = CityInputView(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 1000))
        XCTAssertTrue(civ.cities.count>0)
        let text = "B"
        civ.typeInText(text)
        XCTAssertTrue(CGFloat(civ.citiesSelectionList.numberOfRows(inSection: 0))*CityInputView.cellHeight>1000.0)
        XCTAssertEqual(civ.citiesSelectionList.frame.size.height,CGFloat(1000.0-civ.inputField.frame.size.height))
    }
    
    func test_CityInputView_TableViewCellHasCityText() {
        let civ = CityInputView(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 1000))
        XCTAssertTrue(civ.cities.count>0)
        let text = "Berlin"
        civ.typeInText(text)
        let cell = civ.tableView(civ.citiesSelectionList, cellForRowAt: IndexPath.init(row: 0, section: 0)) as! CityCell
        XCTAssertEqual(text, cell.city!.text)
    }
    
    
    
    func test_citySelection() {
        let civ = CityInputView(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 1000))
        XCTAssertTrue(civ.cities.count>0)
        let text = "Berlin"
        var cityResult : String?
        let exp = expectation(description: "Wait for   completion")

        civ.typeInText(text)
        civ.itemTapped = {
            city in
            cityResult = city.city
            exp.fulfill()
        }
        if civ.filteredCity.count > 0 {
            civ.tableView(civ.citiesSelectionList, didSelectRowAt: IndexPath.init(row: 0, section: 0))
        } else {
            exp.fulfill()
        }
        wait(for: [exp], timeout:1.0)
        if let c = cityResult {
            XCTAssertEqual(c, text, "Selected city should match")
            XCTAssertEqual(civ.inputField.text!, c, "Selected city should match input field")
        } else {
            XCTAssertTrue(civ.filteredCity.count>0,"City should exist.")
        }
    }
    
    
    //MARK: Helper methods
    private func makeSUT() -> CityViewController {
        let controller = CityViewController()
        controller.loadViewIfNeeded()
        return controller
    }

}
