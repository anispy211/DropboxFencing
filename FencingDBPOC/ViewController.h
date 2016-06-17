//
//  ViewController.h
//  FencingDBPOC
//
//  Created by CW on 6/9/16.
//  Copyright (c) 2016 Aniruddha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropBoxManager.h"

@interface ViewController : UIViewController<DropBoxDelegate>
{
    DropBoxManager *objManager;
}

@property (nonatomic,weak) IBOutlet UIButton * dropBoxButton;
@property (nonatomic,weak) IBOutlet UIButton * logoutDropBoxButton;

@property (nonatomic,weak) IBOutlet UIButton * audioFileShareButton;
@property (nonatomic,weak) IBOutlet UIButton * videoFileShareButton;
@property (nonatomic,weak) IBOutlet UIButton * textFileShareButton;


-(IBAction)btnUploadFileTapped:(id)sender;
- (IBAction)logoutDropBox:(id)sender;


@end

