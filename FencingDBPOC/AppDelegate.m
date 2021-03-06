//
//  AppDelegate.m
//  FencingDBPOC
//
//  Created by CW on 6/9/16.
//  Copyright (c) 2016 Aniruddha. All rights reserved.
//

#import "AppDelegate.h"
#import <DropboxSDK/DropboxSDK.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([[DBSession sharedSession] handleOpenURL:url]) {
        if ([[DBSession sharedSession] isLinked]) {
            // At this point you can start making API Calls. Login was successful
            NSLog(@"AATA kay karu");
            
            [self hideHUDActivityIndicator];
        
        } else {
            // Login was canceled/failed.
            NSLog(@"AATA kay Gela Khadyat");
            
            [self hideHUDActivityIndicator];

        }
        return YES;
    }
    
    
    
    if ([url.absoluteString containsString:@"goomzee"]) {
        
        
        
        NSString * urlStr = [url absoluteString];
        
        NSArray * arr = [urlStr componentsSeparatedByString:@"e://"];
        
        NSString * newUrlStr = [NSString stringWithFormat:@"%@",[arr lastObject]];
        
        newUrlStr = [newUrlStr stringByReplacingOccurrencesOfString:@"?dl=0" withString:@"?dl=1"];
        
        if ([newUrlStr containsString:@":"]) {
            
        }
        else{
            
            NSMutableString *mu = [NSMutableString stringWithString:newUrlStr];
                [mu insertString:@":" atIndex:5];
            
            newUrlStr =  [[NSString alloc] initWithFormat:@"%@",mu];
            
        }
        
       
        
        self.currentURL = [NSURL URLWithString:newUrlStr];
        
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FileArrived" object:nil];

        return YES;
    }
    
    // Add whatever other url handling code your app requires here
    return NO;
}


- (void)showHUDActivityIndicator:(NSString *)message
{
    // Start Activity Indicator
    if (self.hudActivityIndicator == nil) {
        // Set an offset to allow interaction over teh navigation bar.
        self.hudActivityIndicator = [MBProgressHUD showHUDAddedTo:self.window.rootViewController.view animated:YES];
        [_hudActivityIndicator setLabelText:message];
    }
}


- (void)hideHUDActivityIndicator
{
    if (self.hudActivityIndicator) {
        [MBProgressHUD hideHUDForView:self.window.rootViewController.view animated:YES];
        self.hudActivityIndicator = nil;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
