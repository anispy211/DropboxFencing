//
//  AppDelegate.h
//  FencingDBPOC
//
//  Created by CW on 6/9/16.
//  Copyright (c) 2016 Aniruddha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "HCDownload-master/HCDownloadViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MBProgressHUD * hudActivityIndicator;
@property (strong, nonatomic) HCDownloadViewController * dlvc;

@property (nonatomic,readwrite) NSURL * currentURL;


- (void) showHUDActivityIndicator:(NSString *)message;
- (void) hideHUDActivityIndicator;

@end

