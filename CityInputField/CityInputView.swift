//
//  CityInputView.swift
//  CityInputField
//
//  Created by Mario Rotz on 01.11.23.
//

import UIKit

class CityInputView : UIView , UITextFieldDelegate {
    var cities : [City]
    var inputField = UITextField()
    var citiesSelectionList = UITableView()
        
    init(cities:[City],frame:CGRect = CGRect.zero) {
        self.cities = cities
        super.init(frame: frame)
        self.addSubview(inputField)
        self.addSubview(citiesSelectionList)
    }
    
    public func typeInText(_ value : String) {
        self.inputField.text = value
        self.citiesSelectionList.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 100.0)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
