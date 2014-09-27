//
//  RecItem.h
//  GF
//
//  Created by Linda Pei on 9/27/14.
//  Copyright (c) 2014 Linda Pei. All rights reserved.
//
#import "FoodItem.h"
#import <Foundation/Foundation.h>

@interface RecItem : NSObject
@property (strong, nonatomic) FoodItem *food;
@property (assign, nonatomic) double weight;
- (id) initWithFood:(FoodItem *) food andWeight:(double) weight;
@end
