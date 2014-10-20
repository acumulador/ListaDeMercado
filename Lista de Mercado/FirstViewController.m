//
//  FirstViewController.m
//  Lista de Mercado
//
//  Created by Juan C Salazar on 15/10/14.
//  Copyright (c) 2014 Juan C Salazar. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    varAppDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    iniBD = [[Market alloc]init];
    [iniBD moveDataBaseAtLibrary];
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

- (IBAction)makeMarketListButton:(id)sender {
    varAppDelegate.swEditMarketList = YES;
}

- (IBAction)viewMarketListButton:(id)sender {
    varAppDelegate.swEditMarketList = NO;
}

- (IBAction)pruebaInsertButton:(id)sender {
    
    [iniBD loadMarketWithIdListMarket:varAppDelegate.idNewSuperMercado];
}
@end
