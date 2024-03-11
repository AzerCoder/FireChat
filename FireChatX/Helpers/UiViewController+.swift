//
//  UiViewController+.swift
//  FireChatX
//
//  Created by A'zamjon Abdumuxtorov on 11/03/24.
//

import UIKit

extension UIViewController{
    
    class var storybordID: String{
        return "\(self)"
    }
    
    static func instantiate(from : AppStorybord) -> Self {
        return from.viewController(viewControllerClass: self)
    }
    
    func vcSceneDelegate() -> SceneDelegate? {
        return self.view.window?.windowScene?.delegate as? SceneDelegate
    }
    
    func showAlertAction(title: String){
        let alert = UIAlertController(title: "Error occored", message: title, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: false, completion: nil)
    }
}
