//
//  UserProfileView.h
//  IdeapadTest
//
//  Created by Umeshwarrao yennam on 5/27/17.
//  Copyright © 2017 Ideapad.io Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendSelectedDelegate.h"

@interface FriendProfileView : UIView
@property(strong , nonatomic) id<FriendSelectedDelegate>delegate;
- (id) initWithFrame:(CGRect)frame image:(UIImage*)image;
- (void)selected:(BOOL)flag;
- (void)setIndex:(NSInteger)index;

@end
