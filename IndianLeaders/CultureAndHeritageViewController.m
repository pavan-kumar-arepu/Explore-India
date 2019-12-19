//
//  CultureAndHeritageViewController.m
//  AboutIndia
//
//  Created by PPAM on 8/3/16.
//  Copyright © 2016 Nilesh. All rights reserved.
//

#import "CultureAndHeritageViewController.h"
#import "SWRevealViewController.h"


@interface CultureAndHeritageViewController ()
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cultureIconTrailingConstraints;


@end

@implementation CultureAndHeritageViewController

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
    [self updateConstraints];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - Custom  Methods

-(void)updateConstraints{
    CGRect screenSize = [UIScreen mainScreen].bounds;
    if (screenSize.size.height == 480) {
        self.cultureIconTrailingConstraints.constant = 33;
    
        
    }
    else if (screenSize.size.height == 568) {
        self.cultureIconTrailingConstraints.constant = 33;
      
        
    }
    else if (screenSize.size.height == 667) {
        self.cultureIconTrailingConstraints.constant = 45;
        
    }
    else if (screenSize.size.height == 736) {
        self.cultureIconTrailingConstraints.constant = 47;
   
        
    }
    
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
