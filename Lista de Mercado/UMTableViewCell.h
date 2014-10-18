//
//  UMTableViewCell.h
//  Lista de Mercado
//
//  Created by Juan C Salazar on 14/10/14.
//  Copyright (c) 2014 Juan C Salazar. All rights reserved.
//

#import "SWTableViewCell.h"

@interface UMTableViewCell : SWTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dsProductLabel;
@property (strong, nonatomic) IBOutlet UILabel *cantProductLabel;
@property (strong, nonatomic) IBOutlet UILabel *subtotalProductLabel;

@end
