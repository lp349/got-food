//
//  AllFoodList.m
//  GF
//
//  Created by Amy Chen on 9/27/14.
//  Copyright (c) 2014 Linda Pei. All rights reserved.
//

#import "AllFoodList.h"
#import "FoodItem.h"
#import "FoodProfile.h"

@interface AllFoodList ()
@property (strong,nonatomic) NSArray *currentFoodNames;
@property (strong,nonatomic) NSArray *currentExpDates;
@property (strong,nonatomic) NSArray *currentFoodLabels;

@property (strong, nonatomic) NSMutableArray *selectedFoodNames;

@end

@implementation AllFoodList


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsMultipleSelection = YES;
    
    self.title = @"All Food";
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStylePlain target:self action:@selector(delete)];

    self.currentFoodNames = [[NSUserDefaults standardUserDefaults] arrayForKey:@"currentFoodNames"];
    self.currentExpDates = [[NSUserDefaults standardUserDefaults] arrayForKey:@"currentExpDates"];
    self.currentFoodLabels = [[NSUserDefaults standardUserDefaults] arrayForKey:@"currentFoodLabels"];
    self.selectedFoodNames = [[NSMutableArray alloc] init];

    
}

- (void) delete{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([self.selectedFoodNames count] > 0) {
        NSLog(@"Before Food Names: %@", self.currentFoodNames);
        NSMutableArray *currentFoodNames = [[defaults arrayForKey:@"currentFoodNames"] mutableCopy];
        NSMutableArray *currentExpDates = [[defaults arrayForKey:@"currentExpDates"] mutableCopy];
        NSMutableArray *currentFoodLabels = [[defaults arrayForKey:@"currentFoodLabels"] mutableCopy];
        for (int i = 0; i < [currentFoodNames count]; i++){
            NSString *foodName = [currentFoodNames objectAtIndex:i];
            for (NSString *selectedFoodName in self.selectedFoodNames) {
                if ([foodName isEqualToString:selectedFoodName]) {
                    [currentFoodNames removeObjectAtIndex:i];
                    [currentExpDates removeObjectAtIndex:i];
                    [currentFoodLabels removeObjectAtIndex:i];
                    break;
                }
            }
            
        }
        [defaults setObject:currentFoodNames forKey:@"currentFoodNames"];
        [defaults setObject:currentExpDates forKey:@"currentExpDates"];
        [defaults setObject:currentFoodLabels forKey:@"currentFoodLabels"];
        [defaults synchronize];
        
        self.currentFoodNames = [[NSUserDefaults standardUserDefaults] arrayForKey:@"currentFoodNames"];
        self.currentExpDates = [[NSUserDefaults standardUserDefaults] arrayForKey:@"currentExpDates"];
        self.currentFoodLabels = [[NSUserDefaults standardUserDefaults] arrayForKey:@"currentFoodLabels"];
        NSLog(@"After Food Names: %@", self.currentFoodNames);
        for (int row = 0, rowCount = (int)[self.tableView numberOfRowsInSection:0]; row < rowCount; ++row) {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.accessoryView.hidden = YES;
        }
        [self.tableView reloadData];
    }
}

- (void) dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
   
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.currentFoodNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    // Configure the cell...
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: @"cell"];
    }
    
    
    cell.textLabel.text = [self.currentFoodNames objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:22];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd"];
    NSString *stringFromDate = [formatter stringFromDate:[self.currentExpDates objectAtIndex:indexPath.row]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Expiration Date: %@", stringFromDate];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:15];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSUInteger unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:[NSDate date]
                                                  toDate:[self.currentExpDates objectAtIndex:indexPath.row] options:0];
    
    NSInteger months = [components month];
    NSInteger days = [components day];
    if (months == 0 && days < 4) {
        NSLog(@"Months: %d Days: %d", (int)months, (int)days);
        cell.backgroundColor = [UIColor redColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
//    
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectedFoodNames addObject:[self.currentFoodNames objectAtIndex:indexPath.row]];
    UITableViewCell *tableViewCell = [tableView cellForRowAtIndexPath:indexPath];
    tableViewCell.accessoryView.hidden = NO;
    tableViewCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.navigationItem.rightBarButtonItem.title = [NSString stringWithFormat:@"Delete (%d)", (int)[self.selectedFoodNames count]];
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectedFoodNames removeObject:[self.currentFoodNames objectAtIndex:indexPath.row]];
    UITableViewCell *tableViewCell = [tableView cellForRowAtIndexPath:indexPath];
    tableViewCell.accessoryView.hidden = YES;
    tableViewCell.accessoryType = UITableViewCellAccessoryNone;
    self.navigationItem.rightBarButtonItem.title = [NSString stringWithFormat:@"Delete (%d)", (int)[self.selectedFoodNames count]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
