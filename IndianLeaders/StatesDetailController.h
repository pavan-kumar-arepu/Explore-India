//
//  StatesDetailController.h
//  AboutIndia
//
//  Created by Nilesh on 06/06/16.
//  Copyright © 2016 Nilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatesDetailController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItem;
@property (weak, nonatomic) IBOutlet UILabel *stateNameLabel;
@property(strong,nonatomic) NSString *stateName;
@property(assign) NSInteger index;
@property (weak, nonatomic) IBOutlet UIScrollView *stateDetailScrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollViewSubView;
@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;

@property (weak, nonatomic) IBOutlet UITableView *statesDetailTableView;

@end
