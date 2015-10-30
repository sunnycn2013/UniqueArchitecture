//
//  ViewController.m
//  UniqueArchitecture
//
//  Created by ccguo on 15/7/2.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "ViewController.h"
#import "UAProgressView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UAProgressView *progress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)reset:(id)sender {
    self.progress.progress = 0;
    
}
- (IBAction)add:(id)sender {
    self.progress.progress = 0.9;

}

@end
