package com.kcly.ane.bitmapdataqrcodescanner.function;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.kcly.ane.bitmapdataqrcodescanner.ScannerExtensionContext;

public class StopFunction implements FREFunction {

	@Override
	public FREObject call(FREContext ctx, FREObject[] args) {

		FREObject retVal = null;
		ScannerExtensionContext extCtx = (ScannerExtensionContext)ctx;	
		
		try {
			
			if(extCtx.isLaunched()){
				extCtx.getActivity().finishActivity(100);
				retVal = FREObject.newObject(true);
			}else{
				retVal = FREObject.newObject(true);
			}
		} catch (Exception e) {
			return null;
		}
		return retVal;
	}

}
