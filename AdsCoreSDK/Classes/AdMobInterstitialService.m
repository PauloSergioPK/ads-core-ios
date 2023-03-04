#import "AdMobInterstitialService.h"
@import GoogleMobileAds;

@interface AdMobInterstitialService () <GADFullScreenContentDelegate>
@property(nonatomic, strong) GADInterstitialAd *interstitial;
@property(nonatomic, copy) void (^didFailToPresentFullScreenContentWithErrorCallback)(NSString *);
@property(nonatomic, copy) void (^adWillPresentFullScreenContentCallback)(void);
@property(nonatomic, copy) void (^adDidDismissFullScreenContentCallback)(void);
@end

@implementation AdMobInterstitialService

- (void)loadWithAdId:(NSString *)adId didLoad:(void (^)(void))didLoad didFailed:(void (^)(NSString *))didFailed {
    GADRequest *request = [GADRequest new];
    [GADInterstitialAd loadWithAdUnitID:adId
                                request:request
                      completionHandler:^(GADInterstitialAd *ad, NSError *error) {
        if (error != nil) {
            didFailed(error.localizedDescription);
            return;
        }
        self.interstitial = ad;
        self.interstitial.fullScreenContentDelegate = self;
        didLoad();
    }];
}

- (void)displayFromViewController:(UIViewController *)viewController didFailed:(void (^)(NSString *))didFailed {
    if (self.interstitial != nil) {
        [self.interstitial presentFromRootViewController:viewController];
    } else {
        didFailed(@"Interstitial Ad wasn't ready");
    }
}

- (void)setFullScreenContentDelegateWithDidFailToPresentFullScreenContentWithError:(void (^)(NSString *))didFailToPresentFullScreenContentWithError
                                                    adWillPresentFullScreenContent:(void (^)(void))adWillPresentFullScreenContent
                                                     adDidDismissFullScreenContent:(void (^)(void))adDidDismissFullScreenContent {
    self.didFailToPresentFullScreenContentWithErrorCallback = didFailToPresentFullScreenContentWithError;
    self.adWillPresentFullScreenContentCallback = adWillPresentFullScreenContent;
    self.adDidDismissFullScreenContentCallback = adDidDismissFullScreenContent;
}

#pragma mark - GADFullScreenContentDelegate

- (void)ad:(nonnull id<GADFullScreenPresentingAd>)ad
didFailToPresentFullScreenContentWithError:(nonnull NSError *)error {
    if (self.didFailToPresentFullScreenContentWithErrorCallback != nil) {
        self.didFailToPresentFullScreenContentWithErrorCallback(error.localizedDescription);
    }
}

- (void)adWillPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    if (self.adWillPresentFullScreenContentCallback != nil) {
        self.adWillPresentFullScreenContentCallback();
    }
}

- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    if (self.adDidDismissFullScreenContentCallback != nil) {
        self.adDidDismissFullScreenContentCallback();
    }
}

@end
