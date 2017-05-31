//
//  ViewController.m
//  IdeapadTest
//
//  Created by Umeshwarrao yennam on 5/22/17.
//  Copyright © 2017 Ideapad.io Inc. All rights reserved.
//

#import "ViewController.h"
#import "MainVC.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (strong, nonatomic) UIView *facebookLoginAnimView;
@property (strong, nonatomic) UIView *facebookLoginAnimViewBG;

@end

@implementation ViewController{
    CGPoint facebookAnimStartCenter;
    CGPoint facebookAnimFinaleCenter;
    CGRect facebookFinaleRect;
    CAShapeLayer *shapeLayer;
    UIBezierPath *sqStartPath;
    UIBezierPath *sqFinalePath;
    UIBezierPath *crclePath;
    CGAffineTransform currentFacebookViewScaleTransform;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated{
    self.facebookButton.hidden = NO;
    [self setupView];
}

- (void)setupView {
    
    facebookAnimStartCenter = self.facebookButton.center;
    facebookAnimFinaleCenter = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    facebookFinaleRect = CGRectMake(0, 0, self.view.frame.size.width*0.2, self.view.frame.size.width*0.2);
    
    self.facebookLoginAnimViewBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.facebookLoginAnimViewBG.backgroundColor = [UIColor whiteColor];
    self.facebookLoginAnimViewBG.alpha = 0;
    self.facebookLoginAnimViewBG.hidden = YES;
    self.facebookLoginAnimView = [[UIView alloc]initWithFrame:facebookFinaleRect];
    self.facebookLoginAnimView.layer.cornerRadius = facebookFinaleRect.size.width/2;
    self.facebookLoginAnimView.backgroundColor = self.facebookButton.backgroundColor;
    self.facebookLoginAnimView.hidden = YES;
    self.facebookLoginAnimView.alpha = 0;
    self.facebookLoginAnimView.center = facebookAnimFinaleCenter;
    currentFacebookViewScaleTransform = self.facebookLoginAnimView.transform;
    
    UILabel *facebookLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 40)];
    facebookLabel.text = @"f";
    facebookLabel.textAlignment = NSTextAlignmentCenter;
    facebookLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:30];
    facebookLabel.textColor = [UIColor whiteColor];
    facebookLabel.center = CGPointMake(facebookFinaleRect.size.width/2, facebookFinaleRect.size.height/2);
    [self.facebookLoginAnimView addSubview:facebookLabel];
    
    
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = self.facebookButton.backgroundColor.CGColor;
    shapeLayer.lineJoin = kCALineCapRound;
    sqStartPath = [self makeSquare:facebookAnimStartCenter
                       squareWidth:self.facebookButton.frame.size.width
                       squareHeight:self.facebookButton.frame.size.height];
    sqFinalePath = [self makeSquare:facebookAnimStartCenter
                        squareWidth:facebookFinaleRect.size.width
                       squareHeight:facebookFinaleRect.size.height];
    shapeLayer.path = [sqStartPath CGPath];
    crclePath = [self makeCircle:self.view.center
                          radius:facebookFinaleRect.size.width/2];
    shapeLayer.hidden = YES;
    [self.view addSubview:self.facebookLoginAnimViewBG];
    [self.view.layer addSublayer:shapeLayer];
    [self.view addSubview:self.facebookButton];
    [self.view addSubview:self.facebookLoginAnimView];
    
}

-(UIBezierPath*)makeSquare:(CGPoint)centrePoint squareWidth:(float)gainW squareHeight:(float)gainH{
    float x=centrePoint.x-(gainW/2);
    float y=centrePoint.y-(gainH/2);
    UIBezierPath *apath = [UIBezierPath bezierPath];
    [apath moveToPoint:CGPointMake(x,y)];
    [apath addLineToPoint:apath.currentPoint];
    [apath addLineToPoint:CGPointMake(x+gainW,y)];
    [apath addLineToPoint:apath.currentPoint];
    [apath addLineToPoint:CGPointMake(x+gainW,y+gainH)];
    [apath addLineToPoint:apath.currentPoint];
    [apath addLineToPoint:CGPointMake(x,y+gainH)];
    [apath addLineToPoint:apath.currentPoint];
    [apath closePath];
    return apath;
}

- (UIBezierPath *)makeCircle:(CGPoint)center radius:(CGFloat)radius
{
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter:center radius:radius startAngle:-M_PI endAngle:-M_PI/2 clockwise:YES];
    [circlePath addArcWithCenter:center radius:radius startAngle:-M_PI/2 endAngle:0 clockwise:YES];
    [circlePath addArcWithCenter:center radius:radius startAngle:0 endAngle:M_PI/2 clockwise:YES];
    [circlePath addArcWithCenter:center radius:radius startAngle:M_PI/2 endAngle:M_PI clockwise:YES];
    [circlePath addArcWithCenter:center radius:radius startAngle:M_PI endAngle:-M_PI clockwise:YES];
    [circlePath closePath];
    return circlePath;
}

- (IBAction)onFacebookButtonPressed:(id)sender {
    [self showFBLoginAnimation];
}

- (void)showFBLoginAnimation {
    shapeLayer.hidden = NO;
    self.facebookLoginAnimViewBG.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.facebookButton.alpha = 0;
        self.facebookLoginAnimViewBG.alpha = 0.8;
    } completion:^(BOOL finished) {
        if (finished) {
            self.facebookButton.hidden = YES;
        }
    }];
    float facebookLoginAnimDuration = 1;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = facebookLoginAnimDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = (__bridge id)(sqStartPath.CGPath);
    animation.toValue = (__bridge id)(crclePath.CGPath);
    shapeLayer.path = crclePath.CGPath;
    [shapeLayer addAnimation:animation forKey:@"animatePath"];
    self.facebookLoginAnimView.hidden = NO;
    [UIView animateWithDuration:0.3 delay:facebookLoginAnimDuration options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.facebookLoginAnimView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionAutoreverse | UIViewKeyframeAnimationOptionRepeat animations:^{
                [UIView setAnimationRepeatCount:3];
                self.facebookLoginAnimView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            } completion:^(BOOL finished) {
                if (finished) {
                    [self hideFBLoginAnimation];
                }
            }];
        }
    }];
    
}

- (void)hideFBLoginAnimation {
    shapeLayer.path = [sqStartPath CGPath];
    shapeLayer.hidden = YES;
    [UIView animateWithDuration:0.9 animations:^{
        self.facebookLoginAnimView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.facebookLoginAnimView.center = facebookAnimFinaleCenter;
        self.facebookLoginAnimViewBG.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.facebookLoginAnimViewBG.hidden = YES;
            self.facebookLoginAnimView.hidden = YES;
            self.facebookLoginAnimView.alpha = 0;
            self.facebookLoginAnimView.transform = currentFacebookViewScaleTransform;
            self.facebookButton.hidden = YES;
            self.facebookButton.alpha = 1;
            [self openMainView];
        }
    }];
}

-(void) openMainView {
    MainVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
    [self presentViewController:VC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
