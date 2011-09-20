//
//  RootViewController.m
//  UIWebView+XSSSample
//

#import "RootViewController.h"

@implementation RootViewController


-(void)dealloc
{
  [_webView release], _webView = nil;
  [super dealloc];
}

- (void)loadView
{
  self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  _webView = [[[UIWebView alloc] initWithFrame:self.view.frame] autorelease];
  _webView.delegate = self;
  
  //NSURL* URL = [[[NSBundle mainBundle] resourceURL] URLByAppendingPathComponent:@"index.html"]; // XSS
  //NSURL* URL = [NSURL URLWithString:@"http://twitter.com/"]; // NONE
  //[_webView loadRequest:[NSURLRequest requestWithURL:URL]];
  
  NSString* src = [[[NSString alloc] initWithContentsOfURL:[[[NSBundle mainBundle] resourceURL] URLByAppendingPathComponent:@"index.html"] 
                                                  encoding:NSUTF8StringEncoding 
                                                     error:nil] autorelease];
  [_webView loadHTMLString:@"<html></html>" baseURL:nil];
  
  [self.view addSubview:_webView];
  
  UIButton* button = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)] autorelease];
  button.backgroundColor = [UIColor grayColor];
  [button setTitle:@"TouchME!" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
  [self.view addSubview:button];
}

-(void)buttonAction:(id)sender
{
  NSLog(@"%@", [_webView stringByEvaluatingJavaScriptFromString:@"location.href"]);
  NSString* src = [[[NSString alloc] initWithContentsOfURL:[[[NSBundle mainBundle] resourceURL] URLByAppendingPathComponent:@"src.js"] 
                                                           encoding:NSUTF8StringEncoding 
                                                           error:nil] autorelease];
  NSString* ret = [_webView stringByEvaluatingJavaScriptFromString:src];
  NSLog(@"Ret: %@", ret);
}

# pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
  NSLog(@"URL: %@", [request URL]);
  return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  ;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
  NSLog(@"ERROR: %@", [error localizedDescription]);
}


@end
