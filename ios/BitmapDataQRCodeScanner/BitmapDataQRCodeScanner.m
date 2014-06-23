#import "FlashRuntimeExtensions.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

FREObject scan(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    ZBarReaderController *reader = nil;
    FREGetContextNativeData(ctx, (void**)&reader);
    FREObject retVal = NULL;
    
    FREObject       objectBitmapData = argv[0];
    FREBitmapData2  bitmapData;
    
    FREAcquireBitmapData2(objectBitmapData, &bitmapData);
    
    int width       = bitmapData.width;
    int height      = bitmapData.height;

    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bitmapData.bits32, (width * height * 4), NULL);

    int                     bitsPerComponent    = 8;
    int                     bitsPerPixel        = 32;
    int                     bytesPerRow         = 4 * width;
    CGColorSpaceRef         colorSpaceRef       = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo            bitmapInfo;
    
    if( bitmapData.hasAlpha) {
        if(bitmapData.isPremultiplied)
            bitmapInfo = kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst;
        else
            bitmapInfo = kCGBitmapByteOrder32Little | kCGImageAlphaFirst;
    } else {
        bitmapInfo = kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipFirst;
    }
    
    CGColorRenderingIntent  renderingIntent     = kCGRenderingIntentDefault;
    CGImageRef              imageRef            = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);

    id <NSFastEnumeration> results = [reader scanImage:imageRef];
    
    ZBarSymbol *sym = nil;
    for(sym in results) {
        if (sym) {
            NSLog(@"Found barcode! quality: %d string: %@", sym.quality, sym.data);
            FREDispatchStatusEventAsync(ctx, (uint8_t*)[@"data" UTF8String], (uint8_t*)[sym.data UTF8String]);
            break;
        }
    }
    
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    FREReleaseBitmapData(objectBitmapData);
    
    FRENewObjectFromBool((uint32_t)YES, &retVal);
    return retVal;
}

FREObject stop(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    ZBarReaderController *reader = nil;
    FREGetContextNativeData(ctx, (void**)&reader);
    FREObject retVal = NULL;
    
    [reader release];
    reader = nil;
    FRENewObjectFromBool((uint32_t)YES, &retVal);
    
    return retVal;
}

void ScannerContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx,
						uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) {
    
    ZBarReaderController *reader = [ZBarReaderController new];
    reader.sourceType = UIImagePickerControllerSourceTypeCamera;
    [reader.scanner setSymbology: 0
                          config: ZBAR_CFG_ENABLE
                              to: 0];
    [reader.scanner setSymbology: ZBAR_QRCODE
                          config: ZBAR_CFG_ENABLE
                              to: 1];
    
    FRESetContextNativeData(ctx, reader);
    
	*numFunctionsToTest = 2;
    
	FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * 2);
    
    func[0].name = (const uint8_t*) "scan";
	func[0].functionData = NULL;
    func[0].function = &scan;
    
    func[1].name = (const uint8_t*) "stop";
	func[1].functionData = NULL;
    func[1].function = &stop;
    
	*functionsToSet = func;
}

void ScannerContextFinalizer(FREContext ctx) {
    return;
}

void ScannerExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet,
                    FREContextFinalizer* ctxFinalizerToSet) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &ScannerContextInitializer;
    *ctxFinalizerToSet = &ScannerContextFinalizer;
}

void ScannerExtFinalizer(void* extData) {
    return;
}