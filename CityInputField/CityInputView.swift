//
//  CityInputView.swift
//  CityInputField
//
//  Created by Mario Rotz on 01.11.23.
//

import UIKit

class CityInputView : UIView  {
    var cities : [City]
    var inputField = UITextField()
    var citiesSelectionList = UITableView()
    
    init(cities:[City],frame:CGRect = CGRect.zero) {
        self.cities = cities
        super.init(frame: frame)
        self.addSubview(inputField)
        self.addSubview(citiesSelectionList)
        self.citiesSelectionList.dataSource = self
    }
    
    public func typeInText(_ value : String) {
        self.inputField.text = value
        self.citiesSelectionList.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 100.0)
        self.citiesSelectionList.reloadData()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame:CGRect) {
        do {
            self.cities = try CSVInputProcessor().open(file: "germany")
        } catch {
            self.cities = [City]()
        }
        super.init(frame: frame)
        self.addSubview(inputField)
        self.addSubview(citiesSelectionList)
        self.citiesSelectionList.dataSource = self
    }
}

extension CityInputView : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

extension CityInputView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filteredCities = self.cities.filter(
            { $0.city.hasPrefix(self.inputField.text!)==true}
        )
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
