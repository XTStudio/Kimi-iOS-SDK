//
//  UIReloader.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2019/1/10.
//  Copyright © 2019年 XT Studio. All rights reserved.
//

#import "UIReloader.h"
#import "EDOExporter.h"

@implementation UIReloader

+ (void)load {
    EDO_EXPORT_CLASS(@"UIReload", nil);
    EDO_EXPORT_CLASS(@"UIReloader", nil);
    EDO_EXPORT_GLOBAL_SCRIPT(@"(function(){var __extends=this&&this.__extends||function(){var extendStatics=function(d,b){extendStatics=Object.setPrototypeOf||{__proto__:[]}instanceof Array&&function(d,b){d.__proto__=b}||function(d,b){for(var p in b)if(b.hasOwnProperty(p))d[p]=b[p]};return extendStatics(d,b)};return function(d,b){extendStatics(d,b);function __(){this.constructor=d}d.prototype=b===null?Object.create(b):(__.prototype=b.prototype,new __)}}();UIReloader=function(){function UIReloader(){this.items={};this.instances={}}UIReloader.shared=new UIReloader;return UIReloader}();UIReload=function(reloadIdentifier,reloadCallback){return function(constructor){if(UIReloader.shared.items[reloadIdentifier]!==undefined){var reloadingItem=UIReloader.shared.items[reloadIdentifier];if(reloadingItem){var oldTarget=reloadingItem.clazz;var newTarget=arguments[0].prototype;for(var key in newTarget){if(newTarget.hasOwnProperty(key)){oldTarget[key]=newTarget[key]}}}if(UIReloader.shared.instances[reloadIdentifier]){UIReloader.shared.instances[reloadIdentifier].forEach(function(it){return reloadCallback(it)})}}else{var rootItem={clazz:arguments[0].prototype,superItem:undefined};var currentItem=rootItem;var current=arguments[0].prototype;while(current!==undefined&&current!==null&&current.__proto__!==undefined&&currentItem!==undefined){currentItem.superItem={clazz:current.__proto__,superItem:undefined};current=current.__proto__;currentItem=currentItem.superItem}UIReloader.shared.items[reloadIdentifier]=rootItem}return function(_super){__extends(class_1,_super);function class_1(){var rest=[];for(var _i=0;_i<arguments.length;_i++){rest[_i]=arguments[_i]}var _this=_super.apply(this,rest)||this;if(UIReloader.shared.instances[reloadIdentifier]===undefined){UIReloader.shared.instances[reloadIdentifier]=[]}UIReloader.shared.instances[reloadIdentifier].push(_this);return _this}return class_1}(constructor)}}})();");
}

@end
