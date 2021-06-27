//
//  File.swift
//  
//
//  Created by Jevon Mao on 4/11/21.
//

import UIKit

extension UIColor{
    static var systemGray2: UIColor {
        get {
            if #available(iOS 13.0, *) {
                return UIColor(red: 0.68, green: 0.68, blue: 0.7, alpha: 1)
            }
            return UIColor.clear
        }
    }
    static var systemGray4: UIColor {
        get {
            if #available(iOS 13.0, *) {
                return UIColor(red: 0.82, green: 0.82, blue: 0.84, alpha: 1)
            }
            return UIColor.clear
            
        }
    }
    static var systemGray5: UIColor {
        get {
        if #available(iOS 13.0, *) {
            return UIColor(red: 0.9, green: 0.9, blue: 0.92, alpha: 1)
        }
            return UIColor.clear
        }
    }
    static var secondarySystemBackground: UIColor {
        get {
            if #available(tvOS 13.0, iOS 13.0, *) {
                return UIColor { (traits) -> UIColor in
                    return traits.userInterfaceStyle == .dark ?
                        UIColor(red: 0.11, green: 0.11, blue: 0.12, alpha: 1) :
                        UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)
                }
            } else {
                return UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)
            }
        }
    }
    static var systemBackground: UIColor {
        get {
            if #available(tvOS 13.0, iOS 13.0, *) {
                return UIColor { (traits) -> UIColor in
                    return traits.userInterfaceStyle == .dark ?
                        UIColor(red: 0, green: 0, blue: 0, alpha: 1) :
                        UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                }
            } else {
                return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
    }
}
