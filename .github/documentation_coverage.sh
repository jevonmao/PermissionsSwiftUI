#!/bin/sh

percentage=$(jazzy --module CorePermissionsSwiftUI --swift-build-tool xcodebuild --build-tool-arguments -scheme,PermissionsSwiftUI,-sdk,iphoneos --author 'Jevon Mao' --author_url https://jingwen-mao.mit-license.org/ | tail -4 | head -n 1 | cut -d " " -f1
)
if test "${percentage%?}" == "100"
then
	echo "Documentation coverage 100%, test passed."
else
    echo "Documentation coverage is $percentage%, which is below 100%, test failed."
	exit 1
fi
