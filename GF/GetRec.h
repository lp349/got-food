//
//  GetRec.h
//  GF
//
//  Created by Linda Pei on 9/26/14.
//  Copyright (c) 2014 Linda Pei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetRec : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
- (id)initWithLabelsDict:(NSDictionary *)labelsDict currentFoods:(NSMutableArray *)currentFoods andHistory:(NSDictionary *)history;

@end
