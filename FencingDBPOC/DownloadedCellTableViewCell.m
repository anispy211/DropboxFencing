//
//  DownloadedCellTableViewCell.m
//  FencingDBPOC
//
//  Created by Aniruddha Kadam on 22/06/16.
//  Copyright © 2016 Aniruddha. All rights reserved.
//

#import "DownloadedCellTableViewCell.h"

@implementation DownloadedCellTableViewCell



+ (id)cell
{
    return [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kDownloadCellID];
}


- (id)initWithStyle:(UITableViewCellStyle)s reuseIdentifier:(NSString *)ruid
{
    if ((self = [super initWithStyle:s reuseIdentifier:ruid])) {
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.font = [UIFont systemFontOfSize:10.0f];
        self.detailTextLabel.numberOfLines = 3;
        
    }
    return self;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
