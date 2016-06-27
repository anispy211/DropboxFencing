//
//  DownloadedFile.h
//  FencingDBPOC
//
//  Created by Aniruddha Kadam on 21/06/16.
//  Copyright © 2016 Aniruddha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloadedFile : NSObject

@property (nonatomic,strong) NSString * filename;
@property (nonatomic,strong) NSString * filePath;
@property (nonatomic,strong) NSString * imgName;

@end
