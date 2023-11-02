//
//  CityInputView.swift
//  CityInputField
//
//  Created by Mario Rotz on 01.11.23.
//

import UIKit

class CityInputView : UIView {
    var cities : [City]
    var inputField = UITextField()
    var citiesSelectionList = UITableView()
        
    init(cities:[City],frame:CGRect = CGRect.zero) {
        self.cities = cities
        super.init(frame: frame)
        self.addSubview(inputField)
        self.addSubview(citiesSelectionList)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame:CGRect) {
        do {
            self.cities = try CSVInputProcessor().open(file: "german.csv")
        } catch {
            self.cities = [City]()
        }
        super.init(frame: frame)
        self.addSubview(inputField)
        self.addSubview(citiesSelectionList)
    }
}
