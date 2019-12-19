//
//  PMViewController.h
//  IndianLeaders
//
//  Created by Nilesh on 27/05/16.
//  Copyright © 2016 Nilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIImageView *pmImageView;
@property (weak, nonatomic) IBOutlet UILabel *tenureLabel;
@property (weak, nonatomic) IBOutlet UILabel *pmCountLabel;

@property (weak, nonatomic) IBOutlet UITextView *descriptTextView;
@property (weak, nonatomic) IBOutlet UILabel *pmNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end
