Pod::Spec.new do |s|
  s.name             = 'PermissionsSwiftUI'
  s.version          = '1.4.3'
  s.summary          = 'A SwiftUI package to beautifully display and handle permissions.'
 
  s.description      = <<-DESC
PermissionsSwiftUI can display either a modal or alert popover to show an interactive permissions request view with button. All the text and colors are highly configuration and customizable.
                       DESC
 
  s.homepage         = 'https://github.com/jevonmao/PermissionsSwiftUI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '<Jingwen Mao>' => '<woodburyjevonmao@gmail.com>' }
  s.source           = { :git => 'https://github.com/jevonmao/PermissionsSwiftUI.git', :tag => '1.4.0' }
  s.swift_version = '5.0'
  s.ios.deployment_target = '11.0'
  s.source_files = 'Sources/**/*.swift', 'Sources/**/**/*.swift', 'Sources/**/**/**/*.swift'
 
  s.dependency 'Introspect'
  s.dependency 'PermissionsSwiftUI/CorePermissionsSwiftUI'
end
