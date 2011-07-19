

#import <Foundation/Foundation.h>


//@protocol webServiceDelegate
//
//-(void)webServiceFinish:(NSMutableData *)data;
//-(void)webServiceFinishWithError:(NSError *)error;
//
//@end

@interface WebServiceHandler : NSObject {
	//id<webServiceDelegate> delegate;

	NSMutableData *webData;
    NSMutableString *soapResults;
    NSURLConnection *conn;
	NSString *theXML;		//the recieved xml text from the webservices

}


@property(nonatomic,retain) NSString *theXML;
-(id)initWithWord:(NSString *)aWord;
@end
