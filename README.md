IOS-UUID
IOS唯一标示符


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
