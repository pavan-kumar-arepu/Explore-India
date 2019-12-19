//
//  FamousPersonalityController.m
//  AboutIndia
//
//  Created by Nilesh on 07/06/16.
//  Copyright © 2016 Nilesh. All rights reserved.
//

#import "FamousPersonalityController.h"
#import "SWRevealViewController.h"
#import "FamousPersonCollectionViewCell.h"
#import "Constants.h"
#import "FormerMinisterViewController.h"
#import "Model.h"



@interface FamousPersonalityController ()<SWRevealViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UILabel *menuLabel;
@end

@implementation FamousPersonalityController{
    NSArray *detailArray;
    NSArray *menuItems;
    NSMutableArray *pmListarray;
    Model *model;
}
#pragma mark - App Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    model = [Model getInstance];
    SWRevealViewController *revealViewController = self.revealViewController;
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    revealViewController.delegate = self;
    if ( revealViewController )
    {
        [_menuButton addTarget:self.revealViewController  action:@selector(revealToggle:) forControlEvents:UIControlEventTouchDown];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [self getDataFromPlist];
}

#pragma mark - custom  Methods

-(void)getDataFromPlist{
    NSString *path;
    NSDictionary *dict;
    if (model.monumentsCheck) {
        pmListarray = [[NSMutableArray alloc]init];
        path   = [[NSBundle mainBundle] pathForResource:@"Monuments" ofType:@"plist"];
        dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        pmListarray = [dict objectForKey:@"monumentsDict"];
        self.menuLabel.text = @"Famous Monument Of India";
        }
    else if (model.nationalThingCheck){
        pmListarray = [[NSMutableArray alloc]init];
        path   = [[NSBundle mainBundle] pathForResource:@"NationalThing" ofType:@"plist"];
        dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        pmListarray = [dict objectForKey:@"NationalThingDict"];
        self.menuLabel.text = @"National Things Of India";
        
    }
    else{
        pmListarray = [[NSMutableArray alloc]init];
        path   = [[NSBundle mainBundle] pathForResource:@"FamousPerson" ofType:@"plist"];
        dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        pmListarray = [dict objectForKey:@"FamousPersonDict"];
          self.menuLabel.text = @"Famous Person Of India";
    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

#pragma mark - collectionView DataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [pmListarray count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FamousPersonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell1" forIndexPath:indexPath];
    NSDictionary *dict = [ pmListarray objectAtIndex:indexPath.row];
   cell.personImage.image = [UIImage imageNamed: [dict objectForKey:@"image"]];
    cell.personName.adjustsFontSizeToFitWidth = YES;
    cell.personImage.layer.borderWidth=5.0f;
    cell.personImage.layer.borderColor=[UIColor whiteColor].CGColor;
    if (model.nationalThingCheck) {
        cell.personName.text = [NSString stringWithFormat:@"%@(%@)",[dict objectForKey:@"description"],[dict objectForKey:@"name"]];
        cell.personName.adjustsFontSizeToFitWidth= YES;
    }
    else{
        cell.personName.text = [dict objectForKey:@"name"];
    }
    return cell;
}


#pragma mark - collectionView Delegates

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!model.nationalThingCheck) {
        FormerMinisterViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FormerMinisterViewController"];
        controller.ministerDetailArray =pmListarray;
        NSInteger row = indexPath.row;
        controller.index= row;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize sizeOfCollection;
    if (model.monumentsCheck)
    {
         sizeOfCollection = CGSizeMake(200, 200);
    }
    else if (model.nationalThingCheck){
        
         sizeOfCollection = CGSizeMake(205, 205);
    }
    else
    {
        sizeOfCollection = CGSizeMake(150, 150);
    }
    return sizeOfCollection;
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
        UIView *cellContentView  = [cell contentView];
        CGFloat rotationAngleDegrees = -100;
        CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
        CGPoint offsetPositioning = CGPointMake(500, -20.0);
        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DRotate(transform, rotationAngleRadians, -50.0, 0.0, 1.0);
        transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, -50.0);
        cellContentView.layer.transform = transform;
        cellContentView.layer.opacity = 0.8;
        
        [UIView animateWithDuration:.65 delay:0.0 usingSpringWithDamping:0.85 initialSpringVelocity:.8 options:0 animations:^{
            cellContentView.layer.transform = CATransform3DIdentity;
            cellContentView.layer.opacity = 1;
        } completion:^(BOOL finished) {}];

}


#pragma mark - Action Methods

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
