//
//  GalleryViewFooter.m
//  rise
//
//  Created by Kaylyn Phan on 8/4/22.
//

#import "GalleryViewFooter.h"
#import "../Styles.h"

@implementation GalleryViewFooter


- (void)awakeFromNib {
    [super awakeFromNib];
    [Styles addGradientToButton:self.createNewWorkoutButton];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
