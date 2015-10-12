//
//  GoBuyViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "GoBuyViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "PayWayConfig.h"
#import "DataSigner.h"

@interface GoBuyViewController ()
- (IBAction)ZhiFuBao:(id)sender;

@end

@implementation GoBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)ZhiFuBao:(id)sender {
    Order *order=[[Order alloc] init];
    order.partner = PartnerID;
    order.seller  =  SellerID;
    order.tradeNO = @"1502";//交易号
    order.productName = @"iphone6";
    order.productDescription = @"ipone6降价处理";
    order.amount = @"0.02";
    //当交易成功后，或给URL发送post通知，回调地址，如果不填写，则无通知服务器更改订单状态
     order.service = @"mobile.securitypay.pay";
    //交易类型，商品交易
    order.paymentType= @"1";
    order.inputCharset = @"utf-8";
    //超时时间，m分，h时 d天，超时交易自动关闭
    order.itBPay = @"30m";
    
    //要在URL Scheme中设置同样的字符串
    //除了在代码中设置该属性，还需在info.plist 中添加url Scheme(URl Type)
    //作用：支付成功后，回调App，进行下一步 的交易步骤（显示订单详情等）
    NSString *appScheme = @"alipayDemo";
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    
    //使用私钥进行数据签名
    id<DataSigner> signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderSpec];
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
        //启动支付宝的客户端
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }

}
@end





















