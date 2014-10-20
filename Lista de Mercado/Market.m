//
//  Market.m
//  Lista de Mercado
//
//  Created by Juan C Salazar on 12/10/14.
//  Copyright (c) 2014 Juan C Salazar. All rights reserved.
//

#import "Market.h"

@interface Market()
@property NSString * dataBasePath;
@end

@implementation Market

const char * dbPath;

-(void)moveDataBaseAtLibrary
{
    BOOL goodDB;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError * error;
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    NSString * libraryDirectory = [paths objectAtIndex:0];
    
    NSString * writableDBPath = [libraryDirectory stringByAppendingPathComponent:@"MarketList.db"];
    
    goodDB = [fileManager fileExistsAtPath:writableDBPath];
    
    if (goodDB) return;
    
    // Si no existe en Library, la copio desde el original.
    NSString * defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"MarketList.db"];
    
    goodDB = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    
    if (!goodDB) {
        NSAssert1(0, @"Error al cargar la base de datos, error = '%@'.", [error localizedDescription]);
    }
    else{
        NSLog(@"La base de datos se movio correctamente!!");
    }
}

-(void)searchPathOfDatabase
{
    //NSString * rutaFolderDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0 ];
    NSString * rutaFolderDoc = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSLog(@"Ruta BD %@",rutaFolderDoc);
    _dataBasePath = [rutaFolderDoc stringByAppendingPathComponent:@"MarketList.db"];
    dbPath = [_dataBasePath UTF8String];
}

-(void)sumValuesMarketList:(int)idListMarket
{
    [self searchPathOfDatabase];
    sqlite3_stmt * querySearch;
    NSString * stringSearch;
    
    _totalValuesMarket = [[NSString alloc]init];
    
    stringSearch = [NSString stringWithFormat:@"select sum(subtotal) as total_mercado from tbl_mercado where id_mercado = %i", idListMarket];
    
    if (sqlite3_open(dbPath, &conexDB)==SQLITE_OK) {
        const char * searchSql = [stringSearch UTF8String];
        if (sqlite3_prepare_v2(conexDB, searchSql, -1, &querySearch, NULL)==SQLITE_OK) {
            if (sqlite3_step(querySearch)==SQLITE_ROW) {
                _totalValuesMarket = [NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 0)];
            }else{
                NSLog(@"Error en la consulta!!");
            }
        }
        
        sqlite3_finalize(querySearch);
        sqlite3_close(conexDB);
        
    }else{
        NSLog(@"Error abriendo la base de datos!!");
    }
}

//Obtengo la ultim lista de mercado
-(void)takeVarIdMercado
{
    varAppDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [self searchPathOfDatabase];
    sqlite3_stmt * querySearch;
    NSString * stringSearch;
    
    stringSearch = [NSString stringWithFormat:@"SELECT MAX(id_listamercado) FROM tbl_listamercado"];
    
    if (sqlite3_open(dbPath, &conexDB)==SQLITE_OK) {
        const char * searchSql = [stringSearch UTF8String];
        if (sqlite3_prepare_v2(conexDB, searchSql, -1, &querySearch, NULL)==SQLITE_OK) {
            if (sqlite3_step(querySearch)==SQLITE_ROW) {
                varAppDelegate.idNewSuperMercado = [[NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 0)]intValue]+1;
            }else{
                NSLog(@"Error en la consulta!!");
            }
        }
        
        sqlite3_finalize(querySearch);
        sqlite3_close(conexDB);
        
    }else{
        NSLog(@"Error abriendo la base de datos!!");
    }
}

-(void)compareProducts:(int)idProduct
{
    //Cargar lista de mercado con parametro para ultima lista
    [self searchPathOfDatabase];
    sqlite3_stmt * querySearch;
    NSString * stringSearch;
    
    _arrayCompareProducts = [[NSMutableArray alloc]init];
    
    stringSearch = [NSString stringWithFormat:@"SELECT tbl_mercado.ds_producto, tbl_mercado.val_unitario, tbl_listamercado.supermercado, tbl_listamercado.fecha_mercado FROM tbl_listamercado INNER JOIN tbl_mercado ON tbl_listamercado.id_listamercado = tbl_mercado.id_mercado WHERE id_producto = %i", idProduct];
    
    if (sqlite3_open(dbPath, &conexDB)==SQLITE_OK) {
        const char * searchSql = [stringSearch UTF8String];
        if (sqlite3_prepare_v2(conexDB, searchSql, -1, &querySearch, NULL)==SQLITE_OK) {
            //Ciclo para todos los registro
            while (sqlite3_step(querySearch)==SQLITE_ROW) {
                
                repoProducts = [[repoMarketProduct alloc]init];
                
                repoProducts.dsProduct = [NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 0)];
                
                repoProducts.nameMarketList = [NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 2)];
                
                repoProducts.dateMarketList = [NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 3)];
                
                repoProducts.valUnitProduct = [NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 1)];
                
                [_arrayCompareProducts addObject:repoProducts];
            }
        }
        
        sqlite3_finalize(querySearch);
        sqlite3_close(conexDB);
        
    }else{
        NSLog(@"Error al abrir la base de datos");
    }
}

-(void)addProductAtMarketWhithIdMarket:(int)idMarketVar AndIdProduct:(int)idProductVar AndDsProduct:(NSString *)dsProductVar AndCantProduct:(int)cantProductVar AndValUnitProduct:(int)valUnitProductVar AndSubTotal:(int)subTotalVar
{
    [self searchPathOfDatabase];
    sqlite3_stmt * queryInsert;
    
    if (sqlite3_open(dbPath, &conexDB)==SQLITE_OK) {
        //tomo el id del supermercado
        
        NSString * stringInsert = [NSString stringWithFormat:@"INSERT INTO tbl_mercado (id_mercado, id_producto, ds_producto, cant_producto, val_unitario, subtotal) VALUES (%i, %i, \"%@\", %i, %i, %i)", idMarketVar, idProductVar, dsProductVar, cantProductVar, valUnitProductVar, subTotalVar];
        
        const char * insertSql = [stringInsert UTF8String];
        sqlite3_prepare_v2(conexDB, insertSql, -1, &queryInsert, NULL);
        
        if (sqlite3_step(queryInsert)==SQLITE_DONE) {
            _status = @"Producto Agregado con Exito!!";
        } else {
            _status = @"Error almacenando el producto de Mercado!!";
            //Obtengo la descripcion del error
            NSLog(@"Error al agregar el producto. %s ", sqlite3_errmsg(conexDB));
            // Indica el numero del error.
            //int intInsert = sqlite3_step(queryInsert);
            //NSLog(@"%i",intInsert);
        }
        
        sqlite3_finalize(queryInsert);
        sqlite3_close(conexDB);
        
    } else {
        NSLog(@"Error al abrir la base de datos");
    }
}

-(void)createNewMarketListWhithArrayProductsWhithNameMarket:(NSString *)nameMarketVar
{
    [self searchPathOfDatabase];
    sqlite3_stmt * queryInsert;
        
        [self insertMarketListNew:nameMarketVar];
        
        //obtengo el id mercado actual
        int idMarketCurrent = [varAppDelegate.idSuperMercado intValue];
    
        [self loadMarketListAtArray:idMarketCurrent];
        
        //[self searchPathOfDatabase];
        
        int i=0;
        NSLog(@"Cantidad a insertar: %li", [_arrayDsProduct count]);
        
        while (i<[_arrayDsProduct count]) {
            NSString * stringInsert = [NSString stringWithFormat:@"INSERT INTO tbl_mercado (id_mercado, id_producto, ds_producto, cant_producto, val_unitario, subtotal) VALUES (%d, %@, \"%@\", %@, %@, %@)", varAppDelegate.idNewSuperMercado, [_arrayProduct objectAtIndex:i], [_arrayDsProduct objectAtIndex:i], [_arrayCantProduct objectAtIndex:i], [_arrayValProduct objectAtIndex:i], [_arraySubTotal objectAtIndex:i]];
            
            const char * insertSql = [stringInsert UTF8String];
            
            if (sqlite3_open(dbPath, &conexDB)==SQLITE_OK)
            {
                sqlite3_prepare_v2(conexDB, insertSql, -1, &queryInsert, NULL);
                
                if (sqlite3_step(queryInsert)==SQLITE_DONE) {
                    _status = [NSString stringWithFormat:@"Producto numero: %i Agregado con Exito!!",i];
                    
                    NSLog(@"Producto numero: %i Agregado con Exito!!",i);
                } else {
                    _status = [NSString stringWithFormat:@"Error agregando el producto numero: %i",i];
                    
                    NSLog(@"Error agregando el producto numero: %i",i);
                    
                    //Obtengo la descripcion del error
                    NSLog(@"Error al agregar el producto. %s ", sqlite3_errmsg(conexDB));
                    // Indica el numero del error.
                    //int intInsert = sqlite3_step(queryInsert);
                    //NSLog(@"%i",intInsert);
                }
                
                sqlite3_finalize(queryInsert);
                sqlite3_close(conexDB);
                
            } else {
                NSLog(@"Error al abrir la base de datos");
                //Obtengo la descripcion del error
                NSLog(@"Error en la base de datos: %s ", sqlite3_errmsg(conexDB));
            }
            
            i++;
        }
}

-(void)searchListMarket
{
    //Cargar lista de mercado con parametro para ultima lista
    [self searchPathOfDatabase];
    sqlite3_stmt * querySearch;
    NSString * stringSearch;
    
    _arrayAllMArketsList = [[NSMutableArray alloc]init];
    
    stringSearch = [NSString stringWithFormat:@"SELECT * FROM tbl_listamercado ORDER BY id_listamercado ASC"];
    
    if (sqlite3_open(dbPath, &conexDB)==SQLITE_OK) {
        const char * searchSql = [stringSearch UTF8String];
        if (sqlite3_prepare_v2(conexDB, searchSql, -1, &querySearch, NULL)==SQLITE_OK) {
            //Ciclo para todos los registro
            while (sqlite3_step(querySearch)==SQLITE_ROW) {
                
                repoProducts = [[repoMarketProduct alloc]init];
                
                repoProducts.idMarketList = [NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 0)];
                
                repoProducts.nameMarketList = [NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 3)];
                
                repoProducts.dateMarketList = [NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 1)];
                
                NSLog(@"%@",repoProducts.nameMarketList);
                
                [_arrayAllMArketsList addObject:repoProducts];
            }
        }
        
        sqlite3_finalize(querySearch);
        sqlite3_close(conexDB);
        
    }else{
        NSLog(@"Error al abrir la base de datos");
    }
}

-(void)insertMarketListNew:(NSString *)marketName
{
    [self takeVarIdMercado];
    [self searchPathOfDatabase];
    sqlite3_stmt * queryInsert;
    
    if (sqlite3_open(dbPath, &conexDB)==SQLITE_OK) {
        //Tomo y formato la fecha del dispositivo
        NSDateFormatter * dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateString=[dateFormat stringFromDate:[NSDate date]];
        
        NSString * stringInsert = [NSString stringWithFormat:@"INSERT INTO tbl_listamercado (id_listamercado, fecha_mercado, valor, supermercado) VALUES (%i, \"%@\", \"%@\", \"%@\")", varAppDelegate.idNewSuperMercado, dateString, @"0", marketName];
        
        const char * insertSql = [stringInsert UTF8String];
        sqlite3_prepare_v2(conexDB, insertSql, -1, &queryInsert, NULL);
        
        if (sqlite3_step(queryInsert)==SQLITE_DONE) {
            _status = @"Super Mercado creado con Exito!!";
        } else {
            _status = @"Error almacenando el Super Mercado!!";
        }
        
        sqlite3_finalize(queryInsert);
        sqlite3_close(conexDB);
        
    } else {
        NSLog(@"Error al abrir la base de datos");
    }
}

-(void)addListMarket:(NSString *)market
{
    [self searchPathOfDatabase];
    sqlite3_stmt * queryInsert;
    
    if (sqlite3_open(dbPath, &conexDB)==SQLITE_OK) {
        //Tomo y formato la fecha del dispositivo
        NSDateFormatter * dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateString=[dateFormat stringFromDate:[NSDate date]];
        
        NSString * stringInsert = [NSString stringWithFormat:@"INSERT INTO tbl_listamercado (fecha_mercado, valor, supermercado) VALUES (\"%@\", \"%@\", \"%@\")", dateString, @"0", market];
        
        const char * insertSql = [stringInsert UTF8String];
        sqlite3_prepare_v2(conexDB, insertSql, -1, &queryInsert, NULL);
        
        if (sqlite3_step(queryInsert)==SQLITE_DONE) {
            _status = @"Super Mercado creado con Exito!!";
        } else {
            _status = @"Error almacenando el Super Mercado!!";
        }
        
        sqlite3_finalize(queryInsert);
        sqlite3_close(conexDB);
        
    } else {
        NSLog(@"Error al abrir la base de datos");
    }
}

-(void) loadMarketListAtArray:(int)idMarket
{
    //Cargar lista de mercado con parametro para ultima lista
    [self searchPathOfDatabase];
    sqlite3_stmt * querySearch;
    NSString * stringSearch;
    
    _arrayIdMarket = [[NSMutableArray alloc]init];
    _arrayProduct = [[NSMutableArray alloc]init];
    _arrayDsProduct = [[NSMutableArray alloc]init];
    _arrayCantProduct = [[NSMutableArray alloc]init];
    _arrayValProduct = [[NSMutableArray alloc]init];
    _arraySubTotal = [[NSMutableArray alloc]init];
    
    stringSearch = [NSString stringWithFormat:@"select tbl_listamercado.supermercado, tbl_mercado.id_producto, tbl_mercado.ds_producto, tbl_mercado.val_unitario, tbl_mercado.cant_producto, tbl_mercado.subtotal from tbl_listamercado inner join tbl_mercado on tbl_listamercado.id_listamercado = tbl_mercado.id_mercado where tbl_mercado.id_mercado = %i", idMarket];
    
    if (sqlite3_open(dbPath, &conexDB)==SQLITE_OK) {
        const char * searchSql = [stringSearch UTF8String];
        if (sqlite3_prepare_v2(conexDB, searchSql, -1, &querySearch, NULL)==SQLITE_OK) {
            //Ciclo para todos los registro
            while (sqlite3_step(querySearch)==SQLITE_ROW) {
                
                [_arrayIdMarket addObject:varAppDelegate.idSuperMercado];
                
                [_arrayDsProduct addObject:[NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 2)]];
                
                [_arrayValProduct addObject:[NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 3)]];
                
                [_arrayCantProduct addObject:[NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 4)]];
                
                [_arraySubTotal addObject:[NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 5)]];
                
                [_arrayProduct addObject:[NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 1)]];
            }
        }
        
        sqlite3_finalize(querySearch);
        sqlite3_close(conexDB);
        
    }else{
        NSLog(@"Error abriendo la base de datos!!");
    }
}

-(void)loadMarketWithIdListMarket:(int) idListMarket
{
    //Cargar lista de mercado con parametro para ultima lista
    [self searchPathOfDatabase];
    sqlite3_stmt * querySearch;
    NSString * stringSearch;
    
    _arrayProductsOfCategory = [[NSMutableArray alloc]init];
    
    stringSearch = [NSString stringWithFormat:@"select tbl_listamercado.supermercado, tbl_mercado.id_producto, tbl_mercado.ds_producto, tbl_mercado.val_unitario, tbl_mercado.cant_producto, tbl_mercado.subtotal from tbl_listamercado inner join tbl_mercado on tbl_listamercado.id_listamercado = tbl_mercado.id_mercado where tbl_mercado.id_mercado = %i", idListMarket];
    
    if (sqlite3_open(dbPath, &conexDB)==SQLITE_OK) {
        const char * searchSql = [stringSearch UTF8String];
        if (sqlite3_prepare_v2(conexDB, searchSql, -1, &querySearch, NULL)==SQLITE_OK) {
            //Ciclo para todos los registro
            while (sqlite3_step(querySearch)==SQLITE_ROW) {
                
                repoProducts = [[repoMarketProduct alloc]init];
                
                repoProducts.dsProduct = [NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 2)];
                
                repoProducts.cantProduct = [NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 4)];
                
                repoProducts.subTotal = [NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 5)];
                
                repoProducts.idProduct = [NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 1)];
                
                [_arrayProductsOfCategory addObject:repoProducts];
            }
        }
        
        sqlite3_finalize(querySearch);
        sqlite3_close(conexDB);
        
    }else{
        NSLog(@"Error abriendo la base de datos!!");
    }
}

-(void)loadProductsOfCategory:(int)idCategory
{
    _arrayProductsOfCategory = [[NSMutableArray alloc]init];
    
    [self searchPathOfDatabase];
    sqlite3_stmt * querySearch;
    NSString * stringSearch;
    
    stringSearch = [NSString stringWithFormat:@"SELECT * FROM tbl_productos WHERE idcategoria = %i ORDER BY ds_producto ASC", idCategory];
    
    if (sqlite3_open(dbPath, &conexDB)==SQLITE_OK) {
        const char * searchSql = [stringSearch UTF8String];
        if (sqlite3_prepare_v2(conexDB, searchSql, -1, &querySearch, NULL)==SQLITE_OK) {
            //Ciclo para todos los registro
            while (sqlite3_step(querySearch)==SQLITE_ROW) {
                
                repoProducts = [[repoMarketProduct alloc]init];
                
                repoProducts.dsProduct = [NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 1)];
                
                repoProducts.valUnitProduct = [NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 3)];
                
                repoProducts.idProduct = [NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 0)];
                
                NSLog(@"Productos: %@", repoProducts.dsProduct);
                
                [_arrayProductsOfCategory addObject:repoProducts];
            }
        }
        
        sqlite3_finalize(querySearch);
        sqlite3_close(conexDB);
        
    }else{
        NSLog(@"Error abriendo la base de datos!!");
    }
}


-(void)loadCategorys
{
    [self searchPathOfDatabase];
    sqlite3_stmt * querySearch;
    NSString * stringSearch;
    
    _arrayDsCategory = [[NSMutableArray alloc]init];
    
    stringSearch = [NSString stringWithFormat:@"SELECT * FROM tbl_categorias ORDER BY id_categoria ASC"];
    if (sqlite3_open(dbPath, &conexDB)==SQLITE_OK) {
        const char * searchSql = [stringSearch UTF8String];
        if (sqlite3_prepare_v2(conexDB, searchSql, -1, &querySearch, NULL)==SQLITE_OK) {
            //Ciclo para todos los registro
            while (sqlite3_step(querySearch)==SQLITE_ROW) {
                
                [_arrayDsCategory addObject:[NSString stringWithFormat:@"%s", sqlite3_column_text(querySearch, 1)]];
            }
        }
        
        sqlite3_finalize(querySearch);
        sqlite3_close(conexDB);
        
    }else{
        NSLog(@"Error abriendo la base de datos!!");
    }
}

@end
