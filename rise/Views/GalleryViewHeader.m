//
//  GalleryViewHeader.m
//  rise
//
//  Created by Kaylyn Phan on 7/14/22.
//

#import "GalleryViewHeader.h"

@implementation GalleryViewHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.helloLabel.backgroundColor = [UIColor grayColor];
    [self.helloLabel sizeToFit];
    self.helloLabel.layer.cornerRadius = 26;
    self.helloLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
