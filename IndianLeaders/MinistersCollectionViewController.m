//
//  MinistersCollectionViewController.m
//  AboutIndia
//
//  Created by PPAM on 8/4/16.
//  Copyright © 2016 Nilesh. All rights reserved.
//

#import "MinistersCollectionViewController.h"
#import "MinistersCollectionViewCell.h"
#import "Model.h"
#import "FormerMinisterViewController.h"

@interface MinistersCollectionViewController (){
     NSArray *pmListarray;
    Model *model;
    
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *MinisterLabel;

@end

@implementation MinistersCollectionViewController

#pragma  mark - App Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    model = [Model getInstance];
    [self getDataFromPlist];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom  Methods

-(void)getDataFromPlist{
    NSString *path;
    if (model.presidentCheck) {
      path   = [[NSBundle mainBundle] pathForResource:@"President" ofType:@"plist"];
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        pmListarray = [dict objectForKey:@"PresidentDict"];
        self.MinisterLabel.text = @"Former Presidents";
    }
        else{
        path   = [[NSBundle mainBundle] pathForResource:@"PMList" ofType:@"plist"];
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        pmListarray = [dict objectForKey:@"PMDict"];
          self.MinisterLabel.text = @"Former Prime Ministers";
    }
   
}



#pragma mark - collectionView DataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [pmListarray count]-1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MinistersCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [[cell contentView] setFrame:[cell bounds]];
    [[cell contentView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];

    NSDictionary *dict = [ pmListarray objectAtIndex:indexPath.row+1];
   cell.ministerImage.image = [UIImage imageNamed: [dict objectForKey:@"imageName"]];
    cell.ministerTenure.text = [dict objectForKey:@"tenure"];
   cell.ministerName.text = [dict objectForKey:@"name"];
    cell.ministerName.adjustsFontSizeToFitWidth = YES;
    cell.ministerTenure.adjustsFontSizeToFitWidth = YES;
    cell.ministerImage.layer.borderWidth=5.0f;
    cell.ministerImage.layer.borderColor=[UIColor whiteColor].CGColor;
    
    return cell;
}


#pragma mark - collectionView Delegates

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FormerMinisterViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FormerMinisterViewController"];
    controller.ministerDetailArray =pmListarray;
    NSInteger row = indexPath.row;
    NSInteger section = row+1;
    controller.index= section;
    [self.navigationController pushViewController:controller animated:YES];
    
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
