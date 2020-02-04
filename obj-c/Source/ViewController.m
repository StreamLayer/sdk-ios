//
//  ViewController.m
//  StreamLayer-sample-Objective-C
//
//  Created by Alexander Kremenets on 27.01.2020.
//  Copyright © 2020 Alexander Kremenets. All rights reserved.
//

#import "ViewController.h"
#import <StreamLayer/StreamLayer-Swift.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setViewGuide:[[UIView alloc] init]];
  [self setOverlayVC:[StreamLayer createOverlay:[self viewGuide] overlayDelegate:self sdkKey:@"key"]];

  // Do any additional setup after loading the view.
}


- (void)disableAudioDucking {
  
}

- (void)disableAudioSessionFor:(enum SLRAudioSessionType)type {
  
}

- (void)prepareAudioSessionFor:(enum SLRAudioSessionType)type {
  
}

- (void)requestAudioDucking {
  
}

@end
