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
    var itemTapped : ((City) -> ())?
    
    var filteredCity : [City] {
        return self.cities.filter(
            { $0.city.hasPrefix(self.inputField.text!) }
        )
    }
    
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
        self.citiesSelectionList.isHidden=false
        if value.count == 0 || self.filteredCity.count == 0 {
            self.citiesSelectionList.isHidden=true
        }
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

extension CityInputView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.inputField.text = self.filteredCity[indexPath.row].city
        self.itemTapped?(self.filteredCity[indexPath.row])
    }
}

extension CityInputView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CityInputCell", for: indexPath) as? CityCell {
            cell.city?.text = self.filteredCity[indexPath.row].city
            return cell
        }
        else {
            let cell = CityCell.init(style: .default, reuseIdentifier: "CityInputCell")
            cell.city?.text = self.filteredCity[indexPath.row].city
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


