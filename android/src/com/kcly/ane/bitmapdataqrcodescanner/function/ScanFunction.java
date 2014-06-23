package com.kcly.ane.bitmapdataqrcodescanner.function;

import android.graphics.*;
import android.graphics.Bitmap.Config;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREBitmapData;
import com.kcly.ane.bitmapdataqrcodescanner.ScannerExtensionContext;

import net.sourceforge.zbar.Image;
import net.sourceforge.zbar.ImageScanner;
import net.sourceforge.zbar.Symbol;
import net.sourceforge.zbar.SymbolSet;

public class ScanFunction implements FREFunction {

	@Override
	public FREObject call(FREContext ctx, FREObject[] args) {

		FREObject retVal;
		retVal = null;

		try {
			FREBitmapData inputValue = (FREBitmapData)args[0];
			inputValue.acquire();
			int width = inputValue.getWidth();
			int height = inputValue.getHeight();
			int[] pixels = new int[width * height];
			Bitmap bmp = Bitmap.createBitmap(width, height, Config.ARGB_8888);
			bmp.copyPixelsFromBuffer(inputValue.getBits());
			
			bmp.getPixels(pixels, 0, width, 0, 0, width, height);
            

			ImageScanner reader = ScannerExtensionContext.getInstance().getScanner();
			Image myImage = new Image(width, height, "RGB4");
			myImage.setData(pixels);
			int result = reader.scanImage(myImage.convert("Y800"));

			inputValue.release();
			
			if (result != 0) {
				SymbolSet syms = reader.getResults();
				for (Symbol sym : syms) {
					ScannerExtensionContext freContext = ScannerExtensionContext.getInstance();
					freContext.dispatchStatusEventAsync("data", sym.getData());
					return null;
				}
			}
		} catch (Exception e) {
			return null;
		}

		return retVal;
	}
}
