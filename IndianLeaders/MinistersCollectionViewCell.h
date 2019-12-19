//
//  MinistersCollectionViewCell.h
//  AboutIndia
//
//  Created by PPAM on 8/4/16.
//  Copyright © 2016 Nilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinistersCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ministerImage;
@property (weak, nonatomic) IBOutlet UILabel *ministerName;
@property (weak, nonatomic) IBOutlet UILabel *ministerTenure;
@end
