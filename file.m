-(void) aMethod {
    CRVStompClient *s = [[CRVStompClient alloc]
                         initWithUrl:@"http://localhost:8080/hello"
                         login:kUsername
                         passcode:kQueueName
                         delegate:self];
    [s connect];


    /*NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"client", @"ack",
                             @"true", @"activemq.dispatchAsync",
                             @"1", @"activemq.prefetchSize", nil];*/
    //[s subscribeToDestination:kQueueName withHeader: headers];
    [self setService: s];
}

#pragma mark CRVStompClientDelegate
- (void)stompClientDidConnect:(CRVStompClient *)stompService {
    NSLog(@"stompServiceDidConnect");
    [service sendMessage:@"{'name': 'hello'}" toDestination:@"/app/hello"];
}

- (void)stompClient:(CRVStompClient *)stompService messageReceived:(NSString *)body withHeader:(NSDictionary *)messageHeader {
    NSLog(@"gotMessage body: %@, header: %@", body, messageHeader);
    NSLog(@"Message ID: %@", [messageHeader valueForKey:@"message-id"]);
    [stompService ack: [messageHeader valueForKey:@"message-id"]];
}

- (void)dealloc {
    [service unsubscribeFromDestination: kQueueName];
}
