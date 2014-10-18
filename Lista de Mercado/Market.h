//
//  Market.h
//  Lista de Mercado
//
//  Created by Juan C Salazar on 12/10/14.
//  Copyright (c) 2014 Juan C Salazar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "repoMarketProduct.h"

@interface Market : NSObject
{
    sqlite3 * conexDB;
    repoMarketProduct * repoProducts;
}

@property NSMutableArray * arrayNameSuperMarketList;
@property NSMutableArray * arrayFechaSuperMarketList;
@property NSMutableArray * arrayProductsOfCategory;

@property NSMutableArray * arrayDsCategory;
@property NSMutableArray * arrayProduct;
@property NSMutableArray * arrayValProduct;
@property NSMutableArray * arrayCantProduct;
@property NSMutableArray * arraySubTotal;

@property NSString * totalValuesMarket;

@property NSString * status;
@property int idMarketSelected;

//Sobre la conexion
//--------------------------------------------
-(void) searchPathOfDatabase;
-(void) moveDataBaseAtLibrary;
//--------------------------------------------

-(void) loadCategorys;
//Carga productos por categoria seleccionada
-(void) loadProductsOfCategory:(int) idCategory;
//Cargar la lista de mercado de la ultima lista
-(void) loadMarketWithIdListMarket:(int) idListMarket;
//Cargar listas de mercado
//-(void) loadListMarket;

//Agrega producto seleccionada a la lista actual
-(void) addProductAtMarketWhithIdMarket:(int)idMarketVar AndIdProduct:(int)idProductVar AndDsProduct:(NSString *)dsProductVar AndCantProduct:(int)cantProductVar AndValUnitProduct:(int)valUnitProductVar AndSubTotal:(int)subTotalVar;
-(void) delProductAtMarket:(NSString *) idProduct;
-(void) updateProductAtMarket:(NSString *) idProduct;
-(void) compareProducts:(NSString *) idProduct;
//Crear lista de mercado
-(void) addListMarket:(NSString *) market;

//Sumar los valores de una lista de mercado
-(void) sumValuesMarketList:(int) idListMarket;
//Consulto la cantidad de listas que existen
-(void) searchListMarket;

@end
