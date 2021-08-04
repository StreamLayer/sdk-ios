## Swift sample app
### Bootstrap
Check the [Makefile](Makefile) for available commands to bootstrap the project.  

### Other prerequisites
```bash
# Check Swift version, it should match the following:
$ carthage swift-version
5.4.2+8078d64771bb12a43bd33ed1fcba81b4
```

## Steps

1. Launch `make` command for install all dependencies

`make`

2. After pod install it will lauch the app SwiftDemo.xcodeproj. We should close xcode.
3. Then open `SwiftDemo.xcworkspace` instead.
4. Open the Info.plst (SwiftDemo->Targets(Demo)->Info) and change the sdkKey variable on your auth key. (replave ${key} on your key string)

