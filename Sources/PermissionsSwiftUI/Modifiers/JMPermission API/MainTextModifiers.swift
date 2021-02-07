//
//  MainTextModifiers.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import SwiftUI

// MARK: Header text
public extension View{
    /**
     Displays a customized main header text
     
     The default header text is **Need Permissions**
     
     - Parameter _: The custom text to change to
     */
    
    func changeHeaderTo(_ text:String) -> some View{
        PermissionStore.shared.updateStore(property: {$0.mainTexts.headerText=$1}, value: text)

        return self
    }
}

// MARK: Header description text
public extension View{
    /**
     Displays a customized header description text
     
     The default header text is:
     ```
     In order for you use certain features of this app, you need to give permissions. See description for each permission
     ```
     
     - Parameter _: The custom text to change to
     */
    
    func changeHeaderDescriptionTo(_ text:String) -> some View{
        PermissionStore.shared.updateStore(property: {$0.mainTexts.headerDescription=$1}, value: text)

        return self
    }
}

// MARK: Bottom description text
public extension View{
    /**
     Displays a customized bottom header description text
     
     The default bottom header text is:
     ```
     Permission are necessary for all the features and functions to work properly. If not allowed, you have to enable permissions in settings
     ```
     
     - Parameter _: The custom text to change to
     */
    
    func changeBottomDescriptionTo(_ text:String) -> some View{
        PermissionStore.shared.updateStore(property: {$0.mainTexts.bottomDescription=$1}, value: text)
        return self
    }
}

