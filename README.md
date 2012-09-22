Buffer UIActivity
=============

A UIActivity for [Buffer](http://bufferapp.com). Add this UIActivity to your UIActivityViewController to allow users to post to Buffer.

## Getting Started

1. Include all of the Buffer UIActivity Files along with its dependencies.
2. [Create a Buffer app](http://bufferapp.com/developers/apps/create).
3. Insert the Cliend ID and Client Secret into BufferSheetViewController.m.
4. Load the UIActivityViewController like the example below with BufferUIActivity in the applicationActivities array.

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