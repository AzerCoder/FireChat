//
//  AppStorybord.swift
//  FireChatX
//
//  Created by A'zamjon Abdumuxtorov on 11/03/24.
//

import UIKit

enum AppStorybord:String{
    case Main
    
    var inctanse: UIStoryboard{
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main )
    }
    
    func viewController<T:UIViewController>(viewControllerClass: T.Type, function: String = #function, line: Int = #line ) -> T{
        let storybordID = (viewControllerClass as UIViewController.Type).storybordID
        
        guard let scene = inctanse.instantiateViewController(withIdentifier: storybordID) as? T else{
            fatalError("ViewController with identifier not found")
        }
        
        return scene
    }
    
    func initialViewController()-> UIViewController?{
        return inctanse.instantiateInitialViewController()
    }
}
