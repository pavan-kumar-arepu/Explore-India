//
//  AboutUsViewController.m
//  AboutIndia
//
//  Created by Nilesh on 08/06/16.
//  Copyright © 2016 Nilesh. All rights reserved.
//

#import "AboutUsViewController.h"
#import "SWRevealViewController.h"
#import "Constants.h"

@interface AboutUsViewController ()<SWRevealViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@end

@implementation AboutUsViewController

#pragma  mark - App Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [_menuButton addTarget:self.revealViewController  action:@selector(revealToggle:) forControlEvents:UIControlEventTouchDown];
        
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
  
    
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods

- (IBAction)sideBarButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)shareButtonAction:(id)sender {
    NSString *textToShare = @"Download and Look at this awesome app for knowing Incredible India!";
    NSURL *myWebsite = [NSURL URLWithString:@"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1141824247&mt=8"];
    
    NSURL *myFacebook = [NSURL URLWithString:@"https://www.facebook.com/Explore-India-274937932892268/"];
    
    
    NSArray *objectsToShare = @[textToShare, myWebsite,myFacebook];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
    
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
