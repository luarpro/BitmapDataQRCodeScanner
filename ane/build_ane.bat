::edit Flex SDK bin folder path
set FLEX_SDK=C:\Program Files (x86)\FlashDevelop\Tools\flexsdk

::do not edit below

@echo off
echo "build com.kcly.ane.bitmapdataqrcodescanner.ane..."
"%FLEX_SDK%\bin\adt.bat" -package -target ane com.kcly.ane.bitmapdataqrcodescanner.ane extension.xml -swc com.kcly.ane.bitmapdataqrcodescanner.swc -platform Android-ARM library.swf libBitmapDataQRCodeScanner.jar libs res -platform iPhone-ARM library.swf libBitmapDataQRCodeScanner.a platform.xml
echo "Done!"