::edit Flex SDK bin folder path
set FLEX_SDK=C:\Program Files (x86)\FlashDevelop\Tools\flexsdk

::do not edit below

@echo off
echo "build com.kcly.ane.bitmapdataqrcodescanner.swc..."
"%FLEX_SDK%\bin\acompc.bat" -source-path src -include-sources src -optimize -swf-version=13 -output ..\ane\com.kcly.ane.bitmapdataqrcodescanner.swc
echo "Done!"