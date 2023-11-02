//
//  CityViewController.swift
//  CityInputField
//
//  Created by Mario Rotz on 02.11.23.
//

import UIKit

public class CityViewController : UIViewController {
    var cityInputView : CityInputView?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        let cityInputView = CityInputView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80.0))
        self.view.addSubview(cityInputView)
        self.cityInputView = cityInputView
    }
}
