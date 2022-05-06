//
//  StoryboardHandler.swift
//  STDevExample
//
//  Created by enigma 2 on 2/15/1401 AP.
//

import UIKit

class StoryboardHandler: NSObject {

    var storyboard: UIStoryboard?
    
    static let shared = StoryboardHandler()
    
    
    override init() {
        super.init()
        storyboard = UIStoryboard(name: "Main", bundle: nil)
    }
    
    func child(withIdentifier id: String) -> UIViewController? {
        return storyboard?.instantiateViewController(withIdentifier: id)
    }
    
}
