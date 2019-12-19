//
//  FormerMinisterViewController.m
//  AboutIndia
//
//  Created by PPAM on 8/4/16.
//  Copyright © 2016 Nilesh. All rights reserved.
//

#import "FormerMinisterViewController.h"
#import "Model.h"

@interface FormerMinisterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ministerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ministerImageView;
@property (weak, nonatomic) IBOutlet UILabel *ministerName;
@property (weak, nonatomic) IBOutlet UILabel *ministerCount;
@property (weak, nonatomic) IBOutlet UITextView *descritiveTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descriptiveTextViewHeightConstraints;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation FormerMinisterViewController{
    NSString *urlString;
    Model *model;
}

#pragma  mark - App Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    model = [Model getInstance];
       if (model.presidentCheck) {
        self.ministerLabel.text = @"Former Presidents";
    }
       else if (model.famousPersonalityCheck){
           self.ministerLabel.text = @"Famous Persons";

       }
       else if (model.monumentsCheck){
           self.ministerLabel.text = @"Famous Monuments";
           
       }
    else{
        self.ministerLabel.text = @"Former Prime Ministers";
    }
    self.ministerLabel.adjustsFontSizeToFitWidth = YES;
    [self updateConstraints];
    [self.descritiveTextView setFont:[UIFont systemFontOfSize:16]];
    [self updateUI:self.index];
    _pageControl.numberOfPages = [self.ministerDetailArray count];
    _pageControl.currentPage = _index;
   
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor=[UIColor darkGrayColor];

    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeleft];
    
    UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swiperight];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - Custom Methods

-(void)updateUI:(NSInteger)index{
      [self addanimation];
     NSDictionary *ministerDetailDict = [self.ministerDetailArray objectAtIndex:index];
    if (model.famousPersonalityCheck || model.monumentsCheck) {
        self.ministerImageView.image = [UIImage imageNamed: [ministerDetailDict objectForKey:@"image"]];
        [self.ministerCount setHidden:YES];
        self.ministerName.text = [ministerDetailDict objectForKey:@"name"];
        
        
        NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setAlignment: NSTextAlignmentJustified];
        
        NSAttributedString * subText1 = [[NSAttributedString alloc] initWithString:[ministerDetailDict objectForKey:@"description"] attributes:@{
                                                                                                                                   NSParagraphStyleAttributeName : style
                                                                                                                                   }];
        
                self.descritiveTextView.attributedText = subText1;
       // self.descritiveTextView.text = [ministerDetailDict objectForKey:@"description"];
        urlString =  [ministerDetailDict objectForKey:@"wikiLink"];
        if (model.monumentsCheck) {
            self.imageViewWidth.constant = 180;
        }
        else{
             self.imageViewWidth.constant = 150;
        }
    }
    else{
        self.ministerImageView.image = [UIImage imageNamed: [ministerDetailDict objectForKey:@"imageName"]];
        self.ministerCount.text = [ministerDetailDict objectForKey:@"countNo"];
        self.ministerName.text = [ministerDetailDict objectForKey:@"name"];
        NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setAlignment: NSTextAlignmentJustified];
        
        NSAttributedString * subText1 = [[NSAttributedString alloc] initWithString:[ministerDetailDict objectForKey:@"descrpition"] attributes:@{
                                                                                                                                                 NSParagraphStyleAttributeName : style
                                                                                                                                                 }];
        
        self.descritiveTextView.attributedText = subText1;

       // self.descritiveTextView.text = [ministerDetailDict objectForKey:@"descrpition"];
        urlString =  [ministerDetailDict objectForKey:@"wikiLink"];
         self.imageViewWidth.constant = 150;

    }
}

-(void)addanimation{
    CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    [animation setDuration:3.5f];
    [animation setTimingFunction:UIViewAnimationCurveEaseInOut];
    [animation setType:@"rippleEffect" ];
    [self.descritiveTextView.layer addAnimation:animation forKey:NULL];
    [self.ministerImageView.layer addAnimation:animation forKey:NULL];
    [self.ministerCount.layer addAnimation:animation forKey:NULL];
    [self.ministerName.layer addAnimation:animation forKey:NULL];
    
    CABasicAnimation *animationView = [CABasicAnimation animationWithKeyPath:@"transform"];
    self.view.layer.zPosition = 100;
    CATransform3D transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    transform.m34 = 1.0/800.0;
    [animationView setToValue:[NSValue valueWithCATransform3D:transform]];
    [animationView setDuration:1.5];
    [animationView setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [animationView setFillMode:kCAFillModeForwards];
    [animationView setRemovedOnCompletion:YES];
    [animationView setDelegate:self];
    //[self.view.layer addAnimation:animationView forKey:@"test"];
    
}


-(void)updateConstraints{
    CGRect screenSize = [UIScreen mainScreen].bounds;
    if (screenSize.size.height == 480) {
        self.imageHeightConstraints.constant = 284;
        self.descriptiveTextViewHeightConstraints.constant=850;
        if (model.presidentCheck) {
             _pageControl.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
        else if(model.famousPersonalityCheck){
            _pageControl.transform = CGAffineTransformMakeScale(0.52, 0.52);
        }
        else if (model.monumentsCheck){
             _pageControl.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
        else{
            _pageControl.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
        
    }
    else if (screenSize.size.height == 568) {
        self.imageHeightConstraints.constant= 284;
        self.descriptiveTextViewHeightConstraints.constant=850;
        if (model.presidentCheck) {
            _pageControl.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
        else if(model.famousPersonalityCheck){
            _pageControl.transform = CGAffineTransformMakeScale(0.52, 0.52);
        }
        else if (model.monumentsCheck){
            _pageControl.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
        else{
            _pageControl.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }

        
    }
    else if (screenSize.size.height == 667) {
        self.imageHeightConstraints.constant= 320;
        self.descriptiveTextViewHeightConstraints.constant=720;
        if (model.presidentCheck) {
            _pageControl.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
        else if(model.famousPersonalityCheck){
            _pageControl.transform = CGAffineTransformMakeScale(0.6, 0.6);
        }
        else if (model.monumentsCheck){
            _pageControl.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
        else{
            _pageControl.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }

        
    }
    else if (screenSize.size.height == 736) {
        self.imageHeightConstraints.constant= 350;
        self.descriptiveTextViewHeightConstraints.constant=700;
        if (model.presidentCheck) {
            _pageControl.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
        else if(model.famousPersonalityCheck){
            _pageControl.transform = CGAffineTransformMakeScale(0.65, 0.65);
        }
        else if (model.monumentsCheck){
            _pageControl.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
        else{
            _pageControl.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
        
    }
    
}

#pragma  mark - Action Methods

- (IBAction)readMoreActionButton:(id)sender {
    NSURL *url = [NSURL URLWithString:urlString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    
    if (self.index<[self.ministerDetailArray count]-1) {
        self.index++;
        _pageControl.currentPage = _index;
        [self updateUI:self.index];
    }
    else{
     // [self showAlert];
    }
    //Do what you want here
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if (self.index>1) {
        self.index--;
        _pageControl.currentPage = _index;
        [self updateUI:self.index];
    }
    else{
        //[self showAlert];
    }
    //Do what you want here
}


-(void)showAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Please Swipe the other side." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              ;
                                                              
                                                          }];
    

    [alertController addAction:defaultAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
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
