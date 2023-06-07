all: prepare_xcode_project

prepare_xcode_project:
	xcodegen

cleanup:
	rm -rf Carthage/Build
	rm -rf Frameworks/*

.PHONY: all prepare_xcode_project cleanup