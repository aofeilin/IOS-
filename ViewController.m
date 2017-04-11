//
//  ViewController.m
//  MS
//
//  Created by ule_zhangfanglin on 2017/4/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ViewController.h"
#import <AdSupport/ASIdentifierManager.h>
#import "MYKeyChain.h"
@interface ViewController ()
@property(nonatomic,copy)NSString * adId;
@end




#define kisvalidString(string) (string && string!=NULL && string.length>0)

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //《1》唯一标示广告标示符-----------      ASIdentifier   IDFA
    /**
       如果修改--ASIdentifier 1.还原位置与隐私或者（通用-还原-）----2.还原广告标示符（隐私-广告-）  来重新生成广告标示符。
     */
    
    /**
     *《2》唯一标示vendor标示符----------- IdentifierForVendor  IDFV
     */
    if ([ASIdentifierManager sharedManager].advertisingTrackingEnabled==YES) {
    //IDFA
        self.adId=[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        //保存到keychain
        [self useSave];
    }
    else
    {//IDFV
       
        self.adId=[UIDevice currentDevice].identifierForVendor.UUIDString;
        //保存到keychain
        [self useSave];
    }
   
    NSLog(@"%@",self.adId);
    

    //《3》keychain-----------------
    /**
     如果修改-keychain   1.恢复出厂设置，（隐私-广告-恢复出厂设置）
     如果还原所有设置0----self.adId值没有变化。如果是抹掉所有内容和设置，self.adId值发生了变化。
     itunes如果恢复出厂设置，会升级到最新。如果是手机不会升级到最新。
     1、“还原所有设置”结果不会，一样的版本；
     2、“抹掉内容并还原”这里又分两种情况（还原所有设置基本上很干净了 唯一删不掉的还是已经OTA到手机上的7.02升级文件    抹掉系统妥妥的自动升级。）
     a、如果你的机器上过WIFI且未越狱多半7.0.2其实已经下载到你手机上，如果此时你执行这样的操作一定升到7.0.2;
     b、如果你的机器从未连过WIFI未越狱，那么7.0.2多半没有下载到你手机，此时你执行这样的操作保持原来的版本。
     
     3、用ITUNES的话，就不用想了，一定升的。
     ------
     secitemAdd 增
     secitemDelete 删除
     secitemUpdate 改
     secitemCopymatching 查
     */
}
-(void)useSave
{
    if (kisvalidString([MYKeyChain myKeyChainLoad])) {
        //有值就不用去读取新的值
        self.adId=[MYKeyChain myKeyChainLoad];
    }
    else
    {
        //保存到keychain
        [MYKeyChain myKeyChainSave:[NSString stringWithFormat:@"%@",self.adId]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
