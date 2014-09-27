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
@property (strong, nonatomic) NSMutableSet *featuresCurr;
//@property (strong, nonatomic) NSMutableArray *currentFoods;
//@property (strong, nonatomic) NSMutableDictionary *history;
@property (strong, nonatomic) IBOutlet UILabel *textFeatureDisplay;

@end

@implementation LogViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    self.currentFoods = [[NSMutableArray alloc] init];
    self.history = [[NSMutableDictionary alloc] init];
    
    [self.history setObject:[[FoodProfile alloc] init] forKey: @"Breakfast"];
    [self.history setObject:[[FoodProfile alloc] init] forKey: @"Lunch"];
    [self.history setObject:[[FoodProfile alloc] init] forKey: @"Dinner"];

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
    return [[self.history allKeys] count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self.history allKeys] objectAtIndex:row];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)add:(id)sender {
    NSMutableSet *labels = [[NSMutableSet alloc] init];
    if (self.textFeature.text){
        [labels addObject: self.textFeature.text];
        NSLog(@"Labels are now %@", labels);
    }else{
        [labels addObject:  [[self.history allKeys] objectAtIndex:[self.pickerFeature selectedRowInComponent:0]]];
    }
    
    FoodItem *food = [[FoodItem alloc] initWithName:self.textName.text expDate:self.pickerDate.date andLabels:labels];
    [self.currentFoods addObject:food];
    FoodProfile *foodProf = [[FoodProfile alloc] initWithName:food.name numAccess:1 andLabels:labels];
    [self.history setObject:foodProf forKey:foodProf.name];
    
}
- (IBAction)addFeature:(id)sender {
    self.featuresCurr = [[NSMutableSet alloc] init];
    //self.textFeatureDisplay.text = @"";
    if (self.textFeature.text){
        [self.featuresCurr addObject: self.textFeature.text];
        self.textFeatureDisplay.text = [self.textFeatureDisplay.text stringByAppendingFormat:@" %@", self.textFeature.text];
        NSLog(@"Labels are now %@", self.featuresCurr);
    }else{
        
        [self.featuresCurr addObject:  [[self.history allKeys] objectAtIndex:[self.pickerFeature selectedRowInComponent:0]]];
        //self.textFeatureDisplay.text = [self.textFeatureDisplay.text stringByAppendingFormat:@" %@", self.textFeature.text];
        NSLog(@"Labels are now %@", self.featuresCurr);
        
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
