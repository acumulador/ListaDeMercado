//
//  ViewController.h
//  Lista de Mercado
//
//  Created by Juan C Salazar on 10/10/14.
//  Copyright (c) 2014 Juan C Salazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Market.h"

@interface ViewController : UIViewController<UIAlertViewDelegate>
{
    Market * addMarquet;
    UIAlertView * message;
}

@property (strong, nonatomic) IBOutlet UITextField *nameSuperMarketText;
- (IBAction)createMarketListButton:(id)sender;


@end

