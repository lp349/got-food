//
//  FoodProfile.h
//  GF
//
//  Created by Amy Chen on 9/27/14.
//  Copyright (c) 2014 Linda Pei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodProfile : NSObject
@property (strong, nonatomic) NSString *name;
@property (nonatomic) int numAccess;
@property (strong, nonatomic) NSMutableSet *labels;

- (id)initWithName: (NSString *)name numAccess: (int) numAccess andLabels:(NSMutableSet *)labels; 

@end



