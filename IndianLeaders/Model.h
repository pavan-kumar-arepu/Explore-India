//
//  Model.h
//  AboutIndia
//
//  Created by PPAM on 7/12/16.
//  Copyright © 2016 Nilesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject


@property(assign) BOOL presidentCheck;
@property(assign) BOOL famousPersonalityCheck;
@property(assign) BOOL monumentsCheck;
@property(assign) BOOL nationalThingCheck;
@property(assign) BOOL fistInstanceCheck;
@property(assign) BOOL appLaunchCheck;
+(Model*)getInstance;
@end

