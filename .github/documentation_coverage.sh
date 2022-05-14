#!/bin/sh

percentage=$(jazzy --module CorePermissionsSwiftUI --swift-build-tool xcodebuild --build-tool-arguments -scheme,PermissionsSwiftUI,-sdk,iphoneos,-destination,id=A06F71FC-0B53-4741-AD85-D237B6FB06A0,-verbose --author 'Jevon Mao' --author_url https://jingwen-mao.mit-license.org/ | tail -4 | head -n 1 | cut -d " " -f1
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
