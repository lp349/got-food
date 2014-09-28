//
//  FinishTableViewController.m
//  GF
//
//  Created by Linda Pei on 9/27/14.
//  Copyright (c) 2014 Linda Pei. All rights reserved.
//

#import "FinishTableViewController.h"
#import "FoodItem.h"

@interface FinishTableViewController ()
@property (strong, nonatomic) NSArray *foods;
@property (strong, nonatomic) NSMutableArray *selectedFoodNames;
@end

@implementation FinishTableViewController

- (id)initWithStyle:(UITableViewStyle)style andFoods:(NSArray *)foods {
    self = [super initWithStyle:style];
    if (self) {
        self.foods = foods;
        self.selectedFoodNames = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsMultipleSelection = YES;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"What did you finish?";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Finished"
                                                                              style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
}

- (void) dismiss{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([self.selectedFoodNames count] > 0) {
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
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.foods count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    FoodItem *food = [self.foods objectAtIndex:indexPath.row];
    cell.textLabel.text = food.name;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:22];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd"];
    NSString *stringFromDate = [formatter stringFromDate:food.expDate];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Expiration Date: %@", stringFromDate];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:15];
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FoodItem *food =[self.foods objectAtIndex:indexPath.row];
    [self.selectedFoodNames addObject:food.name];
    NSLog(@"Food selected: %@", self.selectedFoodNames);
    UITableViewCell *tableViewCell = [tableView cellForRowAtIndexPath:indexPath];
    tableViewCell.accessoryView.hidden = NO;
    tableViewCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.navigationItem.rightBarButtonItem.title = [NSString stringWithFormat:@"Finished (%d)", (int)[self.selectedFoodNames count]];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    FoodItem *food = [self.foods objectAtIndex:indexPath.row];
    [self.selectedFoodNames removeObject:food.name];
     NSLog(@"Food selected: %@", self.selectedFoodNames);
    UITableViewCell *tableViewCell = [tableView cellForRowAtIndexPath:indexPath];
    tableViewCell.accessoryView.hidden = YES;
    tableViewCell.accessoryType = UITableViewCellAccessoryNone;
        self.navigationItem.rightBarButtonItem.title = [NSString stringWithFormat:@"Finished (%d)", (int)[self.selectedFoodNames count]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
