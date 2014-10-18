//
//  ViewController.m
//  Lista de Mercado
//
//  Created by Juan C Salazar on 10/10/14.
//  Copyright (c) 2014 Juan C Salazar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    addMarquet = [[Market alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createMarketListButton:(id)sender {
    [addMarquet addListMarket:_nameSuperMarketText.text];
    message = [[UIAlertView alloc]initWithTitle:@"Mercado"
                                        message:addMarquet.status
                                       delegate:self
                              cancelButtonTitle:@"Aceptar"
                              otherButtonTitles:nil];
    
    [message show];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
