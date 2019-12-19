//
//  StatesViewController.h
//  AboutIndia
//
//  Created by Nilesh on 01/06/16.
//  Copyright © 2016 Nilesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface StatesViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
 @property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end


