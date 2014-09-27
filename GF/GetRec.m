//
//  GetRec.m
//  GF
//
//  Created by Linda Pei on 9/26/14.
//  Copyright (c) 2014 Linda Pei. All rights reserved.
//

#import "GetRec.h"

@interface GetRec ()
@property (strong, nonatomic) NSArray *labels;
@property (strong, nonatomic) IBOutlet UIPickerView *labelPicker;
@property (strong, nonatomic) IBOutlet UILabel *labelText;
@property (strong, nonatomic) NSMutableArray *selectedLabels;
@end

@implementation GetRec
- (id)initWithLabelsDict:(NSDictionary *)labelsDict
{
    self = [super init];
    if (self) {
        self.labels = [labelsDict allKeys];
        self.selectedLabels = [[NSMutableArray init] alloc];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.labelPicker.dataSource = self;
    self.labelPicker.delegate = self;
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
}

- (IBAction)addLabelPressed:(id)sender {
    NSString *newLabel = [self.labels objectAtIndex:[self.labelPicker selectedRowInComponent:0]];
    [self.selectedLabels addObject: newLabel];
    self.labelText.text = [self.labelText.text stringByAppendingFormat:@", %@", newLabel];
}
- (IBAction)getFoodPressed:(id)sender {
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
