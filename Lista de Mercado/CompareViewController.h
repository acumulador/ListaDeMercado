//
//  CompareViewController.h
//  Lista de Mercado
//
//  Created by Juan C Salazar on 20/10/14.
//  Copyright (c) 2014 Juan C Salazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Market.h"
#import "repoMarketProduct.h"
#import "AppDelegate.h"

@interface CompareViewController : UIViewController
{
    Market * compareProduct;
    AppDelegate * varAppDelegate;
}

@property (strong, nonatomic) IBOutlet UILabel *titleProductLabel;

@property (strong, nonatomic) IBOutlet UILabel *marketName1Label;
@property (strong, nonatomic) IBOutlet UILabel *valueTotal1Label;
@property (strong, nonatomic) IBOutlet UILabel *marketDate1Label;

@property (strong, nonatomic) IBOutlet UILabel *marketName2Label;
@property (strong, nonatomic) IBOutlet UILabel *valueTotal2Label;
@property (strong, nonatomic) IBOutlet UILabel *marketDate2Label;

@property (strong, nonatomic) IBOutlet UILabel *marketName3Label;
@property (strong, nonatomic) IBOutlet UILabel *valueTotal3Label;
@property (strong, nonatomic) IBOutlet UILabel *marketDate3Label;

@property (strong, nonatomic) IBOutlet UILabel *marketName4Label;
@property (strong, nonatomic) IBOutlet UILabel *valueTotal4Label;
@property (strong, nonatomic) IBOutlet UILabel *marketDate4Label;

@end
