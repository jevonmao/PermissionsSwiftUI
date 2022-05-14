#!/bin/sh

percentage=$(jazzy --module CorePermissionsSwiftUI --swift-build-tool xcodebuild --build-tool-arguments -scheme,PermissionsSwiftUI,-sdk,iphoneos,-destination,id=6D8B3936-07C0-4F7D-8ADB-81B3E5BC4112,-verbose --author 'Jevon Mao' --author_url https://jingwen-mao.mit-license.org/ | tail -4 | head -n 1 | cut -d " " -f1
)

#if [ $? -eq 0 ]
#then
#    echo "/var/folders/24/"
if test "${percentage%?}" == "100"
then
	echo "Documentation coverage 100%, test passed."
else
    echo "Documentation coverage is $percentage%, which is below 100%, test failed."
	exit 1
fi
