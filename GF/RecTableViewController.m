//
//  RecTableViewController.m
//  GF
//
//  Created by Linda Pei on 9/27/14.
//  Copyright (c) 2014 Linda Pei. All rights reserved.
//

#import "RecTableViewController.h"
#import "FinishTableViewController.h"
#import "FoodItem.h"
#import "RecItem.h"
#import "FoodProfile.h"

@interface RecTableViewController ()
@property(strong, nonatomic) NSArray *foodRecs;
@property(strong, nonatomic) NSMutableArray *foodSelected;

@end

@implementation RecTableViewController

- (id)initWithStyle:(UITableViewStyle)style andRec:(NSArray *)foodRecs {
    self = [super initWithStyle:style];
    if (self){
        self.foodRecs = foodRecs;
        self.foodSelected = [[NSMutableArray alloc] init];
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
    self.title = @"Recommendations";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStylePlain target:self action:@selector(done)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)done {
    NSLog(@"%@", self.foodSelected);
    FinishTableViewController *finishView = [[FinishTableViewController alloc] initWithStyle:UITableViewStylePlain andFoods:self.foodSelected];
    [self.navigationController pushViewController:finishView animated:YES];
    NSMutableDictionary *historyAccess = [[[NSUserDefaults standardUserDefaults] objectForKey:@"historyAccess"] mutableCopy];
    for (FoodItem *food in self.foodSelected){
        NSNumber *numAccess = [historyAccess objectForKey:food.name];
        numAccess = [[NSNumber alloc] initWithInt:[numAccess intValue] + 1];
        [historyAccess setObject:numAccess forKey:food.name];
    }
    [[NSUserDefaults standardUserDefaults] setObject:historyAccess forKey:@"historyAccess"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.foodRecs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    RecItem *rec = [self.foodRecs objectAtIndex:indexPath.row];
    cell.textLabel.text = rec.food.name;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:22];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd"];
    NSString *stringFromDate = [formatter stringFromDate:rec.food.expDate];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Expiration Date: %@", stringFromDate];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:15];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSUInteger unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:[NSDate date]
                                                  toDate:rec.food.expDate options:0];
    
    NSInteger months = [components month];
    NSInteger days = [components day];
    if (months == 0 && days < 4) {
        NSLog(@"Months: %d Days: %d", (int)months, (int)days);
        cell.backgroundColor = [UIColor redColor];
    }
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];*/
    RecItem *rec =[self.foodRecs objectAtIndex:indexPath.row];
    [self.foodSelected addObject:rec.food];
    UITableViewCell *tableViewCell = [tableView cellForRowAtIndexPath:indexPath];
    tableViewCell.accessoryView.hidden = NO;
    tableViewCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.navigationItem.rightBarButtonItem.title = [NSString stringWithFormat:@"Done (%d)", (int)[self.foodSelected count]];
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    RecItem *rec =[self.foodRecs objectAtIndex:indexPath.row];
    [self.foodSelected removeObject:rec.food];
    UITableViewCell *tableViewCell = [tableView cellForRowAtIndexPath:indexPath];
    tableViewCell.accessoryView.hidden = YES;
    tableViewCell.accessoryType = UITableViewCellAccessoryNone;
    self.navigationItem.rightBarButtonItem.title = [NSString stringWithFormat:@"Done (%d)", (int)[self.foodSelected count]];
    
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
