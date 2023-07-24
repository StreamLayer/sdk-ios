all: prepare_xcode_project pods

prepare_xcode_project:
	xcodegen

cleanup:
	rm -rf Carthage/Build
	rm -rf Frameworks/*

pods:
	pod install

.PHONY: all prepare_xcode_project cleanup pods