//
//  StatesViewController.m
//  AboutIndia
//
//  Created by Nilesh on 01/06/16.
//  Copyright © 2016 Nilesh. All rights reserved.
//

#import "StatesViewController.h"
#import "SWRevealViewController.h"
#import "StatesDetailController.h"
#import "Constants.h"

@interface StatesViewController ()<SWRevealViewControllerDelegate>
@property(nonatomic,strong) NSArray *statesDetailArray;
@property(nonatomic,strong) NSArray *statesArray;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@end

@implementation StatesViewController

#pragma mark - AppLifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

    SWRevealViewController *revealViewController = self.revealViewController;
    revealViewController.delegate = self;
    if ( revealViewController )
    {
        [_menuButton addTarget:self.revealViewController  action:@selector(revealToggle:) forControlEvents:UIControlEventTouchDown];

        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    CLLocationCoordinate2D india = CLLocationCoordinate2DMake(22.5954492,77.4886171);
    
    [self.mapView setRegion: MKCoordinateRegionMakeWithDistance(india, 4555000, 2305000)];
    
    [self.mapView setMapType: MKMapTypeStandard];
    [self getDataFromPlist];
    [self addAnnotations];
   // [self UpdateUI];


   
    // Do any additional setup after loading the view.
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

# pragma mark- custom Methods

-(void)getDataFromPlist{
    
    NSString *stateDetailPath = [[NSBundle mainBundle] pathForResource:@"StatesDetail" ofType:@"plist"];
    NSDictionary *stateDetailDict = [[NSDictionary alloc] initWithContentsOfFile:stateDetailPath];
    _statesDetailArray = [stateDetailDict objectForKey:@"StatesDetailDict"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"States" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    _statesArray = [dict objectForKey:@"State"];

    
}
-(void)addAnnotations{
    
    for (int i =0; i<[_statesDetailArray count]; i++) {
        NSDictionary *dictonaryData;;
        dictonaryData = [ _statesDetailArray objectAtIndex:i];
        double lattitude = [ [dictonaryData objectForKey:@"lat"]doubleValue];
         double longitude = [ [dictonaryData objectForKey:@"lon"]doubleValue];
      //  NSLog(@"The latitude value is %f",lattitude);
        CLLocationCoordinate2D userCoord;
        userCoord.latitude = lattitude;
        userCoord.longitude = longitude;
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = userCoord;
        point.title = [dictonaryData objectForKey:@"Capital"];
        NSLog(@"The capital is %@",point.title);
        
        [self.mapView addAnnotation:point];
    }
   
}


# pragma mark- MapView Delegate  Methods
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view

{
    MKPointAnnotation *testPoint = [[MKPointAnnotation alloc] init];
    testPoint = view.annotation;
    for (int i = 0; i< [_statesDetailArray count]; i++) {
        NSDictionary *dictonaryData;;
        dictonaryData = [ _statesDetailArray objectAtIndex:i];
        if ([testPoint.title isEqualToString:[dictonaryData objectForKey:@"Capital"]]) {
            
            StatesDetailController *stateDetailController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"StatesDetailVCSID"];
            stateDetailController.stateName  =[_statesArray objectAtIndex:i];
            stateDetailController.index = i;
            [self.navigationController pushViewController:stateDetailController animated:YES];
        }
        
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
