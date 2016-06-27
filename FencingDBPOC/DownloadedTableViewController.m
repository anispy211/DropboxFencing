//
//  DownloadedTableViewController.m
//  FencingDBPOC
//
//  Created by Aniruddha Kadam on 21/06/16.
//  Copyright © 2016 Aniruddha. All rights reserved.
//

#import "DownloadedTableViewController.h"
#import "DownloadedFile.h"

@interface DownloadedTableViewController ()
{
    NSMutableArray * fileArray;
}

@end

@implementation DownloadedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    fileArray = [[NSMutableArray alloc] init];
 
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    [self loadDownloadedFilesArray];
    
    self.title = @"Downloaded";
    
    
}

- (void)loadDownloadedFilesArray
{
    
    
    if (fileArray) {
        [fileArray removeAllObjects];
    }
    
    NSArray * file = [[NSArray alloc] initWithObjects:@"starwars.mp4",@"starwars (1).mp4",@"starwars (2).mp4",@"starwars (3).mp4",@"starwars (4).mp4",@"starwars (5).mp4",@"starwars (6).mp4",@"DaBaDee.mp3",@"DaBaDee (1).mp3",@"DaBaDee (2).mp3",@"DaBaDee (3).mp3",@"DaBaDee (4).mp3",@"DaBaDee (5).mp3",@"DaBaDee (6).mp3", nil];
    
    for (int i = 0; i < file.count; ++i){
        NSFileManager* fileMgr = [NSFileManager defaultManager];
        
        
        NSError *error;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/MyFolder"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
        
        NSString* imageName = [NSString stringWithFormat:@"/%@", file[i]];
        NSString* currentFile = [dataPath stringByAppendingPathComponent:imageName];
        BOOL fileExists = [fileMgr fileExistsAtPath:currentFile];
        if (fileExists == YES){
            
            if (i == 7 || i == 8 || i == 9 || i == 10 || i == 11 || i == 12 || i == 13 ){ // Audio File
                
                DownloadedFile * dwFile = [[DownloadedFile alloc] init];
                dwFile.filename = @"DaBaDee.mp3";
                dwFile.filePath = currentFile;
                dwFile.imgName = @"audio.png";
                
                [fileArray addObject:dwFile];
            }
            
            if (i == 0 || i == 1 || i == 2 ||i == 3 ||i == 4 ||i == 5 ||i == 6 ) { //Video File
                DownloadedFile * dwFile = [[DownloadedFile alloc] init];
                dwFile.filename = @"starwars.mp4";
                dwFile.filePath = currentFile;
                dwFile.imgName = @"video.jpeg";
                
                [fileArray addObject:dwFile];
            }
        }
    }
    
    
    if (fileArray.count > 0) {
        [self.tableView reloadData];
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [fileArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    DownloadedCellTableViewCell *cell = (DownloadedCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kDownloadCellID];
    if (cell == nil) {
        cell = [DownloadedCellTableViewCell cell];
    }

    
    DownloadedFile * file1 = [fileArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = file1.filename;
    cell.imageView.image = [UIImage imageNamed:file1.imgName];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DownloadedFile * file1 = [fileArray objectAtIndex:indexPath.row];
    
    
    if ([file1.imgName isEqualToString:@"audio.png"]) {
        
        
        
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *moviePath = [bundle pathForResource:@"DaBaDee" ofType:@"mp3"];
        NSURL *movieURL = [NSURL fileURLWithPath:moviePath] ;
        
        
        
        MPMoviePlayerViewController *videoPlayerView = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
        [[videoPlayerView view] setFrame: [self.view bounds]];  // frame must match parent view
        
        [self presentMoviePlayerViewControllerAnimated:videoPlayerView];
        [videoPlayerView.moviePlayer play];
        

        
        
        
    }
    
    
    
    if ([file1.imgName isEqualToString:@"video.jpeg"]) {
        
        
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *moviePath = [bundle pathForResource:@"starwars" ofType:@"mp4"];
        NSURL *movieURL = [NSURL fileURLWithPath:moviePath] ;
        
        
        
        MPMoviePlayerViewController *videoPlayerView = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
        [[videoPlayerView view] setFrame: [self.view bounds]];  // frame must match parent view

        [self presentMoviePlayerViewControllerAnimated:videoPlayerView];
        [videoPlayerView.moviePlayer play];
        
        
        
    

    }
    
  }


@end
