package de.tum.in.far.threedui.general;

import java.io.File;

import ubitrack.SimpleFacade;
import ubitrack.SimpleImageReceiver;
import ubitrack.SimplePoseReceiver;
import ubitrack.ubitrack;

public class UbitrackFacade {

	public final static String COMPONENT_DIRECTORY = System.getProperty("user.dir") + File.separator + "libs" + File.separator + "ubitrack" + File.separator + "bin" + File.separator + "ubitrack";
	public final static String DATAFLOW_PATH = System.getProperty("user.dir") + File.separator + "dataflow" + File.separator + "3D-UI-SS-2011-Markertracker_Direct.dfg";// Changed HMN for using own webcam 	
	
	static {
		System.load(System.getProperty("user.dir") + File.separator + "libs" + File.separator + "ubitrack" + File.separator + "bin" + File.separator + "msvcr100.dll");
		System.load(System.getProperty("user.dir") + File.separator + "libs" + File.separator + "ubitrack" + File.separator + "bin" + File.separator + "msvcp100.dll");
		System.load(System.getProperty("user.dir") + File.separator + "libs" + File.separator + "ubitrack" + File.separator + "bin" + File.separator + "log4cpp.dll");
		System.load(System.getProperty("user.dir") + File.separator + "libs" + File.separator + "ubitrack" + File.separator + "bin" + File.separator + "ubitrack.dll");
		System.load(System.getProperty("user.dir") + File.separator + "libs" + File.separator + "ubitrack" + File.separator + "bin" + File.separator + "cxcore210.dll");
		System.load(System.getProperty("user.dir") + File.separator + "libs" + File.separator + "ubitrack" + File.separator + "bin" + File.separator + "cv210.dll");
		System.load(System.getProperty("user.dir") + File.separator + "libs" + File.separator + "ubitrack" + File.separator + "bin" + File.separator + "highgui210.dll");
		System.load(System.getProperty("user.dir") + File.separator + "libs" + File.separator + "ubitrack" + File.separator + "bin" + File.separator + "utvision.dll");
		System.load(System.getProperty("user.dir") + File.separator + "libs" + File.separator + "ubitrack" + File.separator + "bin" + File.separator + "freeglut.dll");
		System.load(System.getProperty("user.dir") + File.separator + "libs" + File.separator + "ubitrack" + File.separator + "bin" + File.separator + "ubitrack_java.dll");
	}

	private SimpleFacade facade;

	public void initUbitrack() {
		ubitrack.initLogging();
		
		facade = new SimpleFacade(COMPONENT_DIRECTORY);
		
		if (facade.getLastError() != null) {
			return;
		}
		if (!facade.loadDataflow(DATAFLOW_PATH)) {
			return;
		}
	}
	
	public boolean setPoseCallback(String name, SimplePoseReceiver poseReceiver){
		return facade.setPoseCallback(name, poseReceiver);
	}
	
	public boolean setImageCallback(String name, SimpleImageReceiver imageReceiver){
		return facade.setImageCallback(name, imageReceiver);
	}

	public void startDataflow(){
		facade.startDataflow();
	}
	public void stopUbitrack() {
		System.out.println("stopUbitrack");
		facade.stopDataflow();
		 
		// Garbage collection for cleanup of native Ubitrack stuff
		System.gc();
		System.runFinalization();
	}
	
}
