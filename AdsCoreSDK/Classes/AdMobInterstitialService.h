#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import GoogleMobileAds;

NS_ASSUME_NONNULL_BEGIN

@interface AdMobInterstitialService : NSObject

- (void)loadWithAdId:(NSString *)adId didLoad:(void (^)(void))didLoad didFailed:(void (^)(NSString *))didFailed;
- (void)displayFromViewController:(UIViewController *)viewController didFailed:(void (^)(NSString *))didFailed;
- (void)setFullScreenContentDelegateWithDidFailToPresentFullScreenContentWithError:(void (^)(NSString *))didFailToPresentFullScreenContentWithError
                                                    adWillPresentFullScreenContent:(void (^)(void))adWillPresentFullScreenContent
                                                     adDidDismissFullScreenContent:(void (^)(void))adDidDismissFullScreenContent;

@end

NS_ASSUME_NONNULL_END
