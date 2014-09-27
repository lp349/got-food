//
//  RecItem.m
//  GF
//
//  Created by Linda Pei on 9/27/14.
//  Copyright (c) 2014 Linda Pei. All rights reserved.
//

#import "RecItem.h"

@implementation RecItem
- (id) initWithFood:(FoodItem *) food andWeight:(double) weight {
    self = [super init];
    if (self) {
        self.food = food;
        self.weight = weight;
    }
    return self;
}
@end
