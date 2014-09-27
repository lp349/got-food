//
//  FoodItem.m
//  GF
//
//  Created by Linda Pei on 9/26/14.
//  Copyright (c) 2014 Linda Pei. All rights reserved.
//

#import "FoodItem.h"
@interface FoodItem ()

@end
@implementation FoodItem
- (id)initWithName:(NSString *)name expDate:(NSDate *)expDate andLabels:(NSSet *)labels {
    self = [super init];
    if (self) {
        self.name = name;
        self.expDate = expDate;
        self.labels = labels;
    }
    return self;
}
@end