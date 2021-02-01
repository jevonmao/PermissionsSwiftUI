# PermissionsSwiftUI: A SwiftUI package to handle permissions
> A simple, highly-customizable package to handle permissions. In native SwiftUI.

- [Quickstart](#quickstart) 
- [Usage](#usage)
- [License](#license)

## About
`PermissionsSwiftUI` is a SwiftUI API to ask for user permissions using Swift. The user will be presented a modal to handle permissions.

The UI/UX is highly customizable and resembles an **Apple style**.

If you like the project, don't forget to `put star ★` and follow me on GitHub. 
<img src="https://github.com/jevonmao/PermissionsSwiftUI/blob/main/Resources/Screenshot1.png" height="500"/>
&emsp; &emsp;
<img src="https://github.com/jevonmao/PermissionsSwiftUI/blob/main/Resources/Screenshot-dark.png" height="500"/> <br />
<p align="center"> PermissionsSwiftUI looks equally gorgeous on both ☀️light and 🌑dark mode. </p>

## Quickstart
To use PermissionsSwiftUI, simply add the `JMPermission` modifier to any view. <br />
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
## Usage

## License
PermissionsSwiftUI is created by Jingwen (Jevon) Mao and licensed under the [MIT License](https://jingwen-mao.mit-license.org)
