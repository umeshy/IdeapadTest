//
//  UserProfileView.m
//  IdeapadTest
//
//  Created by Umeshwarrao yennam on 5/27/17.
//  Copyright © 2017 Ideapad.io Inc. All rights reserved.
//

#import "FriendProfileView.h"
@interface FriendProfileView()
@property(strong, nonatomic) UIImageView * userImage;
@end
@implementation FriendProfileView{
    BOOL isSelected;
    NSInteger ViewIndex;
}

- (id) initWithFrame:(CGRect)frame image:(UIImage*)image{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = frame.size.height/2;
        self.userImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.userImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.userImage setImage:image];
        self.userImage.clipsToBounds = YES;
        self.userImage.layer.cornerRadius = frame.size.height/2;
        self.userImage.transform = CGAffineTransformMakeScale(0.82, 0.82);
        [self addSubview:self.userImage];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewSelected)];
        tapRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapRecognizer];
    }
    return self;
}

- (void)setIndex:(NSInteger)index{
    ViewIndex = index;
}

- (void)viewSelected {
    [self.delegate friendSelected:ViewIndex];
}

- (void)selected:(BOOL)flag {
    isSelected = flag;
    if (flag) {
        self.layer.borderWidth = 1.5;
        self.layer.borderColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1.0].CGColor;
    }else{
        self.layer.borderWidth = 0;
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
