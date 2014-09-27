//
//  LogViewController.m
//  GF
//
//  Created by Amy Chen on 9/26/14.
//  Copyright (c) 2014 Linda Pei. All rights reserved.
//

#import "LogViewController.h"
#import "FoodItem.h"
#import "FoodProfile.h"


@interface LogViewController ()

@property (strong, nonatomic) IBOutlet UITextField *textName;
@property (strong, nonatomic) IBOutlet UIDatePicker *pickerDate;
@property (strong, nonatomic) IBOutlet UITextField *textFeature;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerFeature;

@property (strong, nonatomic) NSMutableArray *featuresCurr;
@property (strong, nonatomic) NSMutableArray *currentFoodLabels;
@property (strong, nonatomic) NSMutableArray *currentExpDates;
@property (strong, nonatomic) NSMutableArray *currentFoodNames;


@property (strong, nonatomic) NSMutableDictionary *historyLabels;
@property (strong, nonatomic) NSMutableDictionary *historyAccess;

@property (strong, nonatomic) IBOutlet UILabel *textFeatureDisplay;
@property (strong, nonatomic) NSMutableArray *labels;

@end

@implementation LogViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    
    self.featuresCurr = [[NSMutableArray alloc] init];
    
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.historyLabels = [[defaults dictionaryForKey:@"historyLabels"] mutableCopy];
    self.historyAccess = [[defaults dictionaryForKey:@"historyAccess"] mutableCopy];
    
    
    self.currentFoodNames =[[defaults arrayForKey:@"currentFoodNames"] mutableCopy];
    self.currentExpDates =[[defaults arrayForKey:@"currentExpDates"] mutableCopy];
    self.currentFoodLabels =[[defaults arrayForKey:@"currentFoodLabels"] mutableCopy];
    
    self.labels =[[defaults arrayForKey:@"labels"] mutableCopy];
    

    NSLog(@"self labels %@", self.labels);

    self.pickerFeature.dataSource = self;
    self.pickerFeature.delegate = self;
    
}
- (void) dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)add:(id)sender {
/*    NSMutableSet *labels = [[NSMutableSet alloc] init];
    if (self.textFeature.text){
        [labels addObject: self.textFeature.text];
        NSLog(@"Labels are now %@", labels);
    }else{
        [labels addObject:  [[self.history allKeys] objectAtIndex:[self.pickerFeature selectedRowInComponent:0]]];
    }*/
 
    /*
     NSDictionary *historyLabels
     Key: FoodName
     Value: NSArray of Labels
     
     NSDictionary *historyAccess
     Key: FoodName
     Value: NSNumber of numAccess
     
     
     NSMutableArray * currentFoodNames
     Each element: NSString names
     
     NSMutableArray * currentExpDates
     Element: NSDate expDates
     
     NSMutableArray * currentFoodLabels
     Element: NSArray labels 
     */
    
    //FoodItem *food = [[FoodItem alloc] initWithName:self.textName.text expDate:self.pickerDate.date andLabels:self.featuresCurr];
    [self.currentFoodNames addObject:self.textName.text];
    [self.currentExpDates addObject:self.pickerDate.date];
    [self.currentFoodLabels addObject:self.featuresCurr];
    
    //FoodProfile *foodProf = [[FoodProfile alloc] initWithName:food.name numAccess:1 andLabels:self.featuresCurr];
    [self.historyLabels setObject:self.featuresCurr forKey:self.textName.text];
    [self.historyAccess setObject:[[NSNumber alloc] initWithInt: 1] forKey:self.textName.text];

    NSLog(@"historyLabels before store %@", self.historyLabels);
    NSLog(@"historyAccess before store %@", self.historyAccess);

    NSLog(@"labels before store %@", self.labels);
    
    NSLog(@"currentFoodNames before store %@", self.currentFoodNames);
    NSLog(@"currentExpDates before store %@", self.currentExpDates);
    NSLog(@"currentFoodLabels before store %@", self.currentFoodLabels);
    
    [[NSUserDefaults standardUserDefaults] setObject:self.labels forKey:@"labels"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.currentFoodNames forKey:@"currentFoodNames"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:self.currentExpDates forKey:@"currentExpDates"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:self.currentFoodLabels forKey:@"currentFoodLabels"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.historyLabels forKey:@"historyLabels"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:self.historyAccess forKey:@"historyAccess"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"historyLabels after store %@", [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"historyLabels"]);
    NSLog(@"historyAccess after store %@", [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"historyAccess"]);
    
    
    //NSLog(@"history before store %@", self.history);
    //NSLog(@"labels before store %@", self.labels);
    //NSLog(@"currentFoods before store %@", self.currentFoods);
    
}
- (IBAction)addFeature:(id)sender {
    if (![self.textFeature.text  isEqual: @""]){
        [self.featuresCurr addObject: self.textFeature.text];
        [self.labels addObject: self.textFeature.text];
        self.textFeatureDisplay.text = [self.textFeatureDisplay.text stringByAppendingFormat:@" %@", self.textFeature.text];
        NSLog(@"Features are now %@", self.featuresCurr);
    }else{
        [self.featuresCurr addObject:[self.labels objectAtIndex:[self.pickerFeature selectedRowInComponent:0]]];
        NSLog(@"picker %@", self.featuresCurr);
        NSLog(@"Features are now %@", [self.labels objectAtIndex:[self.pickerFeature selectedRowInComponent:0]]);
        self.textFeatureDisplay.text = [self.textFeatureDisplay.text stringByAppendingFormat:@" %@", [self.labels objectAtIndex:[self.pickerFeature selectedRowInComponent:0]]];
        NSLog(@"Features are now %@", self.featuresCurr);
    }
    self.textFeature.text = @"";
    //self.textFeatureDisplay.text = [NSString stringWithFormat:@"%@", self.featuresCurr];
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
