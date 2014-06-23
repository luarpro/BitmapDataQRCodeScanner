package com.kcly.ane.bitmapdataqrcodescanner;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class ScannerExtension implements FREExtension {

	@Override
	public FREContext createContext(String ctxType) {
		return ScannerExtensionContext.getInstance(); 
	}

	@Override
	public void dispose() {
		ScannerExtensionContext.getInstance().dispose();
	}

	@Override
	public void initialize() {
		// TODO Auto-generated method stub
	}
}
