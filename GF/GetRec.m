//
//  GetRec.m
//  GF
//
//  Created by Linda Pei on 9/26/14.
//  Copyright (c) 2014 Linda Pei. All rights reserved.
//

#import "GetRec.h"
#import "FoodItem.h"
#import "RecItem.h"
#import "FoodProfile.h"
#import "RecTableViewController.h"

@interface GetRec ()
@property (strong, nonatomic) NSArray *labels;
@property (strong, nonatomic) IBOutlet UIPickerView *labelPicker;
@property (strong, nonatomic) IBOutlet UILabel *labelText;
@property (strong, nonatomic) NSMutableSet *selectedLabels;
@property (strong, nonatomic) NSMutableArray *currentFoods;
@property (strong, nonatomic) NSDictionary *historyAccess;
@end

@implementation GetRec
- (id)init
{
    self = [super init];
    if (self) {
        self.labels = [[NSUserDefaults standardUserDefaults] arrayForKey:@"labels"];
        //self.labels = @[@"Breakfast", @"Snacks", @"Using default dic"];
        self.selectedLabels = [[NSMutableSet alloc] init];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.currentFoods = [[NSMutableArray alloc] init];
        NSArray *currentFoodNames = [defaults arrayForKey:@"currentFoodNames"];
        NSArray *currentExpDates = [defaults arrayForKey:@"currentExpDates"];
        NSArray *currentFoodLabels = [defaults arrayForKey:@"currentFoodLabels"];
        for (int i = 0; i < [currentFoodNames count]; i++){
            FoodItem *food = [[FoodItem alloc] initWithName:[currentFoodNames objectAtIndex:i] expDate:[currentExpDates objectAtIndex:i] andLabels:[currentFoodLabels objectAtIndex:i]];
            [self.currentFoods addObject:food];
        }
        self.historyAccess = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"historyAccess"];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.labelPicker.dataSource = self;
    self.labelPicker.delegate = self;
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    NSLog(@"currentfood %@",[[NSUserDefaults standardUserDefaults] arrayForKey:@"currentFoodNames"]);

}
- (void) dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *) pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.labels count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.labels objectAtIndex:row];
}
- (IBAction)randomPressed:(id)sender {
    if ([self.currentFoods count] != 0) {
        int randomNumber = arc4random() %([self.currentFoods count]);
        FoodItem *randomFood = [self.currentFoods objectAtIndex:randomNumber];
        // Call next view
        RecItem *rec = [[RecItem alloc] initWithFood:randomFood andWeight:1.0];
        RecTableViewController *recTable = [[RecTableViewController alloc] initWithStyle:UITableViewStylePlain andRec:@[rec]];
        [self.navigationController pushViewController:recTable animated:YES];
    }
    
}

- (IBAction)addLabelPressed:(id)sender {
    NSString *newLabel = [self.labels objectAtIndex:[self.labelPicker selectedRowInComponent:0]];
    if ([self.selectedLabels count] == 0) {
        [self.selectedLabels addObject:newLabel];
        self.labelText.text = newLabel;
        NSLog(@"Label Text: %@", newLabel);
    }
    else {
        if (![self.selectedLabels containsObject:newLabel]) {
            [self.selectedLabels addObject:newLabel];
            self.labelText.text = [self.labelText.text stringByAppendingFormat:@", %@", newLabel];
    }}
    NSLog(@"%@", self.selectedLabels);
}
- (IBAction)getFoodPressed:(id)sender {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.currentFoods count]; i++) {
        FoodItem *food = [self.currentFoods objectAtIndex:i];
        double weight = 0.0;
        int matchingLabels = 0;
        for (NSString *label in food.labels) {
            if ([self.selectedLabels containsObject:label])
                matchingLabels++;
        }
        if (!matchingLabels) {
            continue;
        }
        // Weigh by matching labels
        weight += matchingLabels;
        if (food.expDate) {
            NSCalendar *gregorian = [[NSCalendar alloc]
                                     initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            
            NSUInteger unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay;
            
            NSDateComponents *components = [gregorian components:unitFlags
                                                        fromDate:[NSDate date]
                                                          toDate:food.expDate options:0];
            
            NSInteger months = [components month];
            NSInteger days = [components day];
            if (months > 0 || days > 14) {
                days = 14;
                NSLog(@"Not going to expire");
            } else {
                if (months < 0 || days < 0) {
                    days = 14;
                    NSLog(@"Already expired");
                } else {
                    NSLog(@"About to expire");
                }
            }
            // Weigh by days until expiration
            weight += (14-days)/4;
        }
        // Weigh by how commonly this food was eaten
        NSNumber *numAccess = [self.historyAccess objectForKey:food.name];
        weight += [numAccess doubleValue];
        [result addObject:[[RecItem alloc] initWithFood:food andWeight:weight]];
        
        
    }
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"weight"
                                                                   ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [result sortedArrayUsingDescriptors:sortDescriptors];
    
    NSLog(@"%@", sortedArray);
    
    RecTableViewController *recTable = [[RecTableViewController alloc] initWithStyle:UITableViewStylePlain andRec:sortedArray];
    [self.navigationController pushViewController:recTable animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
