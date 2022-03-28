//
//  CommonClass.swift
//  tentwentyTest
//
//  Created by admin on 28/03/2022.
//

import Foundation
import UIKit

class CommonClass{
    //shared instanse
    static let sharedInstance = CommonClass()
    var activeOrder : Bool = false
    var filters = [String : Any]()
    var orderStatus : String?
    var orderimage : String?
    var isNotification : Bool = false
    var postImages = [UIImage]()
    //Alert function
func showAlert(message: String,vc:UIViewController) {
    let alertController = UIAlertController (title: NSLocalizedString("Alert!", comment: ""), message: message, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { (action) -> Void in
        return
    }
    
    alertController.addAction(okAction)
    vc.present(alertController, animated: true, completion: nil);
}
    func presentDetail(presentingViewController: UIViewController,viewControllerToPresent: UIViewController) {
            let transition = CATransition()
            transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        presentingViewController.view.window!.layer.add(transition, forKey: kCATransition)

        presentingViewController.present(viewControllerToPresent, animated: false)
        }
    func presentDetailFromLeft(presentingViewController: UIViewController,viewControllerToPresent: UIViewController) {
            let transition = CATransition()
            transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        presentingViewController.view.window!.layer.add(transition, forKey: kCATransition)

        presentingViewController.present(viewControllerToPresent, animated: false)
        }
    func dismissDetail(dismissingViewController:UIViewController) {
           let transition = CATransition()
           transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        dismissingViewController.view.window!.layer.add(transition, forKey: kCATransition)

        dismissingViewController.dismiss(animated: false)
       }
    
    func showToast(message : String, font: UIFont = .systemFont(ofSize: 12.0),vc:UIViewController) {

        let toastLabel = UILabel(frame: CGRect(x: vc.view.frame.size.width/2 - 75, y: vc.view.frame.size.height-100, width: 300, height: 35))
        toastLabel.center.x = vc.view.center.x
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.adjustsFontSizeToFitWidth = true
        toastLabel.clipsToBounds  =  true
        vc.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.3, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    func checkTextSufficientComplexity(value text : String) -> Bool{
        
        
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: text)
        print("\(capitalresult)")
        
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: text)
        print("\(numberresult)")
        
        
        let specialCharacterRegEx  = ".*[!&^%$#@()/]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        
        let specialresult = texttest2.evaluate(with: text)
        print("\(specialresult)")
        
        return capitalresult && numberresult && specialresult
        
    }

    func randomString(length: Int) -> String {

        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)

        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }

        return randomString
    }
}
extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
