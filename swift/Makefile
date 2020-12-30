all: prepare_carthage prepare_xcode_project pods

prepare_carthage:
	carthage bootstrap --platform iOS

prepare_xcode_project:
	xcodegen

pods:
	pod install

cleanup:
	rm -rf Carthage/Build

.PHONY: all prepare_carthage prepare_xcode_project cleanup pods
