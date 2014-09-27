//
//  LogViewController.m
//  GF
//
//  Created by Amy Chen on 9/26/14.
//  Copyright (c) 2014 Linda Pei. All rights reserved.
//

#import "LogViewController.h"
#import "FoodItem.h"

@interface LogViewController ()
@property (strong, nonatomic) IBOutlet UITextField *textName;
@property (strong, nonatomic) IBOutlet UIDatePicker *pickerDate;
@property (strong, nonatomic) IBOutlet UITextField *textfeature;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerFeature;
//@property (strong, nonatomic) NSMutableArray *currentFoods;
//@property (strong, nonatomic) NSMutableDictionary *history;

@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    self.currentFoods = [[NSMutableArray alloc] init];
    self.history = [[NSMutableDictionary alloc] init];

}
- (void) dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)add:(id)sender {
    NSMutableSet *labels = [[NSMutableSet alloc] init];
    if (self.textfeature.text){
        [labels addObject: self.textfeature.text];
    }else{
        [labels addObject:  [[self.history allKeys] objectAtIndex:[self.pickerFeature selectedRowInComponent:0]]];
    }
    
    FoodItem *food = [[FoodItem alloc] initWithName:self.textName.text expDate:self.pickerDate.date andLabels:labels];
    [self.currentFoods addObject:food];
    
//    NSArray *numAccess = [[NSArray alloc] initWithObjects: 1, nil ];
  //  NSArray *vect2D = [[NSArray alloc] initWithObjects:  ];
  //  [self.history setObject:vect2D forKey:self.textName.text];
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
