<span align="center">
  <br>
<img src="https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png" width="150">
  <br>
</span>

# PermissionsSwiftUI: A SwiftUI package to handle permissions

<img src="https://img.shields.io/github/workflow/status/jevonmao/PermissionsSwiftUI/Swift?label=CI%20Build"> <img src="https://img.shields.io/github/contributors/jevonmao/PermissionsSwiftUI"> <img src="https://img.shields.io/badge/License-MIT-blue.svg"> <img src="https://img.shields.io/github/issues/jevonmao/PermissionsSwiftUI"> <img src="https://img.shields.io/github/commit-activity/w/jevonmao/PermissionsSwiftUI?color=yellowgreen&logoColor=yellowgreen"> [![Codacy Badge](https://app.codacy.com/project/badge/Grade/6fe1a84c136b4a99823e7d71a8d08625)](https://www.codacy.com/gh/jevonmao/PermissionsSwiftUI/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=jevonmao/PermissionsSwiftUI&amp;utm_campaign=Badge_Grade)

`PermissionsSwiftUI` displays and handles permissions in SwiftUI. It is largely inspired by [SPPermissions](https://github.com/varabeis/SPPermissions).
The UI is highly customizable and resembles an **Apple style**. If you like the project, don't forget to `star ★` and follow me on GitHub. <br />
<img src="https://github.com/jevonmao/PermissionsSwiftUI/blob/main/Resources/Screenshot1.png" height="500"/>
&emsp; &emsp;
<img src="https://github.com/jevonmao/PermissionsSwiftUI/blob/main/Resources/Screenshot-dark.png" height="500"/> <br />
<p align="center"> PermissionsSwiftUI looks equally gorgeous on both ☀️light and 🌑dark mode. </p>

## Navigation
-  [Installation](#installation)
-  [Quickstart](#quickstart) 
-  [Usage](#usage)
    -  [Customize Permission Texts](#customize-permission-texts)
    -  [Customize header texts](#customize-header-texts)
    -  [`onAppear` and `onDisappear` Override](#onappear-and-ondisappear-override)
-  [Supported Permissions](#supported-permissions)
-  [Additional Information](#additional-information)
    -  [Acknowledgement](#acknowledgement)
    -  [License](#license)

## Installation
### Requirements
* iOS 13 or iPadOS 13
* Xcode 12 and Swift 5.3
* No tvOS, MacOS, and WatchOS support for now
### Install
You can install PermissionsSwiftUI into your Xcode project via Swift Package Manager. To learn more about Swift Package Manager, click [here](https://swift.org/package-manager/)
1. In Xcode, open your project and navigate to **File** → **Swift Packages** → **Add Package Dependency...**
2. Paste the repository URL (`https://github.com/jevonmao/PermissionsSwiftUI`) and click **Next**.
3. For **Version**, select **Up to next major**.
4. Click **Next** and click **Finish**.
5. You are all set, have fun using PermissionsSwiftUI!

## Quickstart
> Before you start, please `star ★` this repository. Your star is my biggest motivation to pull all-nighters and maintain this open source project.

### Modal Style
To use PermissionsSwiftUI to show a beauitful permission modal, simply add the `JMPermission`to any view. <br />
`.JMPermissions(showModal: $showModal, for: [.locationAlways, .photo, .microphone])`
Pass in a `Binding<Bool>` to show the modal view, and add whatever permissions you want to show.
```Swift
   struct ContentView: View {
       @State var showModal = false
       var body: some View {
           Button(action: {
               showModal=true
           }, label: {
               Text("Ask user for permissions")
           })
           .JMPermissions(showModal: $showModal, for: [.locationAlways, .photo, .microphone])
       }
   }
 ```
### Alert Style
<img src="https://github.com/jevonmao/PermissionsSwiftUI/blob/main/Resources/alert_view_screenshot.png?raw=true" height="400" align="left" />
The alert style is equally gorgeous, and allows for more versatile use. It is recommended when you have less than 3 permissions.  <br />
To show a permission pop up alert, use: 

```Swift
.JMAlert(showModal: $showModal, for: [.locationAlways, .photo])
```
Similar to the previous `JMPermissions`, you need to pass in a `Binding<Bool>` to show the view, and add whatever permissions you want to show.
<br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />

## Usage
### Customize Permission Texts
😱 Be aware. Features ahead will wow you - the customization is so advanced, yet so simple. Have fun!

To customize permission texts, use the modifier `setPermissionComponent()`
For example, you can change title, description, and image icon:
```Swift
.setPermissionComponent(for: .camera, 
                        image: AnyView(Image(systemName: "camera.fill")), 
                        title: "Camcorder",
                        description: "App needs to record videos")
```
and the result:
<div style="text-align:center">
<img src="https://github.com/jevonmao/PermissionsSwiftUI/blob/main/Resources/Screenshot-camera.png" height="70">
</div>
<br />
Or only change 1 of title and description:

```Swift
setPermissionComponent(for: .tracking, title: "Trackers")
```
```Swift
setPermissionComponent(for: .tracking, description: "Tracking description")
```

**Note:** 
* The parameters you don't provide will show the default text
* Add the `setPermissionComponent` modifier on your root level view, after `JMPermissions` modifier

The `image` parameter accepts **AnyView**, so feel free to use [SF Symbols](https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/) or your custom asset:
```Swift
.setPermissionComponent(for: .camera, 
                        image: AnyView(Image("Your-cool-image"))
```
Even full SwiftUI views will work😱:
```Swift
.setPermissionComponent(for: .camera, 
                        image: AnyView(YourCoolView())
```
You can use custom text and icon for all the supported permissions, with a single line of code.
### Customize Header Texts
To customize the header title, use the modifier `changeHeaderTo`:
<img align="right" src="https://github.com/jevonmao/PermissionsSwiftUI/blob/main/Resources/Header%20annotation.png?raw=true" alt="Annotated for headers screen" height="400" />
```Swift
.JMPermissions(showModal: $showModal, for: [.camera, .location, .calendar])
.changeHeaderTo("App Permissions")
```
To customize the header description, use the modifier `changeHeaderDescriptionTo`:
```Swift
.JMPermissions(showModal: $showModal, for: [.camera, .location, .photo])
.changeHeaderDescriptionTo("Instagram need certain permissions in order for all the features to work.")
```
To customize the bottom description, use the modifier `changeBottomDescriptionTo`:
```Swift
.JMPermissions(showModal: $showModal, for: [.camera, .location, .photo])
.changeBottomDescriptionTo("If not allowed, you have to enable permissions in settings")
```
### `onAppear` and `onDisappear` Override
You might find it incredibly useful to execute your code, or perform some update action when a PermissionsSwiftUI view appears and disappears. <br />
You can perform some action when PermissionsSwiftUI view appears or disappears by:
```Swift
.JMPermissions(showModal: $showModal, for: [.locationAlways, .photo, .microphone], onAppear: {}, onDisappear: {})
```
The `onAppear` and `onDisappear` **closure parameters will be executed** everytime PermissionsSwiftUI view **appears and disappears.** <br />
The same view modifier closure for state changes are available for the `JMAlert` modifier:
```Swift
.JMAlert(showModal: $showModal,
                     for: [.locationAlways, .photo],
                     onAppear: {print("Appeared")},
                     onDisappear: {print("Disappeared")})
```
<br /> <br /> <br />
## Supported Permissions
Here is a list of all permissions PermissionsSwiftUI already supports/will support. By the 0.0.1 beta release, PermissionsSwiftUI will have all 12 iOS system permissions built in. Yup, even the newest `tracking` permission for iOS 14 so you can stay on top of your game. All permissions in PermissionsSwiftUI come with a default name, description, and a stunning Apple native SF Symbols icon. Stay tuned!
<img align="center" src="https://github.com/jevonmao/PermissionsSwiftUI/blob/main/Resources/All-permissions-card.png" alt="A card of all the permissions" width="100%">

## Additional Information

### Acknowledgement
SPPermissions is in large a SwiftUI remake of famous Swift library **[SPPermissions](https://github.com/varabeis/SPPermissions)** by @verabeis. SPPermissions was initially created in 2017, and today on GitHub has over 4000 stars. PermissionsSwiftUI aims to deliver a just as beautiful and powerful library in SwiftUI. If you `star ★` my project PermissionsSwiftUI, be sure to checkout the original project SPPermissions where I borrowed the UI Design, some parts of README.md page, and important source code references along the way.
### License
PermissionsSwiftUI is created by Jingwen (Jevon) Mao and licensed under the [MIT License](https://jingwen-mao.mit-license.org)
