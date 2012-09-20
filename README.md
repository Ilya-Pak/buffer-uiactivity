Buffer UIActivity
=============

A UIActivity for [Buffer](http://bufferapp.com). Add this UIActivity to your UIActivityViewController to allow users to post to Buffer.

## Example Usage

    BufferUIActivity *bufferActivity = [[BufferUIActivity alloc] init];
    
    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[@"Hello world.", @"http://bufferapp.com"] applicationActivities:@[ bufferActivity ]];
    
    [self presentViewController:activityView animated:YES completion:^{}];
    
    
## Requirements

[Buffer](http://bufferapp.com) UIActivity requires iOS6.

Currently also depends on...
* [AFNetworking](https://github.com/AFNetworking/AFNetworking/)
* [TwitterText](https://github.com/twitter/twitter-text-objc)
* [GTMO-Auth2](http://code.google.com/p/gtm-oauth2/)

## Todo

* Better support for activity items.
* Improved Error Handling.
* Support for iPad.
* Dismiss Activity Sheet.
* Remove dependencies.