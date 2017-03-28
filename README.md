# SZDownloader

SZDownloader是一个用于下载文件的小型库。您可以使用Block或Delegate下载文件。如果您正在使用TableView，您应该使用Delegate而不是Block。


＃＃如何使用

下载SZDownloader.h和SZDownloader.m并添加到你的项目。

###使用块

SZDownloader * downloader = [[SZDownloader alloc] initWithURL：[NSURL URLWithString：@“http://myfile.com/file.jpg”] timeout：60];  
[downloader startWithDownloading：（float progress，NSInteger percentage）{  
  
//进度条进度  
//下载百分比的百分比  
} onFinished :( NSData * fileData，NSString * fileName）{  
  
//使用NSData编写文件或图像  
} onFail（NSError * error）{  
  
//失败  
}];  
###使用Delegate

遵循SZDownloaderDelegate协议

SZDownloader * downloader = [[SZDownloader alloc] initWithURL：[NSURL URLWithString：@“http://myfile.com/file.jpg”] timeout：60];  
[downloader startWithDelegate：self];//委托方法是必需的  
  
- （void）SGDownloadProgress：（float）progress百分比：（NSInteger）percent;   
- （void）SGDownloadFinished :( NSData *）fileData;   
- （void）SGDownloadFail：（NSError *）error;   

允许1-5个并发下载1个文件（如下载管理器）

＃使用块的示例

[objc] view plain copy 在CODE上查看代码片派生到我的代码片
-(void)download  
{  
    _requestStringURL=kCloudURL;  
    NSURL *requestURL=[NSURL URLWithString:_requestStringURL];  
    SZDownloader *downloader=[[SZDownloader alloc] initWithURL:requestURL timeout:6.0];  
    [downloader startWithDownloading:^(float progressValue, NSInteger percentage)  
    {  
        NSLog(@"progressValue=%f,percentage=%ld",progressValue,percentage);  
    } onFinished:^(NSData *fileData)  
    {  
        NSDictionary *jsonDict=[NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];  
        NSLog(@"jsonDict=%@",jsonDict);  
        [downloader cancel];  
    }  
    onFail:^(NSError *error)  
     {  
        NSLog(@"auth error=%@",error);  
        [downloader cancel];  
    }];  
}  
##更新日志

###版本0.2

允许暂停和恢复

允许下载与进度


最后，如果您觉得SZDownloader好，请点个star,或者加入进来维护它。O(∩_∩)O谢谢！



English:

SZDownloader is a small library for downloading file.
It supported

Block
Delegate
ARC
You can use Block or Delegate for downloading the file. If you are using with TableView, you should use Delegate instead of Block.

##How to use

Put

SZDownloader.h
SZDownloader.m
to your project.

###for using Block

SZDownloader *downloader = [[SZDownloader alloc] initWithURL:[NSURL URLWithString:@"http://myfile.com/file.jpg"] timeout:60];

[downloader startWithDownloading:(float progress,NSInteger percentage) {
	
	//progress for progress bar
	//percentage for download percentage
	
} onFinished:(NSData* fileData,NSString* fileName){
	
	//use NSData to write a file or image
	
}onFail (NSError* error){

	//on fail

}];
###for using Delegate put SZDownloader delegate at .h file

@interface progressCell : UITableViewCell <SZDownloaderDelegate>
in .m file

SZDownloader *downloader = [[SZDownloader alloc] initWithURL:[NSURL URLWithString:@"http://myfile.com/file.jpg"] timeout:60];

[downloader startWithDelegate:self];
Delegate Methods are required

-(void)SGDownloadProgress:(float)progress Percentage:(NSInteger)percentage;
-(void)SGDownloadFinished:(NSData*)fileData;
-(void)SGDownloadFail:(NSError*)error;
##Todo

allow 1-5 concurrent download for 1 file (like download manager)


#Example for using Block

-(void)download  
{  
    _requestStringURL=kCloudURL;  
    NSURL *requestURL=[NSURL URLWithString:_requestStringURL];  
    SZDownloader *downloader=[[SZDownloader alloc] initWithURL:requestURL timeout:6.0];  
    [downloader startWithDownloading:^(float progressValue, NSInteger percentage)  
    {  
        NSLog(@"progressValue=%f,percentage=%ld",progressValue,percentage);  
    } onFinished:^(NSData *fileData)  
    {  
        NSDictionary *jsonDict=[NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];  
        NSLog(@"jsonDict=%@",jsonDict);  
        [downloader cancel];  
    }  
    onFail:^(NSError *error)  
     {  
        NSLog(@"auth error=%@",error);  
        [downloader cancel];  
    }];  
} 

##Log

###Version 0.2

Allow Pause and Resume

Allow Download with Progress

Finally,if you think SZDownloader is  good,please star it or join us to maintain it.thanks you.
