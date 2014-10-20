//
//  FirstViewController.h
//  Lista de Mercado
//
//  Created by Juan C Salazar on 15/10/14.
//  Copyright (c) 2014 Juan C Salazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Market.h"
#import "AppDelegate.h"

@interface FirstViewController : UIViewController
{
    Market * iniBD;
    AppDelegate * varAppDelegate;
}
- (IBAction)makeMarketListButton:(id)sender;
- (IBAction)viewMarketListButton:(id)sender;


- (IBAction)pruebaInsertButton:(id)sender;

@end
