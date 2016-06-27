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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startDownloadForsharedURL) name:@"FileArrived" object:nil];
    
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
        [self.dropBoxButton setTitle:@"Logout DROPBOX" forState:UIControlStateNormal];
        [self.dropBoxButton setBackgroundColor:[UIColor lightGrayColor]];
        [self.dropBoxButton.titleLabel setTextColor:[UIColor redColor]];
        
        //[self.dropBoxButton setEnabled:NO];

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
    
    if ([objManager isLinkedDB])
    {
        [objManager logoutFromDropbox];
        [self setupButtonsState];
    }
    else
    {
        [objManager checkForLink];

    }
    
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
    objManager.strFileName  = @"DaBaDee.mp3";
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"DaBaDee" ofType:@"mp3"];
    
    objManager.strFilePath = path;
    objManager.strDestDirectory = @"/FencingApp/";
    [objManager uploadFile];
    
    AppDelegate * app = [[UIApplication sharedApplication] delegate];
    
    [app showHUDActivityIndicator:@"Uploading"];
}


- (void)uploadAndShareVideoFile
{
    objManager.currentPostType = DropBoxUploadFile;
    objManager.strFileName  = @"starwars.mp4";
        
    NSString * path = [[NSBundle mainBundle] pathForResource:@"starwars" ofType:@"mp4"];
    
    objManager.strFilePath = path;
    objManager.strDestDirectory = @"/FencingApp/";
    [objManager uploadFile];
    
    AppDelegate * app = [[UIApplication sharedApplication] delegate];
    
    [app showHUDActivityIndicator:@"Uploading"];
    
}

- (HCDownloadViewController *)getHCDownloader
{
    
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (!app.dlvc)
    {
        app.dlvc = [[HCDownloadViewController alloc] init];
        app.dlvc.delegate = self;
        
    }
    
    return app.dlvc;
}

- (DownloadedTableViewController *)getDownloadVC
{
    if (!downloadVC)
    {
        downloadVC = [[DownloadedTableViewController alloc] init];
    }
    return downloadVC;
}


- (void)startDownloadForsharedURL
{
    AppDelegate * app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/MyFolder"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
    

    

    app.dlvc = [self getHCDownloader];

    
    app.dlvc.downloadDirectory = dataPath;
    

    app.dlvc.delegate = self;
    [app.dlvc downloadURL:app.currentURL userInfo:nil];

    NSLog(@">>>>>>>>> \n startDownloadForsharedURL for directory :%@ and URL:%@",app.dlvc.downloadDirectory,app.currentURL);
    
}




- (void)uploadAndShareTextFile
{    AppDelegate * app = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    
    app.dlvc = [self getHCDownloader];
    
    [self.navigationController showViewController:app.dlvc sender:self];
}

#pragma mark - Share File

- (void)showShareAlertForPath:(NSString *)path
{
    
    currentPath = [[NSString alloc] initWithString:path];
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"File Uploaded Successfully" message:@"Do you wnat to share this via email ?" delegate:self cancelButtonTitle:@"NO Thanks" otherButtonTitles:@"YES", nil];
    
    [alert show];
    
}

#pragma mark - Alertview Delagates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
            currentPath = nil;
            break;
            
        case 1:
            [self generatePublicLinkForCurrentPath:currentPath];
            break;
            
        default:
            break;
    }
    
}


- (void)generatePublicLinkForCurrentPath:(NSString *)path
{
    [objManager uploadFileFromSourcePathAndShare:path];
    
    AppDelegate * app = [[UIApplication sharedApplication] delegate];
    [app showHUDActivityIndicator:nil];
}

- (void)openEmailForCurrentpath:(NSString *)path
{
    
    // Email Content
    NSString *messageBody = [NSString stringWithFormat:@"<html><body><b> </b><br\\>Link: <a href='goomzee://%@'>Click to open in DropBox POC APP</a></body></html>",path];
    

    NSArray * activityItems = @[messageBody];
    NSArray * applicationActivities = nil;
    NSArray * excludeActivities = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePostToWeibo, UIActivityTypePrint, UIActivityTypeMessage];
    
    UIActivityViewController * activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
    activityController.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityController animated:YES completion:nil];
    
}


#pragma mark -
#pragma mark File upload delegate


- (void)finishedGeneratingUrl:(NSString*)url
{
    [self openEmailForCurrentpath:url];
    
    AppDelegate * app = [[UIApplication sharedApplication] delegate];
    [app hideHUDActivityIndicator];
}


- (void)failedGeneratingUrl:(NSString*)withMessage;
{
    AppDelegate * app = [[UIApplication sharedApplication] delegate];
    
    [app hideHUDActivityIndicator];

}

- (void)finishedUploadFileForPath:(NSString *)path
{
    NSLog(@"Uploaded successfully. for Path: %@",path);
    
    AppDelegate * app = [[UIApplication sharedApplication] delegate];
    
    [app hideHUDActivityIndicator];
    
    [self showShareAlertForPath:path];
}

- (void)failedToUploadFile:(NSString*)withMessage
{
    NSLog(@"Failed to upload error is %@",withMessage);
    
    AppDelegate * app = [[UIApplication sharedApplication] delegate];
    
    [app hideHUDActivityIndicator];
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


#pragma mark - Buttons Action

- (IBAction)showDownloadedContent:(UIButton *)sender
{
    downloadVC = [self getDownloadVC];
    
    [self.navigationController showViewController:downloadVC sender:self];
}


#pragma mark - HCDVC


- (void)downloadController:(HCDownloadViewController *)vc startedDownloadingURL:(NSURL *)url userInfo:(NSDictionary *)userInfo
{
    NSLog(@">>>/n HCDownloadViewController startedDownloadingURL : %@ \n",url);

}


- (void)downloadController:(HCDownloadViewController *)vc dowloadedFromURL:(NSURL *)url progress:(float)progress userInfo:(NSDictionary *)userInfo
{
    NSLog(@">>>/n HCDownloadViewController dowloadedFromURL : %@ progress:%f \n",url,progress);

}

- (void)downloadController:(HCDownloadViewController *)vc finishedDownloadingURL:(NSURL *)url toFile:(NSString *)fileName userInfo:(NSDictionary *)userInfo
{
    NSLog(@">>>/n HCDownloadViewController finishedDownloadingURL : %@ to File:%@ \n",url,fileName);

}

- (void)downloadController:(HCDownloadViewController *)vc failedDownloadingURL:(NSURL *)url withError:(NSError *)error userInfo:(NSDictionary *)userInfo
{
    NSLog(@">>>/n HCDownloadViewController failedDownloadingURLWithError : %@ \n",error);

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
