//
//  ViewController.swift
//  UserDefults
//
//  Created by Чистяков Василий Александрович on 21.05.2021.
//

import UIKit

enum SexType: String {
    case male
    case female
}

class userModel: NSObject, NSCoding {

    
    let name: String
    let surname: String
    let city: String
    let sex: SexType
    
    init(name: String, surname: String, city: String, sex: SexType) {
        self.name = name
        self.surname = surname
        self.city = city
        self.sex = sex
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name,forKey: "name")
        coder.encode(surname,forKey: "surname")
        coder.encode(city,forKey: "city")
        coder.encode(sex.rawValue,forKey: "sex")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? " "
        surname = coder.decodeObject(forKey: "surname") as? String ?? " "
        city = coder.decodeObject(forKey: "city") as? String ?? " "
        sex = SexType(rawValue: coder.decodeObject(forKey: "sex") as! String) ?? SexType.male
        
    }
}

class ViewController: UIViewController {
    
    let cities = ["Москва","Санкт-Петербург","Казань","Рязань","Коломна"]
    let sexArray = ["Мужской", "Женский"]
    var pickedCity: String?
    var pickedSex: SexType?
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldSurname: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    @IBAction func textFieldNameAction(_ sender: UITextField) {
        print(textFieldName.text)
    }
    
    @IBAction func textFieldSurname(_ sender: UITextField) {
        print(textFieldSurname.text)
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            pickedSex = .male
        case 1:
            pickedSex = .female
        default:
            break
        }
        let nameTrimmingText = textFieldName.text!.trimmingCharacters(in: .whitespaces)
        let surnameTrimmingText = textFieldSurname.text!.trimmingCharacters(in: .whitespaces)
        print(nameTrimmingText)
        print(surnameTrimmingText)
        
        guard let pickedCity = pickedCity, let pickedSex = pickedSex else { return }
        let userObject = userModel(name: nameTrimmingText, surname: surnameTrimmingText, city: pickedCity, sex: pickedSex)
        print(userObject)
        
        UserSetting.userName = nameTrimmingText
        UserSetting.userModel = userObject
        print(UserSetting.userModel )
        print(UserSetting.userName)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        cities.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let city = cities[row]
        return city
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedCity = cities[row]
        print(pickedCity)
        
    }
}
