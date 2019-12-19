//
//  Model.m
//  AboutIndia
//
//  Created by PPAM on 7/12/16.
//  Copyright © 2016 Nilesh. All rights reserved.
//

#import "Model.h"

@implementation Model
static Model *instance = nil;

+(Model *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [Model new];
        }
    }
    return instance;
}

@end
