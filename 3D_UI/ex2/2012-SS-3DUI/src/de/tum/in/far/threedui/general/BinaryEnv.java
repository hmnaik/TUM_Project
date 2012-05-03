package de.tum.in.far.threedui.general;

import java.io.File;
import java.lang.reflect.Field;

public class BinaryEnv {

	static {
		// Extend java.library.path so that it is able to find the Java3D libs
		String j3dLibPath = System.getProperty("user.dir");
		boolean init = false;
		if (System.getProperty("os.name").indexOf("Windows") > -1) {
			j3dLibPath =  j3dLibPath + File.separator + "libs" + File.separator + "bin";
			System.out.println("Extending LIB path: " + j3dLibPath);
			init = true;
		} else {
			String msg = "Your OS does currently not support automatic loading of Java3D libraries.\n";
			msg += "Currently only Windows libs are integrated into this feature.\n";
			msg += "If you run Windows, there's a bug to be fixed.\n";
			msg += "Please either fix that bug, extend your OS or manually extend the java.library.path\n";
			msg += "to point to the folder containing the Java3D libraries.";
			System.out.println(msg);
		}
		
		if (init) {
			addJavaLibraryPath(j3dLibPath);
		}
	}
	
	private static void addJavaLibraryPath(String j3dLibPath) {
		try {
	        // Although it is not well documented, the java.library.path system property
			// is a "read-only" property as far as the System.loadLibrary() method is concerned.
			// This is a reported bug but it was closed by Sun as opposed to getting fixed.
			// The problem is that the JVM's ClassLoader reads this property once at startup and
			// then caches it, not allowing us to change it programatically afterward.
			// The line System.setProperty("java.library.path", anyVal); will have no effect 
			// except for System.getProperty() method calls.

			// This enables the java.library.path to be modified at runtime
	        // From a Sun engineer at http://forums.sun.com/thread.jspa?threadID=707176
			
	        Field field = ClassLoader.class.getDeclaredField("usr_paths");
	        field.setAccessible(true);
	        String[] paths = (String[])field.get(null);
	        for (int i = 0; i < paths.length; i++) {
	            if (j3dLibPath.equals(paths[i])) {
	                return;
	            }
	        }
	        String[] tmp = new String[paths.length+1];
	        System.arraycopy(paths,0,tmp,0,paths.length);
	        tmp[paths.length] = j3dLibPath;
	        field.set(null,tmp);
	        System.setProperty("java.library.path", System.getProperty("java.library.path") + File.pathSeparator + j3dLibPath);
	    } catch (IllegalAccessException e) {
	        System.out.println("Failed to get permissions to set library path.");
	    } catch (NoSuchFieldException e) {
	    	System.out.println("Failed to get field handle to set library path.");
	    }
	}
	
	public static void init() {
		// This mothod does nothing. It only would be necessary to declare the class so that it is loaded.
		// Then the static block is executed. To ensure that the class is loaded and this static block is executed
		// in all Exercise classes we call init(). 
	}
}
