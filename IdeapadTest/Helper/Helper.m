//
//  Helper.m
//  IdeapadTest
//
//  Created by Umeshwarrao yennam on 5/25/17.
//  Copyright © 2017 Ideapad.io Inc. All rights reserved.
//

#import "Helper.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation Helper
+ (void)playSound:(NSInteger)sound {
    switch (sound) {
        case 0:
            AudioServicesPlaySystemSound (1150);
            break;
        case 1:
            AudioServicesPlaySystemSound (1303);
            break;
        case 2:
            AudioServicesPlaySystemSound (1024);
            break;
        case 3:
            AudioServicesPlaySystemSound (1021);
            break;
        default:
            AudioServicesPlaySystemSound (1004);
            break;
    }
}
@end
