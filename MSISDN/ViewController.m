//
//  ViewController.m
//  MSISDN
//
//  Created by Jonas Boserup on 29/10/14.
//  Copyright (c) 2014 Jonas Boserup. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://portal.unwire.dk/UMP/editordraft/Mobilepix/tuborg/"
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSString *responseString = operation.responseString;
             
             NSRange firstRange = [responseString rangeOfString:@"&msisdn="];
             NSRange secondRange = [responseString rangeOfString:@"%0A"];
             NSRange resultRange = NSMakeRange(firstRange.location + firstRange.length, secondRange.location - firstRange.location - firstRange.length);
             NSString *result = [responseString substringWithRange:resultRange];
             
             
             if([result isEqualToString:@"-1"]) {
                 [_spinner setHidden:YES];
                 [_resultLabel setText:@"Nej. Du er ikke berørt. 😱"];
             } else {
                 [_spinner setHidden:YES];
                 [_resultLabel setText:[NSString stringWithFormat:@"Ja, hej +%@ 😊", result]];
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [_spinner setHidden:YES];
             [_resultLabel setText:@"Kunne ikke indlæse. 😅"];
         }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
