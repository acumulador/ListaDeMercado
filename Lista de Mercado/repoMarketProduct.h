//
//  repoMarketProduct.h
//  Lista de Mercado
//
//  Created by Juan C Salazar on 18/10/14.
//  Copyright (c) 2014 Juan C Salazar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface repoMarketProduct : NSObject

@property NSString * idMercado;
@property NSString * idProduct;
@property NSString * dsProduct;
@property NSString * cantProduct;
@property NSString * valUnitProduct;
@property NSString * subTotal;

@property NSString * idMarketList;
@property NSString * nameMarketList;
@property NSString * dateMarketList;

@property int idMarketSelected;

@end
