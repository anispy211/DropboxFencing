//
//  ViewController.m
//  FencingDBPOC
//
//  Created by CW on 6/9/16.
//  Copyright (c) 2016 Aniruddha. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    objManager = [DropBoxManager dropBoxManager];
    objManager.apiCallDelegate =self;
    [objManager initDropbox];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setupButtonsState];
}

- (void)setupButtonsState
{
    if ([objManager isLinkedDB])
    {
        [self.dropBoxButton setTitle:@"DropBox Connected" forState:UIControlStateNormal];
        [self.dropBoxButton setBackgroundColor:[UIColor lightGrayColor]];
        [self.dropBoxButton.titleLabel setTextColor:[UIColor redColor]];
        
        [self.dropBoxButton setEnabled:NO];

        [self.audioFileShareButton setHidden:NO];
        [self.videoFileShareButton setHidden:NO];
        [self.textFileShareButton setHidden:NO];
        
        [self.logoutDropBoxButton setHidden:NO];
    }
    else
    {
        [self.dropBoxButton setTitle:@"Connect DROPBOX" forState:UIControlStateNormal];
        
        [self.dropBoxButton setEnabled:YES];
        
        [self.dropBoxButton setBackgroundColor:self.logoutDropBoxButton.backgroundColor];
        [self.dropBoxButton.titleLabel setTextColor:[UIColor whiteColor]];

        
        [self.audioFileShareButton setHidden:YES];
        [self.videoFileShareButton setHidden:YES];
        [self.textFileShareButton setHidden:YES];
        
        [self.logoutDropBoxButton setHidden:YES];
        
    }
}

- (IBAction)dropBoxButtonAction:(id)sender
{
    if (![objManager isLinkedDB])
    [objManager checkForLink];
    
}

- (IBAction)logoutDropBox:(id)sender
{
    if ([objManager isLinkedDB])
    {
        [objManager logoutFromDropbox];
        [self setupButtonsState];
    }
    
}






-(IBAction)btnUploadFileTapped:(id)sender
{
    
    
    UIButton * btn = sender;
    
    switch (btn.tag) {
        case 0:
            [self uploadAndShareAudioFile];
            break;
            
        case 1:
            [self uploadAndShareVideoFile];
            break;
            
        case 2:
            [self uploadAndShareTextFile];
            break;
            
        default:
            break;
    }
    
    
}


- (void)uploadAndShareAudioFile
{
    objManager.currentPostType = DropBoxUploadFile;
    objManager.strFileName  = @"DaBaDee";
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"DaBaDee" ofType:@"mp3"];
    
    objManager.strFilePath = path;
    objManager.strDestDirectory = @"/Anispy/";
    [objManager uploadFile];
}

- (void)uploadAndShareVideoFile
{
    
}

- (void)uploadAndShareTextFile
{
    
}

#pragma mark -
#pragma mark File upload delegate

- (void)finishedUploadFile
{
    NSLog(@"Uploaded successfully.");
}

- (void)failedToUploadFile:(NSString*)withMessage
{
    NSLog(@"Failed to upload error is %@",withMessage);
}

- (void)finishedLogin:(NSMutableDictionary*)userInfo
{
    NSLog(@"finishedLogin %@",userInfo);

}
- (void)failedToLogin:(NSString*)withMessage
{
    NSLog(@"failedToLogin %@",withMessage);

}

- (void)finishedCreateFolder
{
    NSLog(@"finishedCreateFolder");

}
- (void)failedToCreateFolder:(NSString*)withMessage
{
    NSLog(@"failedToCreateFolder %@",withMessage);

}



- (void)finishedDownloadFile
{
    NSLog(@"finishedDownloadFile");

}
- (void)failedToDownloadFile:(NSString*)withMessage
{
    NSLog(@"failedToDownloadFile %@",withMessage);

}

- (void)getFolderContentFinished:(DBMetadata*)metadata
{
    NSLog(@"getFolderContentFinished %@",metadata.description);

    
}
- (void)getFolderContentFailed:(NSString*)withMessage
{
    NSLog(@"getFolderContentFailed %@",withMessage);

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
