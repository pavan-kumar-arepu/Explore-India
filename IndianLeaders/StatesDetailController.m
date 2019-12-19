//
//  StatesDetailController.m
//  AboutIndia
//
//  Created by Nilesh on 06/06/16.
//  Copyright © 2016 Nilesh. All rights reserved.
//

#import "StatesDetailController.h"
#import "Constants.h"

@interface StatesDetailController (){
    NSArray *statedetailarray;
    NSString *wikistring;
    NSString *websiteString;
    NSDictionary *dictonaryData;
    
}


@end

@implementation StatesDetailController
# pragma mark- App Life Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stateNameLabel.text = self.stateName;
    self.stateDetailScrollView.accessibilityActivationPoint = CGPointMake(0, 0);
     self.stateDetailScrollView.minimumZoomScale = 0.5;
     self.stateDetailScrollView.maximumZoomScale = 3;
    [self getDataFromPlist];
    [self chnageUI:self.index];
    [self updateUI];
    self.statesDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


# pragma - mark Custom Methods

-(void)getDataFromPlist{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"StatesDetail" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    statedetailarray = [dict objectForKey:@"StatesDetailDict"];
    
}
-(void)chnageUI:(NSInteger) index{
    dictonaryData = [ statedetailarray objectAtIndex:index];
    self.stateImageView.image = [UIImage imageNamed: [dictonaryData objectForKey:@"Image"]];
    wikistring =  [dictonaryData objectForKey:@"WikiURL"];
    websiteString =  [dictonaryData objectForKey:@"Website"];
    
}
-(void)updateUI{
    [self.stateDetailScrollView setContentOffset:
     CGPointMake(0, -self.stateDetailScrollView.contentInset.top) animated:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}


# pragma - markAction Methods


- (IBAction)readMoreActionButton:(id)sender {
    NSURL *url = [NSURL URLWithString:wikistring];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

- (IBAction)officialWebsiteActionButton:(id)sender {
    NSURL *url = [NSURL URLWithString:websiteString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

- (IBAction)barButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


# pragma - mark table view Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row ==0) {
        cell.textLabel.text = [NSString stringWithFormat:@"Capital City - %@",[dictonaryData objectForKey:@"Capital"]];
      
    }
    else if (indexPath.row ==1){
       cell.textLabel.text =   [NSString stringWithFormat:@"Region - %@",[dictonaryData objectForKey:@"Region"]];
    }
    else if (indexPath.row ==2){
        cell.textLabel.text =  [NSString stringWithFormat:@"Total Population - %@",[dictonaryData objectForKey:@"Population"]];
    }
    else if (indexPath.row ==3){
        cell.textLabel.text =   [NSString stringWithFormat:@"Total area Covered - %@",[dictonaryData objectForKey:@"Area"]];
    }
    else if (indexPath.row ==4){
        cell.textLabel.text =  [NSString stringWithFormat:@"Official language - %@",[dictonaryData objectForKey:@"Language"]];
    }
    else if (indexPath.row ==5){
        cell.textLabel.text =   [NSString stringWithFormat:@"State Rank - %@",[dictonaryData objectForKey:@"StateRank"]];
    }
    else if (indexPath.row ==6){
        cell.textLabel.text =  [NSString stringWithFormat:@"Literacy Rate - %@",[dictonaryData objectForKey:@"LiteracyRate"]];
    }
    else if (indexPath.row ==7){
        cell.textLabel.text =  [NSString stringWithFormat:@"Area Rank - %@",[dictonaryData objectForKey:@"AreaRank"]];
    }
    
    
   
    return cell;
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
