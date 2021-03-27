//
//  File.swift
//  
//
//  Created by Jevon Mao on 3/18/21.
//

import SwiftUI

// MARK: - Customize the button colors
/**
 `AllButtonColors` encapsulates the color configuration for all states of the allow button
    
 To customize button colors:
 1. Define a new instance of the `AllButtonColors` struct
 2. Add the `setAllowButtonColor(to colors:AllButtonColors)` modifier to your view
 3. Pass in the `AllButtonColors` struct previously into the proper parameter
 */
public struct AllButtonColors: Equatable {
    //MARK: Creating New Button Configs
    /**
     - parameters:
        - buttonIdle: The button color configuration for the default, idle state
        - buttonAllowed: The button color configuration for the highlighted, allowed state
        - buttonDenied: The button color configuration for the user explicitly denied state
     */
    public init(buttonIdle: ButtonColor, buttonAllowed: ButtonColor, buttonDenied: ButtonColor){
        self.init()
        self.buttonIdle = buttonIdle
        self.buttonAllowed = buttonAllowed
        self.buttonDenied = buttonDenied
    }
    /**
     - parameters:
        - buttonIdle: The button color configuration for the default, idle state
     */
    public init(buttonIdle: ButtonColor){
        self.init()
        self.buttonIdle = buttonIdle
    }
    /**
     - parameters:
        - buttonAllowed: The button color configuration for the highlighted, allowed state
     */
    public init(buttonAllowed: ButtonColor){
        self.init()
        self.buttonAllowed = buttonAllowed
    }
    /**
     - parameters:
        - buttonDenied: The button color configuration for the user explicitly denied state
     */
    public init(buttonDenied: ButtonColor){
        self.init()
        self.buttonDenied = buttonDenied
    }
    /**
     Initializes a new `AllbuttonColors` from the primary and tertiary colors
     
     Both `primaryColor` and `tertiaryColor` are non-required parameters. Colors without a given initializer parameter will be displayed with the default color.
     
     - parameters:
        - primaryColor: The primary color, characterized by the default blue
        - tertiaryColor: The tertiary color, characterized by the default alert red
     */
    public init(primaryColor: Color?=nil, tertiaryColor: Color?=nil){
        self.primaryColor = primaryColor ?? Color(.systemBlue)
        self.tertiaryColor = tertiaryColor ?? Color(.systemRed)
        self.buttonIdle = ButtonColor(foregroundColor: self.primaryColor,
                                      backgroundColor: Color(.systemGray5))
        self.buttonAllowed = ButtonColor(foregroundColor: Color(.white),
                                         backgroundColor: self.primaryColor)
        self.buttonDenied = ButtonColor(foregroundColor: Color(.white),
                                        backgroundColor: self.tertiaryColor)
    }
    
    //MARK: Button Color States
    
    @usableFromInline var primaryColor: Color
    var tertiaryColor: Color
    ///The button color configuration under idle status defined by a `ButtonColor` struct
    public var buttonIdle: ButtonColor
    ///The button color configuration under allowed status defined by a `ButtonColor` struct
    public var buttonAllowed: ButtonColor
    ///The button color configuration under denied status defined by a `ButtonColor` struct
    public var buttonDenied: ButtonColor
}
