//
//  UserModel.swift
//  UserDefults
//
//  Created by Чистяков Василий Александрович on 21.05.2021.
//

import UIKit

final class UserSetting {
    
    private enum SettingKeys: String {
        case userName
        case userModel
    }
    
    static var userModel: userModel! {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingKeys.userModel.rawValue) as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? userModel
            else {
                return nil
            }
            return decodedModel
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingKeys.userModel.rawValue
            
            if let userModel = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: userModel, requiringSecureCoding: false){
                    defaults.set(savedData, forKey: key)
                }
            }
        }
    }
    
    static var userName: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingKeys.userName.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingKeys.userName.rawValue
            if let name = newValue {
                print("value: \(name) was added to key \(key)")
                defaults.set(name, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}

