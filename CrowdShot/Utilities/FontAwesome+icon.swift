//
//  FontAwesome+icom.swift
//  CrowdShot
//
//  Created by Soni A on 13/02/2021.
//

//
//  FontAwesome+icon.swift
//  CrowdShot
//
//  Created by Soni A on 22/11/2020.
//  Copyright © 2020 Thoughtlights. All rights reserved.
//
import UIKit

public extension UIFont{
    class func iconFontOfSize(font: String, fontSize: CGFloat) -> UIFont {
        return UIFont(name: font, size: fontSize)!
    }
}

public extension String {
     static func fontAwesomeString(name: String) -> String {
        return fetchIconFontAwesome(name: name)
    }
}

public extension NSMutableAttributedString {
    static func fontAwesomeAttributedString(name: String, suffix: String?, iconSize: CGFloat, suffixSize: CGFloat?) -> NSMutableAttributedString {
        
        // Initialise some variables
        var iconString = fetchIconFontAwesome(name: name)
        var suffixFontSize = iconSize
        
        // If there is some suffix text - add it to the string
        if let suffix = suffix {
            iconString = iconString + suffix
        }
        
        // If there is a suffix font size - make a note
        if let suffixSize = suffixSize {
            suffixFontSize = suffixSize
        }
        
        // Build the initial string - using the suffix specifics
        let iconAttributed = NSMutableAttributedString(string: iconString, attributes: [NSAttributedString.Key.font:UIFont(name: "HelveticaNeue", size: suffixFontSize)!])
        
        // Add FontAwesome5 Pro family to icon attributes
        // FontAwesome5ProRegular
        // FontAwesome5ProLight
        // FontAwesome5ProSolid
        // FontAwesome5BrandsRegular
        
        iconAttributed.addAttribute(NSAttributedString.Key.font, value: UIFont.iconFontOfSize(font: "FontAwesome5ProRegular", fontSize: iconSize), range: NSRange(location: 0,length: 1))
        iconAttributed.addAttribute(NSAttributedString.Key.font, value: UIFont.iconFontOfSize(font: "FontAwesome5ProLight", fontSize: iconSize), range: NSRange(location: 0,length: 1))
        iconAttributed.addAttribute(NSAttributedString.Key.font, value: UIFont.iconFontOfSize(font: "FontAwesome5ProSolid", fontSize: iconSize), range: NSRange(location: 0,length: 1))
        return iconAttributed
    }
}

// -- Add Font Icons here --
func fetchIconFontAwesome(name: String) -> String {
    var returnValue = "\u{f059}"
    switch name {
    case "fa-heart": returnValue = "\u{f004}"
    case "fa-comment": returnValue = "\u{f4ad}"
    case "fa-share": returnValue = "\u{f064}"
 
        
    default:
        return returnValue
    }
    return returnValue
}

// Utlity method to check font family names
func confirmFonts() {
    for family:String in UIFont.familyNames {
        print("\(family)")
        for names:String in UIFont.fontNames(forFamilyName: family){
            print("==\(names)")
        }
    }
}

