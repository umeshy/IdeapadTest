//
//  SettingsVC.m
//  IdeapadTest
//
//  Created by Umeshwarrao yennam on 5/23/17.
//  Copyright © 2017 Ideapad.io Inc. All rights reserved.
//

#import "SettingsVC.h"
#import "ViewController.h"

@interface SettingsVC ()

@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onBackPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onLogoutPressed:(id)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Sure you want to Logout?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *userYESAction = [UIAlertAction actionWithTitle:@"YES"
                                                            style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
                                                                NSLog(@"Logged Out!");
                                                                ViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
                                                                [self presentViewController:VC animated:YES completion:nil];
                                                            }];
    UIAlertAction *userNOAction = [UIAlertAction actionWithTitle:@"NO"
                                                           style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                                                               NSLog(@"Logged Canceled!");
                                                           }];
    [actionSheet addAction:userYESAction];
    [actionSheet addAction:userNOAction];
    [self presentViewController:actionSheet animated:YES completion:nil];
    
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
