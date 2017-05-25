//
//  MainVC.m
//  IdeapadTest
//
//  Created by Umeshwarrao yennam on 5/23/17.
//  Copyright © 2017 Ideapad.io Inc. All rights reserved.
//

#import "MainVC.h"
#import "UIView+Genie.h"
#import "SettingsVC.h"
#import "Helper.h"
#import "UITextView+Placeholder.h"

@interface MainVC ()
@property(strong, nonatomic) UILabel *fetchingLabel;
@property(strong, nonatomic) UIImageView *mailImage;
@property(strong, nonatomic) UIImageView *groupImage;
@property(strong, nonatomic) UIImageView *messageImage;
@property(strong, nonatomic) NSMutableArray *friendsList;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property(strong, nonatomic) UIView *fetchingFriendsBGView;
@property(strong, nonatomic) UIImageView *singlePersonImage;
@property (weak, nonatomic) IBOutlet UIView *buttonLineView;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property(strong, nonatomic) UIImageView *singleMovingPersonImage;
@property (weak, nonatomic) IBOutlet UIScrollView *friendsListScrollingView;
@end

@implementation MainVC{
    CGPoint mailInitCenter;
    CGPoint mailRecivingCenter;
    CGPoint mailSendCenter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

-(void) viewDidAppear:(BOOL)animated{
    [self showFriendsfetchingAnimation];
}

-(void) setupView {
    self.messageTextView.delegate = self;
    self.settingButton.hidden = YES;
    self.fetchingFriendsBGView = [[UIView alloc]initWithFrame:CGRectMake(  0
                                                                         , (self.welcomeLabel.frame.origin.y + self.welcomeLabel.frame.size.height)
                                                                         , self.view.frame.size.width
                                                                         , self.view.frame.size.height - (self.welcomeLabel.frame.origin.y + self.welcomeLabel.frame.size.height))];
    self.fetchingFriendsBGView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.fetchingFriendsBGView];
    
    float dimension = 40;
    float fetchingY = 100;
    float centerSpacing = 60;
    self.singleMovingPersonImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, dimension, dimension)];
    self.singleMovingPersonImage.center = CGPointMake(self.fetchingFriendsBGView.frame.size.width/2 - centerSpacing, fetchingY);
    self.singleMovingPersonImage.image = [UIImage imageNamed:@"single"];
    self.singleMovingPersonImage.hidden = YES;
    self.singleMovingPersonImage.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [self.fetchingFriendsBGView addSubview:self.singleMovingPersonImage];
    
    self.singlePersonImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, dimension, dimension)];
    self.singlePersonImage.center = CGPointMake(self.fetchingFriendsBGView.frame.size.width/2 - centerSpacing, fetchingY);
    self.singlePersonImage.image = [UIImage imageNamed:@"facebook"];
    self.singlePersonImage.hidden = YES;
    self.singlePersonImage.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [self.fetchingFriendsBGView addSubview:self.singlePersonImage];
    
    self.groupImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, dimension, dimension)];
    self.groupImage.center = CGPointMake(self.fetchingFriendsBGView.frame.size.width/2 + centerSpacing, fetchingY);
    self.groupImage.image = [UIImage imageNamed:@"group"];
    self.groupImage.hidden = YES;
    self.groupImage.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [self.fetchingFriendsBGView addSubview:self.groupImage];
    
    self.fetchingLabel = [[UILabel alloc]initWithFrame:CGRectMake(
                                                                  0
                                                                  , self.singlePersonImage.frame.origin.y + self.singlePersonImage.frame.size.height + 17
                                                                  , self.view.frame.size.width
                                                                  , 40)];
    self.fetchingLabel.text = @"Getting friends list..";
    self.fetchingLabel.font = [UIFont fontWithName:@"Avenir-Light" size:15];
    self.fetchingLabel.textAlignment = NSTextAlignmentCenter;
    self.fetchingLabel.hidden = YES;
    self.fetchingLabel.alpha = 0;
    self.fetchingLabel.textColor = [UIColor colorWithRed:0.69 green:0.69 blue:0.69 alpha:1.0];
    [self.fetchingFriendsBGView addSubview:self.fetchingLabel];
    
    self.friendsList = [[NSMutableArray alloc] init];
    [self.friendsList addObject:@"kanye"];
    [self.friendsList addObject:@"Katy"];
    [self.friendsList addObject:@"micky"];
    [self.friendsList addObject:@"Tom"];
    
    mailInitCenter = CGPointMake(-50, self.buttonLineView.frame.origin.y - 60);
    mailRecivingCenter = CGPointMake(self.view.frame.size.width/2, self.buttonLineView.frame.origin.y - 60);
    mailSendCenter = CGPointMake(self.view.frame.size.width+60, self.buttonLineView.frame.origin.y - 60);
    self.messageImage = [[UIImageView alloc]initWithFrame:self.messageTextView.frame];
    self.messageImage.hidden = YES;
    self.mailImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.mailImage.image = [UIImage imageNamed:@"message"];
    self.mailImage.center = mailInitCenter;
    [self.view addSubview:self.messageImage];
    [self.view addSubview:self.mailImage];
    
    self.messageTextView.placeholder = @"Write something here...";
    self.messageTextView.placeholderColor = [UIColor colorWithRed:0.81 green:0.81 blue:0.81 alpha:1.0];
}

- (void)showFriendsfetchingAnimation {
    self.groupImage.hidden = NO;
    self.singlePersonImage.hidden = NO;
    self.singleMovingPersonImage.hidden = NO;
    self.fetchingLabel.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.groupImage.transform = CGAffineTransformMakeScale(1, 1);
        self.singlePersonImage.transform = CGAffineTransformMakeScale(1, 1);
        self.singleMovingPersonImage.transform = CGAffineTransformMakeScale(1, 1);
        self.fetchingLabel.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionRepeat animations:^{
                [UIView setAnimationRepeatCount:5];
                self.singleMovingPersonImage.center = self.groupImage.center;
                self.singleMovingPersonImage.transform = CGAffineTransformMakeScale(0.1, 0.1);
            } completion:^(BOOL finished) {
                if (finished) {
                    UIImageView *doneImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
                    doneImage.image = [UIImage imageNamed:@"done"];
                    doneImage.center = CGPointMake(self.fetchingFriendsBGView.frame.size.width/2, self.groupImage.center.y);
                    doneImage.transform = CGAffineTransformMakeScale(0.1, 0.1);
                    [self.fetchingFriendsBGView addSubview:doneImage];
                    [UIView animateWithDuration:0.5 animations:^{
                        doneImage.transform = CGAffineTransformMakeScale(1.0, 1.0);
                        self.groupImage.transform = CGAffineTransformMakeScale(0.0, 0.0);
                        self.singlePersonImage.transform = CGAffineTransformMakeScale(0.0, 0.0);
                        self.singleMovingPersonImage.transform = CGAffineTransformMakeScale(0.0, 0.0);
                        self.fetchingLabel.alpha = 0;
                    } completion:^(BOOL finished) {
                        if (finished) {
                            [Helper playSound:0];
                            [UIView animateWithDuration:0.6 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                                doneImage.transform = CGAffineTransformMakeScale(0.1, 0.1);
                                self.fetchingFriendsBGView.alpha = 0;
                            } completion:^(BOOL finished) {
                                if (finished) {
                                    self.settingButton.hidden = NO;
                                    [UIView setAnimationRepeatCount:0];
                                    [self.view.layer removeAllAnimations];
                                    [doneImage removeFromSuperview];
                                    self.fetchingFriendsBGView.hidden = YES;
                                    [self populateFriends];
                                }
                            }];
                        }
                    }];
                    
                }
            }];
        }
    }];
}

- (void) populateFriends {
    float unitX = 0;
    for (NSString *imageName in self.friendsList) {
        UIImageView *userImage = [[UIImageView alloc]initWithFrame:CGRectMake(unitX, 0, self.friendsListScrollingView.frame.size.height, self.friendsListScrollingView.frame.size.height)];
        userImage.contentMode = UIViewContentModeScaleAspectFill;
        userImage.clipsToBounds = YES;
        userImage.image = [UIImage imageNamed:imageName];
        userImage.layer.cornerRadius = self.friendsListScrollingView.frame.size.height/2;
        userImage.layer.borderWidth = 2;
        userImage.layer.borderColor = [UIColor colorWithRed:0.69 green:0.69 blue:0.69 alpha:1.0].CGColor;
        unitX = unitX + self.friendsListScrollingView.frame.size.height + 7;
        userImage.transform = CGAffineTransformMakeScale(0.1, 0.1);
        [self.friendsListScrollingView addSubview:userImage];
        [self.friendsListScrollingView setContentSize:CGSizeMake(unitX, self.friendsListScrollingView.frame.size.height)];
        [self scalUp:userImage duration:0.4];
    }
    [self.friendsList removeAllObjects];
}

- (void)scalUp:(UIView*)view duration:(float)duration{
    [UIView animateWithDuration:duration animations:^{
        view.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3/2 animations:^{
                    view.transform = CGAffineTransformIdentity;
                }];
            }];
        }
    }];
}

- (void)showMessagePushAnimation {
    NSRange r  = {0,0};
    [self.messageTextView setSelectedRange:r];
    [UIView animateWithDuration:0.4 animations:^{
        self.mailImage.center = CGPointMake(mailRecivingCenter.x+15, mailRecivingCenter.y);
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.mailImage.center = mailRecivingCenter;
            } completion:^(BOOL finished) {
                if (finished) {
                    UIGraphicsBeginImageContext(CGSizeMake(self.messageTextView.frame.size.width,self.messageTextView.frame.size.height));
                    CGContextRef context = UIGraphicsGetCurrentContext();
                    self.messageImage.hidden = NO;
                    [self.messageTextView.layer renderInContext:context];
                    self.messageImage.image = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    self.messageTextView.hidden = YES;
                    self.messageTextView.text = @"";
                    self.messageTextView.alpha = 0;
                    [self.messageImage genieInTransitionWithDuration:0.7
                                        destinationRect:self.mailImage.frame
                                        destinationEdge:BCRectEdgeTop
                                             completion:^{
                                                 self.messageImage.hidden = YES;
                                                 NSLog(@"I'm done!");
                                                 [UIView animateWithDuration:0.2 animations:^{
                                                     self.mailImage.center = CGPointMake(mailRecivingCenter.x-15, mailRecivingCenter.y);;
                                                 } completion:^(BOOL finished) {
                                                     if (finished) {
                                                         [Helper playSound:1];
                                                         [UIView animateWithDuration:0.4 animations:^{
                                                             self.mailImage.center = mailSendCenter;
                                                         } completion:^(BOOL finished) {
                                                             if (finished) {
                                                                 self.mailImage.center = mailInitCenter;
                                                                 self.messageTextView.hidden = NO;
                                                                 [UIView animateWithDuration:0.3 animations:^{
                                                                     self.messageTextView.alpha = 1;
                                                                 } completion:^(BOOL finished) {
                                                                     
                                                                 }];
                                                             }
                                                         }];
                                                     }
                                                 }];
                                             }];
                }
            }];
        }
    }];
}

- (IBAction)onPushMessagePressed:(id)sender {
    if ([[self.messageTextView.text stringByTrimmingCharactersInSet:
          [NSCharacterSet whitespaceCharacterSet]] length] > 0) {
        [self showMessagePushAnimation];
    }
}

- (IBAction)onSettingsPressed:(id)sender {
    SettingsVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsVC"];
    [self presentViewController:VC animated:YES completion:nil];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (IBAction)onMainScreenTapped:(id)sender {
    [self.messageTextView resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
