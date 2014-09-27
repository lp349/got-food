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

@end

@implementation AllFoodList


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"All Food";
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];

    self.currentFoodNames = [[NSUserDefaults standardUserDefaults] arrayForKey:@"currentFoodNames"];
    self.currentExpDates = [[NSUserDefaults standardUserDefaults] arrayForKey:@"currentExpDates"];
    self.currentFoodLabels = [[NSUserDefaults standardUserDefaults] arrayForKey:@"currentFoodLabels"];
    NSLog(@"%@", self.currentFoodNames);

    
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
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMDDDD"];
    NSString *stringFromDate = [formatter stringFromDate:[self.currentExpDates objectAtIndex:indexPath.row]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Expiration Date:%@", stringFromDate];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSUInteger unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:[self.currentExpDates objectAtIndex:indexPath.row]
                                                  toDate:[NSDate date] options:0];
    
    NSInteger months = [components month];
    NSInteger days = [components day];
    if (months == 0 && days < 4) {
        cell.backgroundColor = [UIColor redColor];
    }
    
    
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

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
