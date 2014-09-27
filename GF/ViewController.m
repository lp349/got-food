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

@interface ViewController ()
@property (strong, nonatomic) NSDictionary *labels;
@property (nonatomic) int totalAccess;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.labels = [[NSDictionary alloc] init];
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
}

@end
