//
//  AppTheme.swift
//  CrowdShot
//
//  Created by Soni A on 06/12/2020.
//  Copyright © 2020 Thoughtlights. All rights reserved.
//

import UIKit

struct AppTheme {
    
    enum Colors {
        case colorPrimary
        case colorPrimaryDark
        case colorAccent
        case colorGreenAction
        case trackOnTintColor
        case darkOrange
        case transparentPurple
        case transparentGrey
       
        var color: UIColor {
            switch self {
            case .colorPrimary: return UIColor(red:0.45, green:0.15, blue:0.66, alpha:1.00)
            case .colorPrimaryDark: return UIColor(red:0.32, green:0.10, blue:0.60, alpha:1.00)
            case .colorAccent: return UIColor(red:0.91, green:0.12, blue:0.39, alpha:1.00)
            case .colorGreenAction: return UIColor(red:0.11, green:0.68, blue:0.00, alpha:1.00)
            case .trackOnTintColor: return UIColor(red:0.84, green:0.74, blue:0.90, alpha:1.00)
            case .darkOrange: return UIColor(red:1.00, green:0.32, blue:0.00, alpha:1.00)
            case .transparentPurple: return UIColor(red:0.72, green:0.54, blue:0.74, alpha:0.6)
            case .transparentGrey: return UIColor(white: 0.5, alpha: 0.4)
            }
        }
    }
    
    enum UIComponents {
        case trackOnTintColor
        case trackThumbColor
        
        var color:UIColor{
            switch self {
               case .trackOnTintColor: return UIColor(red:0.84, green:0.74, blue:0.90, alpha:1.00)
               case .trackThumbColor: return UIColor(red:0.45, green:0.15, blue:0.66, alpha:1.00)
            }
        }
    }
     
    enum Fonts {
        case titleFont
        case boldTitleFont
        case smallTitleFont
        
        var font: UIFont {
            switch self {
            case .smallTitleFont: return UIFont.systemFont(ofSize: 13)
            case .titleFont: return UIFont.systemFont(ofSize: 14)
            case .boldTitleFont: return UIFont.systemFont(ofSize: 20)
            }
        }
    }
}

// Darker ring color
// -- UIColor(red:0.27, green:0.10, blue:0.47, alpha:1.00)

// Mid Color
// -- UIColor(red:0.53, green:0.38, blue:0.57, alpha:1.00)

// Light tone
// -- UIColor(red:0.53, green:0.38, blue:0.57, alpha:1.00)

// Lightest tone
// -- UIColor(red:0.85, green:0.79, blue:0.87, alpha:1.00)

// Dark grey
// -- UIColor(red:0.22, green:0.22, blue:0.22, alpha:1.00)
