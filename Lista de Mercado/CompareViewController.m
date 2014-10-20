//
//  CompareViewController.m
//  Lista de Mercado
//
//  Created by Juan C Salazar on 20/10/14.
//  Copyright (c) 2014 Juan C Salazar. All rights reserved.
//

#import "CompareViewController.h"

@interface CompareViewController ()

@end

@implementation CompareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    varAppDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    compareProduct = [[Market alloc]init];
    [compareProduct compareProducts: [varAppDelegate.idProductcompare intValue]];
    
    _marketName1Label.text = [(repoMarketProduct *)[compareProduct.arrayCompareProducts objectAtIndex:0] nameMarketList];
    _marketName2Label.text = [(repoMarketProduct *)[compareProduct.arrayCompareProducts objectAtIndex:1] nameMarketList];
    _marketName3Label.text = [(repoMarketProduct *)[compareProduct.arrayCompareProducts objectAtIndex:2] nameMarketList];
    _marketName4Label.text = [(repoMarketProduct *)[compareProduct.arrayCompareProducts objectAtIndex:3] nameMarketList];
    
    _marketDate1Label.text = [(repoMarketProduct *)[compareProduct.arrayCompareProducts objectAtIndex:0] dateMarketList];
    _marketDate2Label.text = [(repoMarketProduct *)[compareProduct.arrayCompareProducts objectAtIndex:1] dateMarketList];
    _marketDate3Label.text = [(repoMarketProduct *)[compareProduct.arrayCompareProducts objectAtIndex:2] dateMarketList];
    _marketDate4Label.text = [(repoMarketProduct *)[compareProduct.arrayCompareProducts objectAtIndex:3] dateMarketList];
    
    _valueTotal1Label.text = [(repoMarketProduct *)[compareProduct.arrayCompareProducts objectAtIndex:0] valUnitProduct];
    _valueTotal2Label.text = [(repoMarketProduct *)[compareProduct.arrayCompareProducts objectAtIndex:1] valUnitProduct];
    _valueTotal3Label.text = [(repoMarketProduct *)[compareProduct.arrayCompareProducts objectAtIndex:2] valUnitProduct];
    _valueTotal4Label.text = [(repoMarketProduct *)[compareProduct.arrayCompareProducts objectAtIndex:3] valUnitProduct];
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

@end
