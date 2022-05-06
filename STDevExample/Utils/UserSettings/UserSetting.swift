//
//  UserSettings.swift
//  STDevExample 
//
//  Created by enigma 2 on 2/15/1401 AP.
//

import Foundation


class UserSettings: NSObject {
    
    static let defualt = UserDefaults.standard
    
    static var username : String{
        set{
            defualt.setValue(newValue, forKey: "numberOfEntrance")
        }
        get{
            return defualt.string(forKey: "numberOfEntrance") ?? ""
        }
    }

    static var isLogin : Bool{
        set{
            defualt.setValue(newValue, forKey: "isLogin")
        }
        get{
            return defualt.bool(forKey: "isLogin")
        }
    }
    
}
