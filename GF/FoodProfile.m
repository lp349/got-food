//
//  FoodProfile.m
//  GF
//
//  Created by Amy Chen on 9/27/14.
//  Copyright (c) 2014 Linda Pei. All rights reserved.
//

#import "FoodProfile.h"
@interface FoodProfile ()
@end

@implementation FoodProfile
- (id)initWithName: (NSString *)name numAccess: (int) numAccess andLabels:(NSMutableSet *)labels{
    self = [super init];
    if(self){
        self.name = name;
        self.numAccess = numAccess;
        self.labels = labels;
    }
    return self;
}
@end

