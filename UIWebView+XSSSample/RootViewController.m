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
  
  // リソースパスのURLからリクエストをロードするパターン
//  NSURL* URL = [[[NSBundle mainBundle] resourceURL] URLByAppendingPathComponent:@"index.html"]; // XSS
//  //NSURL* URL = [NSURL URLWithString:@"http://twitter.com/"]; // NONE
//  [_webView loadRequest:[NSURLRequest requestWithURL:URL]];
//  

  // リソースパスのファイルをHTML文字列としてロードするパターン
  NSString* src = [[[NSString alloc] initWithContentsOfURL:[[[NSBundle mainBundle] resourceURL] URLByAppendingPathComponent:@"index.html"] 
                                                  encoding:NSUTF8StringEncoding 
                                                     error:nil] autorelease];
  [_webView loadHTMLString:src baseURL:[NSURL URLWithString:@"http://localhost/"]];
  //[_webView loadHTMLString:src baseURL:[NSURL URLWithString:@"file:"]];
  //[_webView loadHTMLString:src baseURL:nil];
  
  NSLog(@"loadView: %@", [_webView stringByEvaluatingJavaScriptFromString:@"location.href"]);
  
  [self.view addSubview:_webView];
  
  UIButton* button = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)] autorelease];
  button.backgroundColor = [UIColor grayColor];
  [button setTitle:@"TouchME!" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
  [self.view addSubview:button];
}

-(void)buttonAction:(id)sender
{
  NSLog(@"buttonAction: %@", [_webView stringByEvaluatingJavaScriptFromString:@"location.href"]);
  /*
  NSString* src = [[[NSString alloc] initWithContentsOfURL:[[[NSBundle mainBundle] resourceURL] URLByAppendingPathComponent:@"src.js"] 
                                                           encoding:NSUTF8StringEncoding 
                                                           error:nil] autorelease];
  [_webView loadHTMLString:[NSString stringWithFormat:@"<script>%@</script>", src] baseURL:nil];
  */
}

# pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
  NSLog(@"URL: %@", [request URL]);
  return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  NSLog(@"webViewDidFinishLoad: %@", [_webView stringByEvaluatingJavaScriptFromString:@"location.href"]);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
  NSLog(@"ERROR: %@", [error localizedDescription]);
}


@end
