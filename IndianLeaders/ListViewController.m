//
//  ListViewController.m
//  AboutIndia
//
//  Created by PPAM on 8/2/16.
//  Copyright © 2016 Nilesh. All rights reserved.
//

#import "ListViewController.h"
#import "SideBarTableCell.h"
#import "Model.h"

@interface ListViewController ()<SWRevealViewControllerDelegate>

@end

@implementation ListViewController{
     NSArray *menuItems;
    Model *model;
    
}

#pragma mark - AppLifeCycle Methods


- (void)viewDidLoad {
    [super viewDidLoad];
     [[self navigationController] setNavigationBarHidden:YES animated:YES];
    menuItems = @[@"About India",@"Culture & Heritage", @"The Prime Minister", @"The President",@"States",@"Celebrities",@"Monuments",@"National Symbol",@"Share",@"About"];
     self.revealViewController.rearViewRevealWidth = 320;
    
    model = [Model getInstance];
    CGRect screenSize = [UIScreen mainScreen].bounds;
    if (screenSize.size.height == 480) {
         self.sideBarTableView.scrollEnabled = YES;
    }
    else{
        self.sideBarTableView.scrollEnabled = NO;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma - mark TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuItems count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SideBarTableCell";
    SideBarTableCell *cell = (SideBarTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SideBarTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.CellNameLabel.text = [menuItems objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    
  
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL check = false;
    NSString *navStoryBoardId;

    switch (indexPath.row) {
        case 0:
            check = true;
            navStoryBoardId = @"MainNavVCSID";
            break;
            
        case 1:
            check = true;
            navStoryBoardId = @"CultureNAVVCSID";
            break;
            
        case 2:
            if (!model.appLaunchCheck) {
                [self showAlert];
                model.appLaunchCheck = true;
            }
            else{
                check = true;
                model.presidentCheck = false;
                model.famousPersonalityCheck = false;
                navStoryBoardId = @"PMNavVCSID";
            }
            
            break;
            
        case 3:
            check = true;
            navStoryBoardId = @"PMNavVCSID";
            model.presidentCheck = true;
            model.famousPersonalityCheck = false;
            model.monumentsCheck = false;
            model.nationalThingCheck = false;
            break;
            
        case 4:
            check = true;
            navStoryBoardId = @"StatesNavVCSID";
            break;
            
        case 5:
            navStoryBoardId = @"FamousPersonalityNAVVCSID";
            check = true;
            model.famousPersonalityCheck = true;
            model.presidentCheck = false;
            model.monumentsCheck = false;
            model.nationalThingCheck = false;
            break;
            
        case 6:
            navStoryBoardId = @"FamousPersonalityNAVVCSID";
            check = true;
            model.famousPersonalityCheck = false;
            model.presidentCheck = false;
            model.monumentsCheck = true;
            model.nationalThingCheck = false;

            break;
            
        case 7:
            check = true;
             navStoryBoardId = @"FamousPersonalityNAVVCSID";
            model.famousPersonalityCheck = false;
            model.presidentCheck = false;
            model.monumentsCheck = false;
            model.nationalThingCheck = true;
            break;
            
        case 8:
        {
            NSString *textToShare = @"Download and Look at this awesome app for knowing Incredible India!";
            NSURL *myWebsite = [NSURL URLWithString:@"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1141824247&mt=8"];
            
            NSURL *myFacebook = [NSURL URLWithString:@"https://www.facebook.com/Explore-India-274937932892268/"];
            
            
            NSArray *objectsToShare = @[textToShare, myWebsite,myFacebook];
            UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
            [self presentViewController:activityVC animated:YES completion:nil];
            
        }
            break;
        case 9:
            check = true;
            navStoryBoardId = @"AboutNAVVCSID";
            break;
        default:
            break;
    }
   
    
    if (indexPath.row == menuItems.count-2) {
        NSString *textToShare = @"Download and Look at this awesome app for knowing Incredible India!";
        NSURL *myWebsite = [NSURL URLWithString:@"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1141824247&mt=8"];
        
        NSURL *myFacebook = [NSURL URLWithString:@"https://www.facebook.com/Explore-India-274937932892268/"];
        
        
        
        
        
        
        NSArray *objectsToShare = @[textToShare, myWebsite,myFacebook];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    
    
    if (check == true) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *navVC = (UINavigationController*)[storyBoard instantiateViewControllerWithIdentifier:navStoryBoardId];
        [self.revealViewController setFrontViewController:navVC];
        [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated: YES];
        
        
    }
}


# pragma - mark Action Methods

- (IBAction)leftBarButtonAction:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navVC = (UINavigationController*)[storyBoard instantiateViewControllerWithIdentifier:@"MainNavVCSID"];
    [self.revealViewController setFrontViewController:navVC];
    [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated: YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

# pragma - mark CustomMethods

-(void)showAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Hey!" message:@"Want to try our other app for this?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              ;
                                                              [self alertYesAction];
                                                          }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             [self alertNoAction];
                                                         }];
    
    [alertController addAction:defaultAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


-(void)alertYesAction{
    
    NSString *iTunesLink = @"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1029872627&mt=8";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
    
    
}

-(void)alertNoAction{
    model.presidentCheck = false;
    model.famousPersonalityCheck = false;
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navVC = (UINavigationController*)[storyBoard instantiateViewControllerWithIdentifier:@"PMNavVCSID"];//CultureNAVVCSID//PMNavVCSID
    [self.revealViewController setFrontViewController:navVC];
    [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated: YES];
    
    
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
