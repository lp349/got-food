//
//  FoodItem.h
//  GF
//
//  Created by Linda Pei on 9/26/14.
//  Copyright (c) 2014 Linda Pei. All rights reserved.
//

#ifndef GF_FoodItem_h
#define GF_FoodItem_h


#endif
#import <Foundation/Foundation.h> 

@interface FoodItem : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDate *expDate;
@property (strong, nonatomic) NSMutableArray *labels;

@end