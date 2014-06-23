package com.kcly.ane.bitmapdataqrcodescanner;

import java.util.HashMap;
import java.util.Map;

import net.sourceforge.zbar.Config;
import net.sourceforge.zbar.ImageScanner;
import net.sourceforge.zbar.Symbol;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.kcly.ane.bitmapdataqrcodescanner.function.ScanFunction;
import com.kcly.ane.bitmapdataqrcodescanner.function.StopFunction;

public class ScannerExtensionContext extends FREContext {

	// ZBar Objects
	ImageScanner scanner;
	private boolean launched = false;
	
	public static final String FRE_EXTENSION_CONTEXT = "com.kcly.ane.bitmapdataqrcodescanner.freContext"; 

	private static final ScannerExtensionContext INSTANCE = new ScannerExtensionContext();

	private ScannerExtensionContext() {
		this.resetScanner();
	}

	public static ScannerExtensionContext getInstance() {
		return INSTANCE;
	}

	@Override
	public void dispose() {
		scanner.destroy();
		scanner = null;
	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();

		functionMap.put("scan", new ScanFunction() );
		functionMap.put("stop", new StopFunction() );
		
		return functionMap;
	}

	private void resetScanner() {
		ImageScanner is = new ImageScanner();

		is.setConfig(0, Config.X_DENSITY, 1);
		is.setConfig(0, Config.Y_DENSITY, 1);
		is.setConfig(0, Config.ENABLE, 0);
		is.setConfig(Symbol.QRCODE, Config.ENABLE, 1);

		launched = true;
		scanner = is;
	}
	
	public boolean isLaunched() {
		return launched;
	}
	
	public ImageScanner getScanner() {
		return scanner;
	}
}
