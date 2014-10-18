//
//  ProductsTableViewController.h
//  Lista de Mercado
//
//  Created by Jhon Wilfer Orrego on 12/10/14.
//  Copyright (c) 2014 Juan C Salazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListMarketTableViewController.h"
#import "Market.h"
#import "repoMarketProduct.h"
#import "AppDelegate.h"

@interface ProductsTableViewController : UITableViewController<UIAlertViewDelegate>
{
    AppDelegate * varAppDelegate;
    
    Market * productsOfCategory;
    UIAlertView * messageCantProduct;
}

@property NSString * dataTransferIdCategory;
@property int dataTransferIdMarket;

@end
