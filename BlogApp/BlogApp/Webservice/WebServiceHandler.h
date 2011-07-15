

#import <Foundation/Foundation.h>

@interface WebServiceHandler : NSObject {
	//id<webServiceDelegate> delegate;

	NSMutableData *webData;
    NSMutableString *soapResults;
    NSURLConnection *conn;
	NSString *theData;		//the recieved xml text from the webservices
    NSMutableDictionary *result;

}


@property(nonatomic,retain) NSString *theXML;
-(id)initWithWord:(NSURL *) url;
-(NSMutableDictionary *) returnData;
@end
