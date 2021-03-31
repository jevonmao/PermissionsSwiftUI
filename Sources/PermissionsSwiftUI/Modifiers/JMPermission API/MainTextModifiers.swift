//
//  MainTextModifiers.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import SwiftUI

// MARK: Configure Header and Description Texts
public extension CustomizableView {
    /**
     Displays a customized main header text
     
     The default header text is **Need Permissions**
     
     - Parameter _: The custom text to change to
     */
    
    @inlinable func changeHeaderTo(_ text:String) -> some CustomizableView {
        store.configStore.mainTexts.headerText = text
        return self
    }
    /**
     Displays a customized header description text
     
     The default header text is:
     ```
     In order for you use certain features of this app, you need to give permissions. See description for each permission
     ```
     
     - Parameter _: The custom text to change to
     */
    
    @inlinable func changeHeaderDescriptionTo(_ text:String) -> some CustomizableView {
        store.configStore.mainTexts.headerDescription = text
        return self
    }
    /**
     Displays a customized bottom header description text
     
     The default bottom header text is:
     ```
     Permission are necessary for all the features and functions to work properly. If not allowed, you have to enable permissions in settings
     ```
     
     - Parameter _: The custom text to change to
     */
    
    @inlinable func changeBottomDescriptionTo(_ text:String) -> some CustomizableView {
        store.configStore.mainTexts.bottomDescription = text
        return self
    }
}

