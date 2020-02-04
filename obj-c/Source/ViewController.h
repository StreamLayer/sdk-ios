//
//  ViewController.h
//  StreamLayer-sample-Objective-C
//
//  Created by Alexander Kremenets on 27.01.2020.
//  Copyright © 2020 Alexander Kremenets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StreamLayer/StreamLayer.h>

@interface ViewController : UIViewController <SLROverlayDelegate>

@property (strong, nonatomic) OverlayViewController * overlayVC;
@property (strong, nonatomic) UIView * viewGuide;

@end

