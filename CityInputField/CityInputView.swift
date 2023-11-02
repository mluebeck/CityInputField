//
//  CityInputView.swift
//  CityInputField
//
//  Created by Mario Rotz on 01.11.23.
//

import UIKit

class CityInputView : UIView  {
    static let cellHeight = CGFloat(44)
    var cities : [City]
    var inputField = UITextField()
    var citiesSelectionList = UITableView()
    
    init(cities:[City],frame:CGRect = CGRect.zero) {
        self.cities = cities
        super.init(frame: frame)
        self.addSubview(inputField)
        self.addSubview(citiesSelectionList)
        self.citiesSelectionList.isHidden=true
        self.citiesSelectionList.dataSource = self
        self.citiesSelectionList.register(CityCell.self,forCellReuseIdentifier: "CityInputCell")
    }
    
    public func typeInText(_ value : String) {
        self.inputField.text = value
        self.citiesSelectionList.isHidden=(value.count==0)
        self.citiesSelectionList.reloadData()
        var height = CGFloat(self.citiesSelectionList.numberOfRows(inSection: 0)) * CityInputView.cellHeight
        if inputField.frame.size.height + height > self.frame.size.height {
            height = self.frame.size.height - inputField.frame.size.height
        }
        self.citiesSelectionList.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: height )
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
        self.citiesSelectionList.isHidden=true
        self.citiesSelectionList.dataSource = self
        self.citiesSelectionList.register(CityCell.self,forCellReuseIdentifier: "CityInputCell")
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CityInputCell", for: indexPath) as? CityCell {
            let filteredCities = self.cities.filter(
                { $0.city.hasPrefix(self.inputField.text!)==true}
            )
            cell.city?.text = filteredCities[indexPath.row].city
            return cell
        }
        else {
            let cell = CityCell.init(style: .default, reuseIdentifier: "CityInputCell")
            let filteredCities = self.cities.filter(
                { $0.city.hasPrefix(self.inputField.text!)==true}
            )
            cell.city?.text = filteredCities[indexPath.row].city
            return cell
        }
    }
}

class CityCell : UITableViewCell {
    var city : UILabel?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.city = UILabel()
        self.contentView.addSubview(self.city!)
        self.city?.frame = self.contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.city = UILabel()
        self.contentView.addSubview(self.city!)
        self.city?.frame = self.contentView.bounds
    }
}
