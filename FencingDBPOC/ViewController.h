//
//  ViewController.h
//  FencingDBPOC
//
//  Created by CW on 6/9/16.
//  Copyright (c) 2016 Aniruddha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropBoxManager.h"
#import "AppDelegate.h"
#import "HCDownloadViewController.h"
#import "DownloadedTableViewController.h"



@interface ViewController : UIViewController<DropBoxDelegate,HCDownloadViewControllerDelegate,UIDocumentInteractionControllerDelegate>
{
    DropBoxManager *objManager;
    NSString * currentPath;
    DownloadedTableViewController * downloadVC;
    
    NSURLSessionDownloadTask *download;

}

@property (nonatomic,weak) IBOutlet UIButton * dropBoxButton;
@property (nonatomic,weak) IBOutlet UIButton * logoutDropBoxButton;

@property (nonatomic,weak) IBOutlet UIButton * audioFileShareButton;
@property (nonatomic,weak) IBOutlet UIButton * videoFileShareButton;
@property (nonatomic,weak) IBOutlet UIButton * textFileShareButton;

@property (nonatomic, strong)NSURLSession *backgroundSession;


- (IBAction)btnUploadFileTapped:(id)sender;
- (IBAction)logoutDropBox:(id)sender;
- (IBAction)showDownloadedContent:(UIButton *)sender;


@end

