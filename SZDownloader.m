//
//  SZDownloader.m
//  LalightL
//
//  Created by comfouriertech on 17/3/27.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import "SZDownloader.h"

@interface SZdownloader()
@property (nonatomic,assign) float receiveBytes;
@property (nonatomic,assign) float exceptedBytes;
@property (nonatomic,strong) NSURLRequest *request;
@property (nonatomic,strong) NSURLConnection *connection;

//for block
@property (nonatomic,strong) SZDownloadProgressBlock progressDownloadBlock;
@property (nonatomic,strong) SZDowloadFinished progressFinishBlock;
@property (nonatomic,strong) SZDownloadFailBlock progressFailBlock;

@end

@implementation SZdownloader
@synthesize receiveData = _receiveData;
@synthesize request = _request;
@synthesize connection = _connection;
@synthesize downloadedPercentage = _downloadedPercentage;
@synthesize receiveBytes;
@synthesize exceptedBytes;
@synthesize progress = _progress;
@synthesize progressFailBlock = _progressFailBlock;
@synthesize progressDownloadBlock = _progressDownloadBlock;
@synthesize progressFinishBlock = _progressFinishBlock;
@synthesize delegate = _delegate;

-(id)initWithURL:(NSURL *)fileURL timeout:(NSInteger)timeout{
    
    
    self = [super init];
    
    if(self)
    {
        self.receiveBytes = 0;
        self.exceptedBytes = 0;
        _receiveData = [[NSMutableData alloc] initWithLength:0];
        _downloadedPercentage = 0.0f;
        self.request = [[NSURLRequest alloc] initWithURL:fileURL cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:timeout];
        self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
    }
    
    return self;
}

#pragma mark - NSURLConnectionDataDelegate

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receiveData appendData:data];
    
    NSInteger len = [data length];
    receiveBytes = receiveBytes + len;
    
    if(exceptedBytes != NSURLResponseUnknownLength)
    {
        _progress = ((receiveBytes/(float)exceptedBytes) * 100)/100;
        _downloadedPercentage = _progress * 100;
        
        if([_delegate respondsToSelector:@selector(SZDownloadProgress:Percentage:)])
        {
            [_delegate SZDownloadProgress:_progress Percentage:_downloadedPercentage];
        }
        else {
            if(_progressDownloadBlock) {
                _progressDownloadBlock(_progress,_downloadedPercentage);
            }
        }
    }
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //return back error
    if([_delegate respondsToSelector:@selector(SZDownloadFail:)])
    {
        [_delegate SZDownloadFail:error];
    }
    else {
        if(_progressFailBlock) {
            _progressFailBlock(error);
        }
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    exceptedBytes = [response expectedContentLength];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    self.connection = nil;
    
    if([_delegate respondsToSelector:@selector(SZDownloadFinished:)])
    {
        [_delegate SZDownloadFinished:_receiveData];
    }
    else {
        if(_progressFinishBlock) {
            _progressFinishBlock(_receiveData);
        }
    }
}

#pragma mark - properties
-(void)startWithDelegate:(id<SZdownloaderDelegate>)delegate {
    _delegate = delegate;
    if(self.connection) {
        [self.connection start];
        _progressDownloadBlock= nil;
        _progressFinishBlock = nil;
        _progressFailBlock = nil;
    }
}
-(void)startWithDownloading:(SZDownloadProgressBlock)progressBlock onFinished:(SZDowloadFinished)finishedBlock onFail:(SZDownloadFailBlock)failBlock {
    if(self.connection) {
        [self.connection start];
        _delegate = nil; //clear delegate
        _progressDownloadBlock = [progressBlock copy];
        _progressFinishBlock = [finishedBlock copy];
        _progressFailBlock = [failBlock copy];
    }
    
}
-(void)cancel {
    if(self.connection) {
        [self.connection cancel];
    }
}
@end
