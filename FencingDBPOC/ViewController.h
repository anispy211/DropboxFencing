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



-(IBAction)btnUploadFileTapped:(id)sender;



@end

