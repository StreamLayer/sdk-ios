//
//  main.m
//  StreamLayer-sample-Objective-C
//
//  Created by Alexander Kremenets on 27.01.2020.
//  Copyright © 2020 Alexander Kremenets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
  NSString * appDelegateClassName;
  @autoreleasepool {
      // Setup code that might create autoreleased objects goes here.
      appDelegateClassName = NSStringFromClass([AppDelegate class]);
  }
  return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
