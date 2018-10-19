//
//  PMLContentDetailCollectionCell.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLContentDetailCollectionCell.h"

@interface PMLContentDetailCollectionCell()<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler, UIScrollViewDelegate>
@property (nonatomic, strong) WKWebView *contentWebView;//文章内容
@property (nonatomic, strong) UIView *placeHolderView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end
@implementation PMLContentDetailCollectionCell

- (void)dealloc {
        if (self.contentWebView){
            [self.contentWebView stopLoading];
        }
    self.contentWebView.navigationDelegate = nil;
    self.contentWebView.UIDelegate = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentWebView];
//    [self addSubview:self.placeHolderView];
//    [self bringSubviewToFront:self.placeHolderView];
//    [self.placeHolderView addSubview:self.activityIndicator];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
//    [self.placeHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(0);
//        make.left.equalTo(self.mas_left).offset(0);
//        make.right.equalTo(self.mas_right).offset(0);
//        make.bottom.equalTo(self.mas_bottom).offset(0);
//    }];
//    [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(0);
//        make.left.equalTo(self.mas_left).offset(0);
//        make.right.equalTo(self.mas_right).offset(0);
//        make.bottom.equalTo(self.mas_bottom).offset(0);
//    }];
}

- (void)loadingStart {
    self.placeHolderView.alpha = 1;
    [self.activityIndicator startAnimating];
}

- (void)loadingFinish {
    [UIView animateWithDuration:0.5 animations:^{
        self.placeHolderView.alpha = 0;
        [self.activityIndicator stopAnimating];
    }];
}



#pragma mark- =====================UIWebViewDelegate method=====================
#pragma mark- =====================WKWebViewDelegate method=====================
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    NSString *functionStr =@"function mapSet(size){\
//    document.getElementsByTagName('body')[0].style.height = 0;\
//    var array = ['div','p','span','ul','ol','dd','dt','dl','li','a','i','em','strong','b','section','table','h1','h2','h3','h4','h5','h6'];\
//    for(var i = 0,l=array.length;i<l;i++){\
//    setSize(array[i],size);\
//    }\
//    }";

//    NSString *functionM = @"function setSize(tag,size){\
//    var tags = document.getElementsByTagName(tag);\
//    for(var i=0,l=tags.length;i<l;i++){\
//    tags[i].style.fontSize = size + 'px';\
//    }\
//    }";
//
//    NSString *image =@"function image(){\
//    document.getElementsByTagName('img').syle.width = 100%;\
//    }";

///<p><video src="https://videos.files.wordpress.com/kUJmAcSf/bbb_sunflower_1080p_30fps_normal.mp4" poster="https://videos.files.wordpress.com/kUJmAcSf/bbb_sunflower_1080p_30fps_normal_scruberthumbnail_2.jpg" alt="Video about bunnies"></video></p>
//    NSString *video =@"function getVideo(){\
//    Media = document.getElementById(`videoTest`);\
//    Media.syle.width = 320;\
//    Media.syle.height = 200;\
//    }";

//    NSString *imageFunc = [NSString stringWithFormat:@"image();"];
//    NSString *fontFunc = [NSString stringWithFormat:@"mapSet(%ld);",(long)15];
//    NSString *videoFunc = [NSString stringWithFormat:@"getVideo();"];
//    NSString *jsFunc = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n",functionStr,functionM,image,imageFunc,fontFunc,video,videoFunc];
//    [self.contentWebView evaluateJavaScript:functionStr completionHandler:^(id _Nullable item, NSError * _Nullable error) {
//        if (error){
//            NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCancelled userInfo:@{NSLocalizedRecoveryOptionsErrorKey : @"请求失败"}];
//            [self webView:webView didFailNavigation:navigation withError:error];
//            return;
//        }
//    }];

//    [self.contentWebView evaluateJavaScript:functionM completionHandler:nil];
//    [self.contentWebView evaluateJavaScript:image completionHandler:nil];
//    [self.contentWebView evaluateJavaScript:imageFunc completionHandler:nil];
//    [self.contentWebView evaluateJavaScript:fontFunc completionHandler:nil];
//    [self.contentWebView evaluateJavaScript:video completionHandler:nil];
//    [self.contentWebView evaluateJavaScript:videoFunc completionHandler:nil];
//    [self.contentWebView evaluateJavaScript:jsFunc completionHandler:nil];

}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    //    [[HLProgressHud shared]error:@"请求失败"];
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {

}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"WKUserContentController:%@",userContentController);
    NSLog(@"message:%@",message);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}

#pragma mark- =====================setter method=====================
- (void)setHtmlStr:(NSString *)htmlStr {
    if (!_htmlStr){
        _htmlStr = htmlStr;

        [self.contentWebView loadHTMLString:htmlStr baseURL:nil];
    }else{
    }
}

- (void)setHtmlUrl:(NSURL *)htmlUrl {
    if (_htmlUrl != htmlUrl){
        _htmlUrl = htmlUrl;
        [self.contentWebView loadRequest:[NSURLRequest requestWithURL:htmlUrl]];
    }else{
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    __weak typeof(self) weakSelf = self;
    [webView evaluateJavaScript:@"document.body.scrollHeight;" completionHandler:^(NSString* _Nullable fitHeight, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"fitHeight:%@",fitHeight);
        if (strongSelf.contentDetailHightBlock){
            strongSelf.contentDetailHightBlock([fitHeight floatValue]);
        }
    }];
}

- (void)moreBtnClicked {

}

- (void)praiseBtnClicked {

}

- (UIView *)placeHolderView {
    if (!_placeHolderView){
        _placeHolderView = [UIView new];
        _placeHolderView.alpha = 1;
    }
    return _placeHolderView;
}

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator){
        UIActivityIndicatorView *indicator = [UIActivityIndicatorView new];
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        indicator.color = [UIColor colorWithRed:35.0/255 green:35.0/255 blue:35.0/255 alpha:1];
        _activityIndicator = indicator;
    }
    return _activityIndicator;
}


- (WKWebView *)contentWebView {

    if (!_contentWebView){
//        NSString *js = @" $('meta[name=description]').remove(); $('head').append( '<meta name=\"viewport\" content=\"width=device-width, initial-scale=1,user-scalable=no\">' );";
//        WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];

        NSString *jScript = @"var meta = document.createElement('meta');\
                                  meta.setAttribute('name', 'viewport');\
                                  meta.setAttribute('content', 'width=device-width', 'initial-scale=1', 'user-scalable=no');\
                                  document.getElementsByTagName('head')[0].appendChild(meta);";

        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];

        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
//        [wkUController addUserScript:script];
//        [wkUController addScriptMessageHandler:self name:@"openInfo"];

//        WKUserContentController *wkUController = [WKUserContentController new];
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.userContentController = wkUController;

        WKWebView *contentWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) configuration:wkWebConfig];
        contentWebView.backgroundColor = [UIColor clearColor];
        [contentWebView setOpaque:NO];
        contentWebView.scrollView.scrollEnabled = false;
        contentWebView.contentScaleFactor = 0.5;
        contentWebView.navigationDelegate = self;
        contentWebView.UIDelegate = self;
        contentWebView.scrollView.delegate = self;
//        contentWebView.userInteractionEnabled = false;
        _contentWebView = contentWebView;
    }
    return _contentWebView;
}

@end
