# Contributor's Guide - Adding New Permissions
> PermissionsSwiftUI offers incredible features, allowing developers to beautifully display and handle permissions in SwiftUI, in a easy-to-use yet unimaginable powerful way. Currently, PermissionsSwiftUI offers support for all 16 iOS system permissions, even the newest iOS 14.5 Tracking permission for developers to stay on the edge of Apple developer technologies. However, as Apple announces new software and operating systems over time, PermissionsSwiftUI will always have to keep up with the newest APIs which means possibly new system permissions that needs to be implemented. 

**The purpose of this guide is to offer a step-by-step, detailed instruction for contributors and the open source community on the process of adding a new permission support to PermissionsSwiftUI**.

## Prerequisites
This guide assumes you have a supported version of Xcode installed. This guide assumes you understand how to fork the project, git clone the repository, as well as other basic git operations. This guide assumes you have a basic knowledge of the file structure of Swift Package projects. 

However, ONLY BEGINNER LEVEL Swift programming experience is required.

## Step 1
Here I will use adding the Siri permission as a demonstration example. Let's imagine you just came across this amazing PermissionsSwiftUI library that will save you countless hours of coding work and presents your users a beautiful interface. You already have everything installed, and you begin to add a `JMModal` or `JMAlert` as shown in the quick start to show permission requests. But suddenly you realize the sad reality that PermissionsSwiftUI don't support the Siri permission, an critical part of your app. And instead of reaching out for the maintainer and creator, Jevon, for help, you decides to contribute to PermissionsSwiftUI and implement Siri permission.

First, add a new `.target` to the Package.swift file's `permissionsTargets` to configure SPM to recognize a new submodule for Siri permission.

<img width="2560" alt="image" src="https://user-images.githubusercontent.com/64660730/121992862-4c3f5580-cd57-11eb-9851-aa9b6209aa73.png">

## Step 2
Create a new folder under the Sources folder, and add new file named "JM\(Permission name)PermissionManager.swift", in this case "JMSiriPermissionManager.swift".

<img width="411" alt="image" src="https://user-images.githubusercontent.com/64660730/121993003-9294b480-cd57-11eb-9d13-8ff3f6058ccb.png">

## Step 3
Head over to the PermissionType.swift file, where you will find an enum called `PermissionType`. Scroll to bottom of page, add a new enum type for the permission. Don't forget to add documentation with /// slashes, and mark availability as needed.

<img width="407" alt="image" src="https://user-images.githubusercontent.com/64660730/121993195-e1dae500-cd57-11eb-93d3-37bb3df55762.png">

## Step 4
Google search for Apple documentation on the particular permission. You will need to locate the relevant framework, classes, and most importantly a function related to `AuthorizationStatus` and a function related to `requestAuthorization`.
Use the previously mentioned 2 functions to create a JMPermissionManager class that inherits from `PermissionType.PermissionManager` and provide concrete implementation for some of the parent's methods and properties.

In addition, provide an extension to `PermissionType.PermissionManager` to define a short name for the permission type like siri, to allow for enum like syntax access in the API.

Use the following example as template:

```swift
@available(iOS 13.0, tvOS 13.0, *)
public extension PermissionType.PermissionManager {
    static let siri = JMSiriPermissionManager()
}

@available(iOS 13.0, tvOS 13.0, *)
public final JMSiriPermissionManager: PermissionType.PermissionManager {
    
    
    public override var permissionType: PermissionType {
            .siri
    }
    
    public override var authorizationStatus: AuthorizationStatus {
        switch INPreferences.siriAuthorizationStatus() {
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }
    
    public override func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        INPreferences.requestSiriAuthorization {authorizationStatus in
            if authorizationStatus == .authorized {
                completion(true, nil)  //Authorized (true), no error
            }
            else {
                completion(false, nil)  //Not authorized (false), no error
            }
        }
    }
}
```

## Step 5
If you compile the library at this point, you will probably get errors from the PermissionComponentsStore file. Head over to the error source, and first add a new variable for the new permission to `PermissionComponentsStore`. The variable should be a `JMPermission` and now you get to choose a nice SFSymbol image, a title, and a description for this permission!

Then, scroll down in same file to an extension that contains function `getPermissionComponent`. Following the context code conventions and using existing code as template, implement the switch case for the new permission.

## Step 6
Just kidding, there is no step 6 😂! That's all there is to adding a brand new permission support to PermissionsSwiftUI library. Very simple and intuitive, right? Your contribution to PermissionsSwiftUI will be made available to thousands of developers using this library worldwide, I can't wait to see what permissions you implement in pull requests.
