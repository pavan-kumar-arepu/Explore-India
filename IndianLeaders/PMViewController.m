//
//  PMViewController.m
//  IndianLeaders
//
//  Created by Nilesh on 27/05/16.
//  Copyright © 2016 Nilesh. All rights reserved.
//

#import "PMViewController.h"
#import "ListViewController.h"
#import "SWRevealViewController.h"
#import "Constants.h"
#import "MinistersCollectionViewController.h"
#import "Model.h"

@interface PMViewController ()<SWRevealViewControllerDelegate>{
    NSArray *pmListarray;
    NSString *urlString;
    NSInteger loopCount;
    Model *model;
}
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UILabel *ministerLabel;
@property (weak, nonatomic) IBOutlet UIButton *formerButton;
@property (weak, nonatomic) IBOutlet UIImageView *ministerImageView;
@property (weak, nonatomic) IBOutlet UILabel *ministerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ministerCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descriptiveTextViewHeightConstraints;

@end

@implementation PMViewController

#pragma mark - AppLifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    model = [Model getInstance];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [_menuButton addTarget:self.revealViewController  action:@selector(revealToggle:) forControlEvents:UIControlEventTouchDown];
        
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
     [self getDataFromPlist];
    [self updateConstraints];
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark- custom Methods



-(void)getDataFromPlist{
    
    NSString *path;
    if (model.presidentCheck) {
        path   = [[NSBundle mainBundle] pathForResource:@"President" ofType:@"plist"];
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        pmListarray = [dict objectForKey:@"PresidentDict"];
        self.ministerLabel.text = @"The President";
        [self.formerButton setTitle:@"Former Presidents" forState:UIControlStateNormal];
        [self changeUI:0];
    }
    else{
        path   = [[NSBundle mainBundle] pathForResource:@"PMList" ofType:@"plist"];
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        pmListarray = [dict objectForKey:@"PMDict"];
         self.ministerLabel.text = @"The Prime Minister";
         [self.formerButton setTitle:@"Former Prime Ministers" forState:UIControlStateNormal];
         [self changeUI:0];
    }

    
}

-(void)changeUI: (NSInteger) count{
    NSDictionary *dict = [ pmListarray objectAtIndex:count];
     self.ministerImageView.image = [UIImage imageNamed: [dict objectForKey:@"imageName"]];
    self.ministerCountLabel.text = [dict objectForKey:@"countNo"];
    
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment: NSTextAlignmentJustified];
    
    NSAttributedString * subText1 = [[NSAttributedString alloc] initWithString:[dict objectForKey:@"descrpition"] attributes:@{
                                                                                                  NSParagraphStyleAttributeName : style
                                                                                                  }];
    
    _descriptTextView.attributedText = subText1;
    
   // self.descriptTextView.text = [dict objectForKey:@"descrpition"];
    self.ministerNameLabel.text = [dict objectForKey:@"name"];
  }


-(void)updateConstraints{
    CGRect screenSize = [UIScreen mainScreen].bounds;
    if (screenSize.size.height == 480) {
        self.imageHeightConstraints.constant = 284;
        self.descriptiveTextViewHeightConstraints.constant=850;
        
    }
    else if (screenSize.size.height == 568) {
        self.imageHeightConstraints .constant= 284;
           self.descriptiveTextViewHeightConstraints.constant=850;
        
    }
    else if (screenSize.size.height == 667) {
      self.imageHeightConstraints .constant= 320;
           self.descriptiveTextViewHeightConstraints.constant=720;
        
    }
    else if (screenSize.size.height == 736) {
       self.imageHeightConstraints .constant= 350;
           self.descriptiveTextViewHeightConstraints.constant=700;
        
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
 
 */

#pragma mark - SWRevealViewController Delegate Methods
- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}


# pragma mark- Action Methods

- (IBAction)readMoreButtonAction:(id)sender {
    NSURL *url = [NSURL URLWithString:urlString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

- (IBAction)formerPrimeMinister:(id)sender {//MinistersCollectionViewController
    MinistersCollectionViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MinistersCollectionViewController"];
    [self.navigationController pushViewController:controller animated:YES];
    
    
}

# pragma mark- View deleagte Methods

- (void)viewDidLayoutSubviews {
    [self.descriptTextView setContentOffset:CGPointZero animated:NO];
}


@end


