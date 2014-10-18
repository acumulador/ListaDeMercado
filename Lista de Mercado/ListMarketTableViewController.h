//
//  ListMarketTableViewController.h
//  Lista de Mercado
//
//  Created by Jhon Wilfer Orrego on 12/10/14.
//  Copyright (c) 2014 Juan C Salazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Market.h"
#import "SWTableViewCell.h"
#import "UMTableViewCell.h"

@interface ListMarketTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate>
{
    Market * listMarket;
}

@property int dataTransferIdList;

@property (strong, nonatomic) IBOutlet UILabel *totalMarketLabel;
@property (strong, nonatomic) IBOutlet UILabel *productDsLabel;
@property (strong, nonatomic) IBOutlet UILabel *cantProductoLabel;
@property (strong, nonatomic) IBOutlet UILabel *subTotalProductLabel;
- (IBAction)addProductButton:(id)sender;


@end
