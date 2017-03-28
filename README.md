# SZDownloader
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

Finally,if you think SZDownloader is  good,please star it.thanks you.
