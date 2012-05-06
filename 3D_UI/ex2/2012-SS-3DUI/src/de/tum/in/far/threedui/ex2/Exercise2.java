package de.tum.in.far.threedui.ex2;

import java.io.File;
import java.io.FileNotFoundException;

import org.jdesktop.j3d.loaders.vrml97.VrmlLoader;

import com.sun.j3d.loaders.IncorrectFormatException;
import com.sun.j3d.loaders.ParsingErrorException;
import com.sun.j3d.loaders.Scene;

import de.tum.in.far.threedui.general.BackgroundObject;
import de.tum.in.far.threedui.general.BinaryEnv;
import de.tum.in.far.threedui.general.BlueAppearance;
import de.tum.in.far.threedui.general.ImageReceiver;
import de.tum.in.far.threedui.general.ModelObject;
import de.tum.in.far.threedui.general.PoseReceiver;
import de.tum.in.far.threedui.general.UbitrackFacade;
import de.tum.in.far.threedui.general.ViewerUbitrack;

/* Changed the Highgui driver used for the camera to 2011_Markertracker_Direct in Ubitrack
 * facade class*/
//Also, Changed flip_Y boolean in ImageReceiver.java  


public class Exercise2 {

	public static final String EXERCISE = "Exercise 2";
	
	static {
		BinaryEnv.init();
	}
		
	private ViewerUbitrack viewer;
	private UbitrackFacade ubitrackFacade;

	private CubeObject cubeObject;
	private ModelObject sheepObject;
	
	private PoseReceiver poseReceiver;
	private ImageReceiver imageReceiver;
		
	public Exercise2() {
		ubitrackFacade = new UbitrackFacade();
	}

	public static void main(String[] args) {
		Exercise2 exercise2 = new Exercise2();
		exercise2.initializeJava3D();
		exercise2.loadSheep();
		exercise2.initializeUbitrack();
	}
	
	private void initializeUbitrack() {
		

		ubitrackFacade.initUbitrack();
		
		poseReceiver = new PoseReceiver();
		if (!ubitrackFacade.setPoseCallback("posesink", poseReceiver)) {
			return;
		}
		imageReceiver = new ImageReceiver();
		if (!ubitrackFacade.setImageCallback("imgsink", imageReceiver)) {
			return;
		}
		
		BackgroundObject backgroundObject = new BackgroundObject();
		viewer.addObject(backgroundObject);
		imageReceiver.setBackground(backgroundObject.getBackground());
		
		poseReceiver.setTransformGroup(cubeObject.getTransformGroup());

		ubitrackFacade.startDataflow();
	}
		
	private void loadSheep() {
		VrmlLoader loader = new VrmlLoader();
		Scene myScene = null;
		try {
			myScene = loader.load( "models" + File.separator + "Sheep.wrl");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IncorrectFormatException e) {
			e.printStackTrace();
		} catch (ParsingErrorException e) {
			e.printStackTrace();
		}

		// Maybe some transformation here
		
		sheepObject = new ModelObject(myScene.getSceneGroup());
		viewer.addObject(sheepObject);
	}
	
	private void initializeJava3D() {
		System.out.println("Creating Viewer - " + EXERCISE);
		viewer = new ViewerUbitrack(EXERCISE, ubitrackFacade);

		BlueAppearance blueAppearance = new BlueAppearance();
		
		cubeObject = new CubeObject(blueAppearance);
		viewer.addObject(cubeObject);
		
		System.out.println("Done");
	}
	
	
}
