
#import "XMLResponseSerializerDelegate.h"
#import "LoginResponseParserDelegate.h"
#import "LoginResponse.h"
#import "NotAuthorizedResponseParserDelegate.h"
#import "NotAuthorizedResponse.h"
#import "RepositoriesParserDelegate.h"


#pragma mark - Login response

@interface LoginResponseSerializerDelegate ()
@property (nonatomic,strong) LoginResponseParserDelegate* parserDelegate;
@end

@implementation LoginResponseSerializerDelegate

-(instancetype)init {
    self = [super init];
    if (self) {
        self.parserDelegate = [[LoginResponseParserDelegate alloc] init];
    }
    
    return self;
}

-(id <NSXMLParserDelegate>)xmlParserDelegate {
    return self.parserDelegate;
}

-(id)parseResult {
    LoginResponse *result = nil;
    if (self.parserDelegate.resultValue) {
        result = [[LoginResponse alloc] initWithValue:self.parserDelegate.resultValue AndToken:self.parserDelegate.secureToken];
    }
    
    return result;
}

-(NSDictionary*)errorUserInfo:(id)response {
    return @{
             NSLocalizedDescriptionKey : NSLocalizedStringFromTable(@"Error when parsing login response", nil, @"PydioSDK"),
             NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:NSLocalizedStringFromTable(@"Could not extract login result value from: %@", nil, @"PydioSDK"), response]
             };
}

@end

#pragma mark - Not Authorized response

@interface NotAuthorizedResponseSerializerDelegate ()
@property (nonatomic,strong) NotAuthorizedResponseParserDelegate* parserDelegate;
@end

@implementation NotAuthorizedResponseSerializerDelegate

-(instancetype)init {
    self = [super init];
    if (self) {
        self.parserDelegate = [[NotAuthorizedResponseParserDelegate alloc] init];
    }
    
    return self;
}

-(id <NSXMLParserDelegate>)xmlParserDelegate {
    return self.parserDelegate;
}

-(id)parseResult {
    NotAuthorizedResponse *result = nil;
    if (self.parserDelegate.notLogged) {
        result = [[NotAuthorizedResponse alloc] init];
    }
    
    return result;
}

-(NSDictionary*)errorUserInfo:(id)response {
    return nil;
}

@end

#pragma mark - Workspaces response

@interface WorkspacesResponseSerializerDelegate ()
@property (nonatomic,strong) RepositoriesParserDelegate *parserDelegate;
@end

@implementation WorkspacesResponseSerializerDelegate

-(instancetype)init {
    self = [super init];
    if (self) {
        self.parserDelegate = [[RepositoriesParserDelegate alloc] init];
    }
    
    return self;
}

-(id <NSXMLParserDelegate>)xmlParserDelegate {
    return self.parserDelegate;
}

-(id)parseResult {
    NSArray *result = nil;
    if (self.parserDelegate.repositories) {
        result = [NSArray arrayWithArray:self.parserDelegate.repositories];
    }
    
    return result;
}

-(NSDictionary*)errorUserInfo:(id)response {
    return @{
             NSLocalizedDescriptionKey : NSLocalizedStringFromTable(@"Error when parsing get repositories response", nil, @"PydioSDK"),
             NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:NSLocalizedStringFromTable(@"Could not extract get repositories result: %@", nil, @"PydioSDK"), response]
             };
}

@end
