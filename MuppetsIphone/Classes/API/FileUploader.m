//
//  FileUploader.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/17/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "FileUploader.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"

@interface FileUploader(private)

@end

@implementation FileUploader

@synthesize status;
@synthesize delegate;
@synthesize statusBlock;
@synthesize finishedBlock;
@synthesize asset;

- (id)init{
    self = [super init];
    if (self) {
        status = FileUploaderStatusNew;
    }
    return self;
}

- (void)dealloc{
    [delegate release];
    [statusBlock release];
    [finishedBlock release];
    [asset release];

    [super dealloc];
}

- (void)setStatus:(FileUploaderStatus)astatus{
    status = astatus;
    statusBlock(astatus);
}

- (void)startUploadingImage:(UIImage *)image 
                  withToken:(NSDictionary *)aToken 
              statusChanged:(void (^)(FileUploaderStatus))astatusblock
                   finished:(void (^)(FileUploader *, NSDictionary *))acompletionblock{
    self.asset = aToken;
    
    self.finishedBlock = acompletionblock;
    self.statusBlock   = astatusblock;
    
    NSMutableData *_imageData = [UIImagePNGRepresentation(image) mutableCopy];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[aToken objectForKey:@"upload_url"]]];
	[request setDelegate:self];
	[request setRequestMethod:@"PUT"];
    [request setPostBody:_imageData];
    
	[request addRequestHeader:@"Date" value:[aToken objectForKey:@"date"]];
	[request addRequestHeader:@"Authorization" value:[aToken objectForKey:@"signature"]];
	[request addRequestHeader:@"Content-Type" value:[aToken objectForKey:@"content_type"]];
    [request addRequestHeader:@"x-amz-acl" value:@"public-read"];
	
	[request setDidFinishSelector:@selector(fileUploadDone:)];
	[request setDidFailSelector:@selector(fileUploadFailed:)];
	
	[request startAsynchronous];
}

- (void)startUploadingFile:(NSString *)path
                 withToken:(NSDictionary *)aToken 
             statusChanged:(void (^)(FileUploaderStatus))astatusblock
                  finished:(void (^)(FileUploader *, NSDictionary *))acompletionblock{
    self.asset = aToken;
    
    self.finishedBlock = acompletionblock;
    self.statusBlock   = astatusblock;
    
    NSMutableData *_imageData = [NSData dataWithContentsOfFile:path];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[aToken objectForKey:@"upload_url"]]];
	[request setDelegate:self];
	[request setRequestMethod:@"PUT"];
    [request setPostBody:_imageData];
    
	[request addRequestHeader:@"Date" value:[aToken objectForKey:@"date"]];
	[request addRequestHeader:@"Authorization" value:[aToken objectForKey:@"signature"]];
	[request addRequestHeader:@"Content-Type" value:[aToken objectForKey:@"content_type"]];
    [request addRequestHeader:@"x-amz-acl" value:@"public-read"];
	
	[request setDidFinishSelector:@selector(fileUploadDone:)];
	[request setDidFailSelector:@selector(fileUploadFailed:)];
	
	[request startAsynchronous];
}

- (void)fileUploadDone:(ASIHTTPRequest *)request{
    self.status = FileUploaderStatusUploadCompleted;
    ASIHTTPRequest *_request    = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kMuppetsApiAssetComplete([[self.asset objectForKey:@"id"] intValue])]];
    
	[_request setDelegate:self];
    [_request setDidFinishSelector:@selector(completionDone:)];
	[_request setDidFailSelector:@selector(completionFailed:)];
    
    [_request startAsynchronous];
}

- (void)fileUploadFailed:(ASIHTTPRequest *)request{
    self.status = FileUploaderStatusUploadError;
	NSError *error = [request error];
    DLog(@"File Upload Error: %@", [error localizedDescription]);
}

- (void)completionDone:(ASIHTTPRequest *)request{
    NSDictionary *_responseData = [[[request responseString] JSONValue] objectForKey:@"data"];
    self.status = FileUploaderStatusNotifiedServer;
    finishedBlock(self, _responseData);
}

- (void)completionFailed:(ASIHTTPRequest *)request{
    self.status = FileUploaderStatusNotifiedServerError;
    DLog(@"Completion Failed");
}

@end
