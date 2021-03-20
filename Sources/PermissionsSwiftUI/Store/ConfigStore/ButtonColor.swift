//
//  File.swift
//  
//
//  Created by Jevon Mao on 3/18/21.
//

import SwiftUI

/**
 `ButtonColor` represents the color configuration for the allow button in a single state
  
  Declared within parent struct  `AllButtonColors` and should only be used within a `AllButtonColors` struct instance.
  To customize
 */
public struct ButtonColor: Equatable {
    // MARK: Creating New Button Color
    /**
     - parameters:
        - foregroundColor: The color of type `Color` for the foreground text
        - backgroundColor: The color of type `Color` for the background
     */
    public init(foregroundColor: Color, backgroundColor: Color){
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
    //MARK: Properties
    ///The color of type `Color` for the foreground text
    public var foregroundColor: Color 
    ///The color of type `Color` for the foreground text
    public var backgroundColor: Color

}

