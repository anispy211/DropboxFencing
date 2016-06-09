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


-(IBAction)btnUploadFileTapped:(id)sender
{
    objManager.currentPostType = DropBoxUploadFile;
    objManager.strFileName  = @"DaBaDee";
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"DaBaDee" ofType:@"mp3"];
    
    objManager.strFilePath = path;
    objManager.strDestDirectory = @"/Anispy/";
    [objManager uploadFile];
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
