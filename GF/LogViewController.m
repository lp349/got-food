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
@property (strong, nonatomic) NSMutableArray * currentFoods;
@property (strong, nonatomic) NSDictionary * history;

@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    self.currentFoods = [[NSMutableArray alloc] init];
}
- (void) dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)add:(id)sender {
    FoodItem *food = [[FoodItem alloc] initWithName:this.textName.text expDate:<#(NSDate *)#> andLabels:<#(NSMutableSet *)#>
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
