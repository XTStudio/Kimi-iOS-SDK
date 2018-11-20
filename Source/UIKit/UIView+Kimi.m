//
//  UIView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/15.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIView+Kimi.h"
#import "EDOExporter.h"
#import <objc/runtime.h>

@implementation UIView (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIView", nil);
    EDO_EXPORT_READONLY_PROPERTY(@"layer");
    EDO_EXPORT_METHOD(endEditing:);
    // Geometry
    EDO_EXPORT_PROPERTY(@"frame");
    EDO_EXPORT_PROPERTY(@"bounds");
    EDO_EXPORT_PROPERTY(@"center");
    EDO_EXPORT_PROPERTY(@"transform");
    EDO_EXPORT_PROPERTY(@"edo_touchAreaInsets");
    EDO_EXPORT_PROPERTY(@"edo_opaque");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [UIView class];
        SEL originalSelector = @selector(pointInside:withEvent:);
        SEL swizzledSelector = @selector(edo_pointInside:withEvent:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
    // Hierarchy
    EDO_EXPORT_PROPERTY(@"tag");
    EDO_EXPORT_READONLY_PROPERTY(@"superview");
    EDO_EXPORT_READONLY_PROPERTY(@"subviews");
    EDO_EXPORT_READONLY_PROPERTY(@"window");
    EDO_EXPORT_READONLY_PROPERTY(@"edo_viewController");
    EDO_EXPORT_METHOD(convertPoint:toView:)
    EDO_EXPORT_METHOD(convertPoint:fromView:)
    EDO_EXPORT_METHOD(convertRect:toView:)
    EDO_EXPORT_METHOD(convertRect:fromView:)
    EDO_EXPORT_METHOD(removeFromSuperview);
    EDO_EXPORT_METHOD(insertSubview:atIndex:);
    EDO_EXPORT_METHOD_ALIAS(exchangeSubviewAtIndex:withSubviewAtIndex:, @"exchangeSubview");
    EDO_EXPORT_METHOD(addSubview:);
    EDO_EXPORT_METHOD(insertSubview:belowSubview:);
    EDO_EXPORT_METHOD(insertSubview:aboveSubview:);
    EDO_EXPORT_METHOD(bringSubviewToFront:);
    EDO_EXPORT_METHOD(sendSubviewToBack:);
    EDO_EXPORT_METHOD(isDescendantOfView:);
    EDO_EXPORT_METHOD(viewWithTag:);
    // Delegates
    EDO_BIND_METHOD(didAddSubview:);
    EDO_BIND_METHOD(willRemoveSubview:);
    EDO_BIND_METHOD(willMoveToSuperview:);
    EDO_BIND_METHOD(didMoveToSuperview);
    EDO_EXPORT_METHOD(setNeedsLayout);
    EDO_EXPORT_METHOD(layoutIfNeeded);
    EDO_BIND_METHOD(layoutSubviews);
    // Rendering
    EDO_EXPORT_METHOD(setNeedsDisplay);
    EDO_EXPORT_PROPERTY(@"clipsToBounds");
    EDO_EXPORT_PROPERTY(@"backgroundColor");
    EDO_EXPORT_PROPERTY(@"alpha");
    EDO_EXPORT_PROPERTY(@"hidden");
    EDO_EXPORT_PROPERTY(@"contentMode");
    EDO_EXPORT_PROPERTY(@"tintColor");
    EDO_BIND_METHOD(tintColorDidChange);
    // GestureRecognizers
    EDO_EXPORT_PROPERTY(@"userInteractionEnabled");
    EDO_EXPORT_PROPERTY(@"gestureRecognizers");
    EDO_EXPORT_METHOD(addGestureRecognizer:);
    EDO_EXPORT_METHOD(removeGestureRecognizer:);
    // Accessibility
    EDO_EXPORT_PROPERTY(@"isAccessibilityElement");
    EDO_EXPORT_PROPERTY(@"accessibilityLabel");
    EDO_EXPORT_PROPERTY(@"accessibilityHint");
    EDO_EXPORT_PROPERTY(@"accessibilityValue");
    EDO_EXPORT_PROPERTY(@"accessibilityIdentifier");
    [[EDOExporter sharedExporter] exportEnum:@"UIViewContentMode"
                                      values:@{
                                               @"scaleToFill": @(UIViewContentModeScaleToFill),
                                               @"scaleAspectFit": @(UIViewContentModeScaleAspectFit),
                                               @"scaleAspectFill": @(UIViewContentModeScaleAspectFill),
                                               }];
    [[EDOExporter sharedExporter] exportScriptToJavaScript:[UIView class]
                                                    script:@"var UIRectZero={x:0,y:0,width:0,height:0};var UIRectMake=function(x,y,width,height){return{x:x,y:y,width:width,height:height}};var UIRectEqualToRect=function(a,b){return Math.abs(a.x-b.x)<.001&&Math.abs(a.y-b.y)<.001&&Math.abs(a.width-b.width)<.001&&Math.abs(a.height-b.height)<.001};var UIRectInset=function(rect,dx,dy){return{x:rect.x+dx,y:rect.y+dy,width:rect.width-2*dx,height:rect.height-2*dy}};var UIRectOffset=function(rect,dx,dy){return{x:rect.x+dx,y:rect.y+dy,width:rect.width,height:rect.height}};var UIRectContainsPoint=function(rect,point){return point.x>=rect.x&&point.x<=rect.x+rect.width&&point.y>=rect.y&&point.y<=rect.x+rect.height};var UIRectContainsRect=function(rect1,rect2){return UIRectContainsPoint(rect1,{x:rect2.x,y:rect2.y})&&UIRectContainsPoint(rect1,{x:rect2.x+rect2.width,y:rect2.y})&&UIRectContainsPoint(rect1,{x:rect2.x,y:rect2.y+rect2.height})&&UIRectContainsPoint(rect1,{x:rect2.x+rect2.width,y:rect2.y+rect2.height})};var UIRectIntersectsRect=function(a,b){if(a.x+a.width-.1<=b.x||b.x+b.width-.1<=a.x||a.y+a.height-.1<=b.y||b.y+b.height-.1<=a.y){return false}return true};var UIRectUnion=function(r1,r2){var x=Math.min(r1.x,r2.x);var y=Math.min(r1.y,r2.y);var width=Math.max(r1.x+r1.width,r2.x+r2.width);var height=Math.max(r1.y+r1.height,r2.y+r2.height);return{x:x,y:y,width:width,height:height}};var UIRectIsEmpty=function(rect){returnrect.width==0||rect.height==0};var UIPointZero={x:0,y:0};var UIPointMake=function(x,y){return{x:x,y:y}};var UIPointEqualToPoint=function(point1,point2){return Math.abs(point1.x-point2.x)<.001&&Math.abs(point1.y-point2.y)<.001};var UISizeZero={width:0,height:0};var UISizeMake=function(width,height){return{width:width,height:height}};var UISizeEqualToSize=function(a,b){return Math.abs(a.width-b.width)<.001&&Math.abs(a.height-b.height)<.001};var MatrixAlgorithm=function(){function MatrixAlgorithm(){this.props=[];this.props[0]=1;this.props[1]=0;this.props[2]=0;this.props[3]=0;this.props[4]=0;this.props[5]=1;this.props[6]=0;this.props[7]=0;this.props[8]=0;this.props[9]=0;this.props[10]=1;this.props[11]=0;this.props[12]=0;this.props[13]=0;this.props[14]=0;this.props[15]=1}MatrixAlgorithm.prototype.rotate=function(angle){if(angle===0){return this}var mCos=Math.cos(angle);var mSin=Math.sin(angle);return this._t(mCos,-mSin,0,0,mSin,mCos,0,0,0,0,1,0,0,0,0,1)};MatrixAlgorithm.prototype.rotateX=function(angle){if(angle===0){return this}var mCos=Math.cos(angle);var mSin=Math.sin(angle);return this._t(1,0,0,0,0,mCos,-mSin,0,0,mSin,mCos,0,0,0,0,1)};MatrixAlgorithm.prototype.rotateY=function(angle){if(angle===0){return this}var mCos=Math.cos(angle);var mSin=Math.sin(angle);return this._t(mCos,0,mSin,0,0,1,0,0,-mSin,0,mCos,0,0,0,0,1)};MatrixAlgorithm.prototype.rotateZ=function(angle){if(angle===0){return this}var mCos=Math.cos(angle);var mSin=Math.sin(angle);return this._t(mCos,-mSin,0,0,mSin,mCos,0,0,0,0,1,0,0,0,0,1)};MatrixAlgorithm.prototype.shear=function(sx,sy){return this._t(1,sy,sx,1,0,0)};MatrixAlgorithm.prototype.skew=function(ax,ay){return this.shear(Math.tan(ax),Math.tan(ay))};MatrixAlgorithm.prototype.skewFromAxis=function(ax,angle){var mCos=Math.cos(angle);var mSin=Math.sin(angle);return this._t(mCos,mSin,0,0,-mSin,mCos,0,0,0,0,1,0,0,0,0,1);this._t(1,0,0,0,Math.tan(ax),1,0,0,0,0,1,0,0,0,0,1);this._t(mCos,-mSin,0,0,mSin,mCos,0,0,0,0,1,0,0,0,0,1)};MatrixAlgorithm.prototype.scale=function(sx,sy,sz){sz=isNaN(sz)?1:sz;if(sx==1&&sy==1&&sz==1){return this}return this._t(sx,0,0,0,0,sy,0,0,0,0,sz,0,0,0,0,1)};MatrixAlgorithm.prototype.setTransform=function(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p){this.props[0]=a;this.props[1]=b;this.props[2]=c;this.props[3]=d;this.props[4]=e;this.props[5]=f;this.props[6]=g;this.props[7]=h;this.props[8]=i;this.props[9]=j;this.props[10]=k;this.props[11]=l;this.props[12]=m;this.props[13]=n;this.props[14]=o;this.props[15]=p;return this};MatrixAlgorithm.prototype.translate=function(tx,ty,tz){tz=isNaN(tz)?0:tz;if(tx!==0||ty!==0||tz!==0){return this._t(1,0,0,0,0,1,0,0,0,0,1,0,tx,ty,tz,1)}return this};MatrixAlgorithm.prototype._t=function(a2,b2,c2,d2,e2,f2,g2,h2,i2,j2,k2,l2,m2,n2,o2,p2){this.transform(a2,b2,c2,d2,e2,f2,g2,h2,i2,j2,k2,l2,m2,n2,o2,p2)};MatrixAlgorithm.prototype.transform=function(a2,b2,c2,d2,e2,f2,g2,h2,i2,j2,k2,l2,m2,n2,o2,p2){if(a2===1&&b2===0&&c2===0&&d2===0&&e2===0&&f2===1&&g2===0&&h2===0&&i2===0&&j2===0&&k2===1&&l2===0){if(m2!==0||n2!==0||o2!==0){this.props[12]=this.props[12]*a2+this.props[13]*e2+this.props[14]*i2+this.props[15]*m2;this.props[13]=this.props[12]*b2+this.props[13]*f2+this.props[14]*j2+this.props[15]*n2;this.props[14]=this.props[12]*c2+this.props[13]*g2+this.props[14]*k2+this.props[15]*o2;this.props[15]=this.props[12]*d2+this.props[13]*h2+this.props[14]*l2+this.props[15]*p2}return this}var a1=this.props[0];var b1=this.props[1];var c1=this.props[2];var d1=this.props[3];var e1=this.props[4];var f1=this.props[5];var g1=this.props[6];var h1=this.props[7];var i1=this.props[8];var j1=this.props[9];var k1=this.props[10];var l1=this.props[11];var m1=this.props[12];var n1=this.props[13];var o1=this.props[14];var p1=this.props[15];this.props[0]=a1*a2+b1*e2+c1*i2+d1*m2;this.props[1]=a1*b2+b1*f2+c1*j2+d1*n2;this.props[2]=a1*c2+b1*g2+c1*k2+d1*o2;this.props[3]=a1*d2+b1*h2+c1*l2+d1*p2;this.props[4]=e1*a2+f1*e2+g1*i2+h1*m2;this.props[5]=e1*b2+f1*f2+g1*j2+h1*n2;this.props[6]=e1*c2+f1*g2+g1*k2+h1*o2;this.props[7]=e1*d2+f1*h2+g1*l2+h1*p2;this.props[8]=i1*a2+j1*e2+k1*i2+l1*m2;this.props[9]=i1*b2+j1*f2+k1*j2+l1*n2;this.props[10]=i1*c2+j1*g2+k1*k2+l1*o2;this.props[11]=i1*d2+j1*h2+k1*l2+l1*p2;this.props[12]=m1*a2+n1*e2+o1*i2+p1*m2;this.props[13]=m1*b2+n1*f2+o1*j2+p1*n2;this.props[14]=m1*c2+n1*g2+o1*k2+p1*o2;this.props[15]=m1*d2+n1*h2+o1*l2+p1*p2;return this};MatrixAlgorithm.prototype.clone=function(matr){var i;for(i=0;i<16;i+=1){matr.props[i]=this.props[i]}};MatrixAlgorithm.prototype.cloneFromProps=function(props){var i;for(i=0;i<16;i+=1){this.props[i]=props[i]}};MatrixAlgorithm.prototype.applyToPoint=function(x,y,z){return{x:x*this.props[0]+y*this.props[4]+z*this.props[8]+this.props[12],y:x*this.props[1]+y*this.props[5]+z*this.props[9]+this.props[13],z:x*this.props[2]+y*this.props[6]+z*this.props[10]+this.props[14]}};MatrixAlgorithm.prototype.applyToX=function(x,y,z){return x*this.props[0]+y*this.props[4]+z*this.props[8]+this.props[12]};MatrixAlgorithm.prototype.applyToY=function(x,y,z){return x*this.props[1]+y*this.props[5]+z*this.props[9]+this.props[13]};MatrixAlgorithm.prototype.applyToZ=function(x,y,z){return x*this.props[2]+y*this.props[6]+z*this.props[10]+this.props[14]};MatrixAlgorithm.prototype.applyToPointArray=function(x,y,z){return[x*this.props[0]+y*this.props[4]+z*this.props[8]+this.props[12],x*this.props[1]+y*this.props[5]+z*this.props[9]+this.props[13],x*this.props[2]+y*this.props[6]+z*this.props[10]+this.props[14]]};MatrixAlgorithm.prototype.applyToPointStringified=function(x,y){return Math.round(x*this.props[0]+y*this.props[4]+this.props[12])+\",\"+Math.round(x*this.props[1]+y*this.props[5]+this.props[13])};return MatrixAlgorithm}();var Matrix=function(){function Matrix(a,b,c,d,tx,ty){if(a===void 0){a=1}if(b===void 0){b=0}if(c===void 0){c=0}if(d===void 0){d=1}if(tx===void 0){tx=0}if(ty===void 0){ty=0}this.a=a;this.b=b;this.c=c;this.d=d;this.tx=tx;this.ty=ty}Matrix.unmatrix=function(matrix){var A=matrix.a;var B=matrix.b;var C=matrix.c;var D=matrix.d;if(A*D==B*C){return{scale:{x:1,y:1},degree:0,translate:{x:0,y:0}}}var scaleX=Math.sqrt(A*A+B*B);A/=scaleX;B/=scaleX;var skew=A*C+B*D;C-=A*skew;D-=B*skew;var scaleY=Math.sqrt(C*C+D*D);C/=scaleY;D/=scaleY;skew/=scaleY;if(A*D<B*C){A=-A;B=-B;skew=-skew;scaleX=-scaleX}return{scale:{x:scaleX,y:scaleY},degree:Math.atan2(B,A)/(Math.PI/180),translate:{x:matrix.tx,y:matrix.ty}}};Matrix.prototype.setValues=function(values){this.a=values.a;this.b=values.b;this.c=values.c;this.d=values.d;this.tx=values.tx;this.ty=values.ty};Matrix.prototype.getValues=function(){return{a:this.a,b:this.b,c:this.c,d:this.d,tx:this.tx,ty:this.ty}};Matrix.prototype.isIdentity=function(){return this.a==1&&this.b==0&&this.c==0&&this.d==1&&this.tx==0&&this.ty==0};Matrix.prototype.setScale=function(x,y){var obj=new MatrixAlgorithm;var unMatrix=Matrix.unmatrix(this);obj.rotate(-(unMatrix.degree*Math.PI/180));obj.scale(x||unMatrix.scale.x,y||unMatrix.scale.y,1);obj.translate(unMatrix.translate.x,unMatrix.translate.y,0);this.a=obj.props[0];this.b=obj.props[1];this.c=obj.props[4];this.d=obj.props[5];this.tx=obj.props[12];this.ty=obj.props[13]};Matrix.prototype.postScale=function(x,y){var obj=new MatrixAlgorithm;var unMatrix=Matrix.unmatrix(this);obj.rotate(-(unMatrix.degree*Math.PI/180));obj.scale(unMatrix.scale.x,unMatrix.scale.y,1);obj.translate(unMatrix.translate.x,unMatrix.translate.y,0);obj.scale(x||1,y||1,1);this.a=obj.props[0];this.b=obj.props[1];this.c=obj.props[4];this.d=obj.props[5];this.tx=obj.props[12];this.ty=obj.props[13]};Matrix.prototype.setTranslate=function(x,y){var obj=new MatrixAlgorithm;var unMatrix=Matrix.unmatrix(this);obj.rotate(-(unMatrix.degree*Math.PI/180));obj.scale(unMatrix.scale.x,unMatrix.scale.y,1);obj.translate(x||unMatrix.translate.x,y||unMatrix.translate.y,0);this.a=obj.props[0];this.b=obj.props[1];this.c=obj.props[4];this.d=obj.props[5];this.tx=obj.props[12];this.ty=obj.props[13]};Matrix.prototype.postTranslate=function(x,y){var obj=new MatrixAlgorithm;var unMatrix=Matrix.unmatrix(this);obj.rotate(-(unMatrix.degree*Math.PI/180));obj.scale(unMatrix.scale.x,unMatrix.scale.y,1);obj.translate(unMatrix.translate.x,unMatrix.translate.y,0);obj.translate(x||0,y||0,0);this.a=obj.props[0];this.b=obj.props[1];this.c=obj.props[4];this.d=obj.props[5];this.tx=obj.props[12];this.ty=obj.props[13]};Matrix.prototype.setRotate=function(angle){var obj=new MatrixAlgorithm;var unMatrix=Matrix.unmatrix(this);obj.rotate(-angle||-(unMatrix.degree*Math.PI/180));obj.scale(unMatrix.scale.x,unMatrix.scale.y,1);obj.translate(unMatrix.translate.x,unMatrix.translate.y,0);this.a=obj.props[0];this.b=obj.props[1];this.c=obj.props[4];this.d=obj.props[5];this.tx=obj.props[12];this.ty=obj.props[13]};Matrix.prototype.postRotate=function(angle){var obj=new MatrixAlgorithm;var unMatrix=Matrix.unmatrix(this);obj.rotate(-(unMatrix.degree*Math.PI/180));obj.scale(unMatrix.scale.x,unMatrix.scale.y,1);obj.translate(unMatrix.translate.x,unMatrix.translate.y,0);obj.rotate(-angle);this.a=obj.props[0];this.b=obj.props[1];this.c=obj.props[4];this.d=obj.props[5];this.tx=obj.props[12];this.ty=obj.props[13]};Matrix.prototype.preConcat=function(preMatrix){var obj=new MatrixAlgorithm;obj.props[0]=preMatrix.a;obj.props[1]=preMatrix.b;obj.props[4]=preMatrix.c;obj.props[5]=preMatrix.d;obj.props[12]=preMatrix.tx;obj.props[13]=preMatrix.ty;obj.transform(this.a,this.b,0,0,this.c,this.d,0,0,0,0,1,0,this.tx,this.ty,0,1);this.a=obj.props[0];this.b=obj.props[1];this.c=obj.props[4];this.d=obj.props[5];this.tx=obj.props[12];this.ty=obj.props[13]};Matrix.prototype.concat=function(postMatrix){var obj=new MatrixAlgorithm;obj.props[0]=this.a;obj.props[1]=this.b;obj.props[4]=this.c;obj.props[5]=this.d;obj.props[12]=this.tx;obj.props[13]=this.ty;obj.transform(postMatrix.a,postMatrix.b,0,0,postMatrix.c,postMatrix.d,0,0,0,0,1,0,postMatrix.tx,postMatrix.ty,0,1);this.a=obj.props[0];this.b=obj.props[1];this.c=obj.props[4];this.d=obj.props[5];this.tx=obj.props[12];this.ty=obj.props[13]};return Matrix}();var UIAffineTransformIdentity={a:1,b:0,c:0,d:1,tx:0,ty:0};var UIAffineTransformMake=function(a,b,c,d,tx,ty){return{a:a,b:b,c:c,d:d,tx:tx,ty:ty}};var UIAffineTransformMakeTranslation=function(tx,ty){return UIAffineTransformMake(1,0,0,1,tx,ty)};var UIAffineTransformMakeScale=function(sx,sy){return UIAffineTransformMake(sx,0,0,sy,0,0)};var UIAffineTransformMakeRotation=function(angle){var mCos=Math.cos(angle);var mSin=Math.sin(angle);return UIAffineTransformMake(mCos,-mSin,mSin,mCos,0,0)};var UIAffineTransformTranslate=function(t,tx,ty){var matrix=new Matrix;matrix.setValues(t);matrix.postTranslate(tx,ty);return matrix.getValues()};var UIAffineTransformScale=function(t,sx,sy){var matrix=new Matrix;matrix.setValues(t);matrix.postScale(sx,sx);return matrix.getValues()};var UIAffineTransformRotate=function(t,angle){var matrix=new Matrix;matrix.setValues(t);matrix.postRotate(angle);return matrix.getValues()};var UIAffineTransformInvert=function(t){return{a:t.a,b:t.c,c:t.b,d:t.d,tx:t.tx,ty:t.ty}};var UIAffineTransformConcat=function(t1,t2){var matrix1=new Matrix;matrix1.setValues(t1);var matrix2=new Matrix;matrix2.setValues(t2);matrix1.concat(matrix2);return matrix1.getValues()};var UIAffineTransformEqualToTransform=function(t1,t2){return Math.abs(t1.a-t2.a)<.001&&Math.abs(t1.b-t2.b)<.001&&Math.abs(t1.c-t2.c)<.001&&Math.abs(t1.d-t2.d)<.001&&Math.abs(t1.tx-t2.tx)<.001&&Math.abs(t1.ty-t2.ty)<.001};var UIAffineTransformIsIdentity=function(transform){return UIAffineTransformEqualToTransform(transform,UIAffineTransformIdentity)};var UIEdgeInsetsZero={top:0,left:0,bottom:0,right:0};var UIEdgeInsetsMake=function(top,left,bottom,right){return{top:top,left:left,bottom:bottom,right:right}};var UIEdgeInsetsInsetRect=function(rect,insets){return{x:rect.x+insets.left,y:rect.y+insets.top,width:rect.width-insets.left-insets.right,height:rect.height-insets.top-insets.bottom}};var UIEdgeInsetsEqualToEdgeInsets=function(rect1,rect2){return Math.abs(rect1.top-rect2.top)<.001&&Math.abs(rect1.left-rect2.left)<.001&&Math.abs(rect1.bottom-rect2.bottom)<.001&&Math.abs(rect1.right-rect2.right)<.001};var UIRangeMake=function(location,length){return{location:location,length:length}};"
                                             isInnerScript:NO];
}

- (BOOL)edo_opaque {
    return self.isOpaque;
}

- (void)setEdo_opaque:(BOOL)opaque {
    [self setOpaque:opaque];
}

static int kTouchAreaInsetsKey;

- (UIEdgeInsets)edo_touchAreaInsets {
    return [objc_getAssociatedObject(self, &kTouchAreaInsetsKey) UIEdgeInsetsValue];
}

- (void)setEdo_touchAreaInsets:(UIEdgeInsets)edo_touchAreaInsets {
    objc_setAssociatedObject(self, &kTouchAreaInsetsKey, [NSValue valueWithUIEdgeInsets:edo_touchAreaInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)edo_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (objc_getAssociatedObject(self, &kTouchAreaInsetsKey) != nil) {
        UIEdgeInsets touchAreaInsets = self.edo_touchAreaInsets;
        return CGRectContainsPoint(CGRectMake(0.0 - touchAreaInsets.left,
                                              0.0 - touchAreaInsets.top,
                                              self.bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
                                              self.bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom),
                                   point);
    }
    return [self edo_pointInside:point withEvent:event];
}

- (UIViewController *)edo_viewController {
    id next = [self nextResponder];
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return next;
        }
        next = [next nextResponder];
    }
    return nil;
}

@end
