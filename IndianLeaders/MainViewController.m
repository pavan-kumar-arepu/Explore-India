//
//  MainViewController.m
//  IndianLeaders
//
//  Created by Nilesh on 26/05/16.
//  Copyright © 2016 Nilesh. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "Constants.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "UIImage+animatedGIF.h"
#import "Model.h"


@interface MainViewController ()
{
    AppDelegate *appDelegate;
    Model *model;
    NSInteger anthemCheck;
    NSInteger songCheck;

}
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aboutIndiaIconTopConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aboutIndiaLeftConstraints;
@property (weak, nonatomic) IBOutlet UIButton *homeIconButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ashokChakraTopConstraints;


@end

@implementation MainViewController


#pragma mark - AppLifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Years completed :%ld",(long)[self numberOfYearFrom1947]);

   
    self.menuButton.hidden =YES;
    model = [Model getInstance];
    anthemCheck = 0;
    songCheck = 0;
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    appDelegate = [[UIApplication sharedApplication] delegate];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [_menuButton addTarget:self.revealViewController  action:@selector(revealToggle:) forControlEvents:UIControlEventTouchDown];

        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [self updateConstraints];
    
    _ashokChakrImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    
    
    if (!model.fistInstanceCheck) {
        CABasicAnimation *rotate;
        rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotate.fromValue = [NSNumber numberWithFloat:0];
        rotate.toValue = [NSNumber numberWithFloat:DEGREES_TO_RADIAN(360)];
        rotate.duration = 15;
        rotate.repeatCount = 1;
    
        [self.ashokChakrImageView.layer addAnimation:rotate forKey:@"10"];
        model.fistInstanceCheck= true;
         self.numberOfYear.text = [NSString stringWithFormat:@"%ldth",(long)[self numberOfYearFrom1947]];
         // [self dropSparkles];
        
    }
    else {
        [self.ashokChakrImageView setHidden:YES];
       [self.menuButton setHidden:NO];
        self.splashImageView.alpha = 0.0;
        [self.numberOfYear setHidden:YES];
        self.numberOfYear.text = @"";
        [self.happyIndependence setHidden:YES];
    }
    [self.readAboutFlagButton setImage:[UIImage animatedImageWithAnimatedGIFURL:[[NSBundle mainBundle] URLForResource:@"animatedFlag" withExtension:@"gif"]] forState:UIControlStateNormal];
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(moveToCustomPoint:) userInfo:nil repeats:NO];

}

-(void)dropSparkles
{
//    int screenWidth = self.view.frame.size.width;
    int screenHeight = self.view.frame.size.height;
    UIImage *image1 = [UIImage imageNamed:@"jasmine.png"];
    UIImage *image3 = [UIImage imageNamed:@"rose.png"];
    UIImage *image2 = [UIImage imageNamed:@"pear.png"];

    UIImage *image4 = [UIImage imageNamed:@"poinsettia.png"];
    
    UIImageView *newPiece1 = [[UIImageView alloc] initWithImage:image1];
    UIImageView *newPiece2 = [[UIImageView alloc] initWithImage:image3];
    UIImageView *newPiece3 = [[UIImageView alloc] initWithImage:image2];
    UIImageView *newPiece4 = [[UIImageView alloc] initWithImage:image4];

    
    int startX1 = 50;
    int endX1 = startX1 + ((arc4random()%DRIFT_X_VARIANCE) - (DRIFT_X_VARIANCE / 2));
    
    int startX2 = 150;
    int endX2 = startX2 + ((arc4random()%DRIFT_X_VARIANCE) - (DRIFT_X_VARIANCE / 2));
    
    int startX3 = 250;
    int endX3 = startX3 + ((arc4random()%DRIFT_X_VARIANCE) - (DRIFT_X_VARIANCE / 2));
    
    int startX4 = 350;
    int endX4 = startX4 + ((arc4random()%DRIFT_X_VARIANCE) - (DRIFT_X_VARIANCE / 2));
    

    
    newPiece1.center = CGPointMake(startX1, - image1.size.height);
    
    newPiece2.center = CGPointMake(startX2, - image2.size.height);
    newPiece3.center = CGPointMake(startX3, - image3.size.height);

    newPiece4.center = CGPointMake(startX4, - image4.size.height);


    
    [self.view addSubview:newPiece1];
    [self.view addSubview:newPiece2];
    [self.view addSubview:newPiece3];
    [self.view addSubview:newPiece4];

    
//    int time = ((arc4random()%FALL_TIME_VARIANCE) + (MEAN_FALL_TIME - (FALL_TIME_VARIANCE / 2)));
    int time = 7;
    [UIView animateWithDuration:time
                     animations:^(void) {
                         float rotation =
                         DegreesToRadians((arc4random()%ROTATION_VARIANCE) - (ROTATION_VARIANCE / 2));
                         newPiece1.transform = CGAffineTransformMakeRotation(rotation);
                         newPiece1.center = CGPointMake(endX1, screenHeight + image1.size.height);
                         
                         newPiece2.transform = CGAffineTransformMakeRotation(rotation);
                         newPiece2.center = CGPointMake(endX2, screenHeight + image2.size.height);
                         
                         
                         newPiece3.transform = CGAffineTransformMakeRotation(rotation);
                         newPiece3.center = CGPointMake(endX3, screenHeight + image3.size.height);
                         
                         
                         newPiece4.transform = CGAffineTransformMakeRotation(rotation);
                         newPiece4.center = CGPointMake(endX4, screenHeight + image4.size.height);
                         
                         
                         
                         
                     }completion:^(BOOL finished) {
                         //                         [newPiece removeFromSuperview];
                     }];
    
}


-(NSInteger)numberOfYearFrom1947
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
   // NSInteger day = [components day];
    //NSInteger month = [components month];
    NSInteger year = [components year];
    
    NSInteger independenceYear = 1946;
    NSInteger freedomYears = year - independenceYear;
    
    return freedomYears;
}


-(void)moveToCustomPoint:(id)sender
{
    CGRect theFrame = CGRectMake(7, 20, 34, 34);
    [UIView animateWithDuration:2.0f animations:^{
        self.ashokChakrImageView.frame = theFrame;
        self.splashImageView.alpha = 0.0;
        self.happyIndependence.alpha = 0.0;
        self.numberOfYear.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.ashokChakrImageView setHidden:YES];
        [self.menuButton setHidden:NO];
        [self.numberOfYear setHidden:YES];
    }];
}

- (UIImage *)rotateImage:(UIImage*)image byDegree:(CGFloat)degrees
{
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DEGREES_TO_RADIAN(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    
    CGContextTranslateCTM(bitmap, rotatedSize.width, rotatedSize.height);
    
    CGContextRotateCTM(bitmap, DEGREES_TO_RADIAN(degrees));
    
    
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-image.size.width, -image.size.height, image.size.width, image.size.height), [image CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
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

# pragma mark- custom Action Methods

- (IBAction)readMoreButton:(id)sender {
    NSURL *url = [NSURL URLWithString:@"https://en.wikipedia.org/wiki/India"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}


- (IBAction)homeIconButton:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navVC = (UINavigationController*)[storyBoard instantiateViewControllerWithIdentifier:@"AboutNAVVCSID"];
    [self.revealViewController setFrontViewController:navVC];
    [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated: YES];

    
}


- (IBAction)playNationalSongButton:(id)sender {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Vandemataram" message:@"Want to play" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* video = [UIAlertAction
                            actionWithTitle:@"YouTube Video"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                [self openYoutube:@"jDn2bn7_YSM"];
                                [alert dismissViewControllerAnimated:YES completion:nil];
                                
                            }];
    UIAlertAction* music = [UIAlertAction
                            actionWithTitle:@"Music"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                songCheck = 1;
                                if ([appDelegate.audioPlayer isPlaying])
                                {
                                    [appDelegate.audioPlayer stop];
                                    [appDelegate playSong:Kvandemataram];
                                }else
                                {
                                    [appDelegate playSong:Kvandemataram];

                                }
                                
                                [alert dismissViewControllerAnimated:YES completion:nil];
                                
                            }];
    
    UIAlertAction* cancel = [UIAlertAction
                            actionWithTitle:@"Cancel"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                [alert dismissViewControllerAnimated:YES completion:nil];
                                
                            }];
    
    UIAlertAction* mute = [UIAlertAction
                           actionWithTitle:@"Mute Audio"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
                           {
                               if ([appDelegate.audioPlayer isPlaying])
                               {
                                   [appDelegate.audioPlayer stop];
                                   songCheck = 0;
                               }
                               
                               [alert dismissViewControllerAnimated:YES completion:nil];
                               
                           }];
    
    
    if (songCheck==1) {
        [alert addAction:mute];
        
    }
    
    [alert addAction:video];
    [alert addAction:music];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
   // [self alertWithText:@"JanaGanaMana" withText1:@"Video" AndText2:@"Music"];
    
}

- (IBAction)playNationalAnthemBUtton:(id)sender
{

    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"JanaGanaMana" message:@"Want to play" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* video = [UIAlertAction
                            actionWithTitle:@"YouTube Video"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                [self openYoutube:@"HtMF973tXIY"];
                                [alert dismissViewControllerAnimated:YES completion:nil];
                                
                            }];
    UIAlertAction* music = [UIAlertAction
                            actionWithTitle:@"Music"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                anthemCheck = 1;
                                if ([appDelegate.audioPlayer isPlaying])
                                {
                                    [appDelegate.audioPlayer stop];
                                    [appDelegate playSong:Kjanaganamana];
                                }else
                                {
                                    [appDelegate playSong:Kjanaganamana];
                                    
                                }
                                [alert dismissViewControllerAnimated:YES completion:nil];
                                
                            }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 
                                 
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    UIAlertAction* mute = [UIAlertAction
                            actionWithTitle:@"Mute Audio"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                if ([appDelegate.audioPlayer isPlaying])
                                {
                                    [appDelegate.audioPlayer stop];
                                    anthemCheck = 0;
                                }
                               
                                [alert dismissViewControllerAnimated:YES completion:nil];
                                
                            }];
    
    
    if (anthemCheck==1) {
        [alert addAction:mute];

    }
    [alert addAction:video];
    [alert addAction:music];
    [alert addAction:cancel];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

- (IBAction)readAbutNationalFlag:(id)sender {
    
    
    
    NSURL *url = [NSURL URLWithString:@"https://en.wikipedia.org/wiki/Flag_of_India"];

    
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}




# pragma mark- custom Methods 


-(void)alertWithText:(NSString *)message withText1:(NSString*)test1 AndText2:(NSString*)text2
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Info"
                                  message:@"You are using UIAlertController"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* video = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [self openYoutube:@"jDn2bn7_YSM"];
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* music = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    
    
    [alert addAction:video];
    [alert addAction:music];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)openYoutube :(NSString *)channelID{
  
    NSURL *linkToWebURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@",channelID]];
    
    if ([[UIApplication sharedApplication] canOpenURL:linkToWebURL]) {
        // Can open the youtube app URL so launch the youTube app with this URL
        [[UIApplication sharedApplication] openURL:linkToWebURL];
    }
    else{
        // Can't open the youtube app URL so launch Safari instead
        [[UIApplication sharedApplication] openURL:linkToWebURL];
    }
}

-(void)updateConstraints{
    CGRect screenSize = [UIScreen mainScreen].bounds;
    if (screenSize.size.height == 480) {
        self.aboutIndiaIconTopConstraints.constant = 55;
        self.aboutIndiaLeftConstraints.constant=95;
        self.ashokChakraTopConstraints.constant = 120;
        
    }
    else if (screenSize.size.height == 568) {
        self.aboutIndiaIconTopConstraints.constant = 80;
        self.aboutIndiaLeftConstraints.constant=90;
         self.ashokChakraTopConstraints.constant = 140;
        
    }
    else if (screenSize.size.height == 667) {
        self.aboutIndiaIconTopConstraints.constant = 105;
        self.aboutIndiaLeftConstraints.constant=120;
        self.ashokChakraTopConstraints.constant = 190;
        
    }
    else if (screenSize.size.height == 736) {
        self.aboutIndiaIconTopConstraints.constant = 122;
        self.aboutIndiaLeftConstraints.constant=125;
          self.ashokChakraTopConstraints.constant = 220;
        
    }
    
}

# pragma mark- View deleagte Methods

- (void)viewDidLayoutSubviews {
    [self.textView setContentOffset:CGPointZero animated:NO];
}

@end
