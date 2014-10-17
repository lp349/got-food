//
//  ViewController.m
//  GF
//
//  Created by Linda Pei on 9/26/14.
//  Copyright (c) 2014 Linda Pei. All rights reserved.
//

#import "ViewController.h"
#import "LogViewController.h"
#import "GetRec.h"
#import "AllFoodList.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()
@property (strong, nonatomic) NSDictionary *labels;
@property (nonatomic) int totalAccess;
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.labels = [[NSDictionary alloc] init];
    NSMutableArray *labels = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"labels"]mutableCopy];
    NSLog(@"labels %@",[[NSUserDefaults standardUserDefaults] arrayForKey:@"labels"]);
    NSLog(@"currentfood %@",[[NSUserDefaults standardUserDefaults] arrayForKey:@"currentFoodNames"]);
    
    //[NSUserDefaults resetStandardUserDefaults];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    if (labels == nil) {
    
        NSDictionary *historyLabels = [[NSDictionary alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:historyLabels forKey:@"historyLabels"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
        NSDictionary *historyAccess = [[NSDictionary alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:historyAccess forKey:@"historyAccess"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
    
        labels = [[NSMutableArray alloc] init];
        [labels addObject: @"Breakfast"];
        [labels addObject: @"Lunch"];
        [labels addObject: @"Dinner"];
        [[NSUserDefaults standardUserDefaults] setObject:labels forKey:@"labels"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"labels local %@",labels);

        NSLog(@"labels default %@",[[NSUserDefaults standardUserDefaults] arrayForKey:@"labels"]);

        
        NSMutableArray *currentFoodNames = [[NSMutableArray alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:currentFoodNames forKey:@"currentFoodNames"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSMutableArray *currentFoodLabels = [[NSMutableArray alloc] init];
    [[NSUserDefaults standardUserDefaults] setObject:currentFoodLabels forKey:@"currentFoodLabels"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSMutableArray *currentExpDates = [[NSMutableArray alloc] init];
    [[NSUserDefaults standardUserDefaults] setObject:currentExpDates forKey:@"currentExpDates"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    }
    
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logFood:(id)sender {
    LogViewController *logVC = [[LogViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:logVC];
    [self presentViewController:navController animated:YES completion:^{
        NSLog(@"The navigation controller has been presented");
    }];
    
}

- (IBAction)recFood:(id)sender {
    GetRec *getRecVC = [[GetRec alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:getRecVC];
    [self presentViewController:navController animated:YES completion:^{
        NSLog(@"The navigation controller has been presented");
    }];
}

- (IBAction)allFood:(id)sender {
    AllFoodList *allList = [[AllFoodList alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:allList];
    [self presentViewController:navController animated:YES completion:^{
        NSLog(@"The navigation controller has been presented");
    }];
}
- (IBAction)videoButton:(id)sender {
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"fox2" ofType:@"mov"]];
    
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL: url];
    
    [self.view addSubview:self.moviePlayer.view];
    [self.moviePlayer setFullscreen:YES animated:NO];
    self.moviePlayer.shouldAutoplay = YES;
    
}

@end
