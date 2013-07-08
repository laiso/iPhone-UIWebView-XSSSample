//
//  RootViewController.h
//  UIWebView+XSSSample

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface RootViewController : UIViewController<UIWebViewDelegate, UINavigationControllerDelegate>{
  UIWebView* _webView;
}
@end
