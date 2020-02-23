all: prepare_carthage prepare_xcode_project

prepare_carthage:
	carthage build

prepare_xcode_project:
	xcodegen

cleanup:
	rm -rf Carthage/Build

.PHONY: all prepare_carthage prepare_xcode_project cleanup
