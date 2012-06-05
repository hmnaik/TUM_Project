package de.tum.in.far.threedui.ex3;

import java.io.File;
import java.io.FileNotFoundException;

import javax.media.j3d.BranchGroup;
import javax.media.j3d.Transform3D;
import javax.media.j3d.TransformGroup;
import javax.vecmath.AxisAngle4d;
import javax.vecmath.AxisAngle4f;
import javax.vecmath.Vector3d;

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

public class Exercise3 {

	public static final String EXERCISE = "Exercise 3";
	
	static {
		BinaryEnv.init();
	}
		
	private ViewerUbitrack viewer;
	private UbitrackFacade ubitrackFacade;

	private ModelObject sheepObject;
	 
	private ModelObject buttonObject;
	//private ButtonObject buttonObject;
	
	private PoseReceiver poseReceiver;
	private PoseReceiver poseReceiver2;
	private ImageReceiver imageReceiver;

		
	public Exercise3() {
		ubitrackFacade = new UbitrackFacade();
	}

	public static void main(String[] args) {
		Exercise3 exercise3 = new Exercise3();
		exercise3.initializeJava3D();
		exercise3.loadSheep();
		exercise3.loadButton();
		exercise3.initializeUbitrack();
	}
	
	private void initializeUbitrack() {
		
		ubitrackFacade.initUbitrack();
		
		poseReceiver = new PoseReceiver();
		if (!ubitrackFacade.setPoseCallback("posesink", poseReceiver)) {
			return;
		}
		
		poseReceiver2 = new PoseReceiver();
		if (!ubitrackFacade.setPoseCallback("posesink4", poseReceiver2)) {
			return;
		}
		
		imageReceiver = new ImageReceiver();
		if (!ubitrackFacade.setImageCallback("imgsink", imageReceiver)) {
			return;
		}
		
		BackgroundObject backgroundObject = new BackgroundObject();
		viewer.addObject(backgroundObject);
		imageReceiver.setBackground(backgroundObject.getBackground());
		
	
		poseReceiver.setTransformGroup(buttonObject.getTransformGroup());
		poseReceiver2.setTransformGroup(sheepObject.getTransformGroup());

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
		Transform3D sheepTrans = new Transform3D(); 
		
		sheepTrans.setTranslation(new Vector3d(0f,0.0f,0.023f));
		sheepTrans.setRotation(new AxisAngle4d(1,0,0,Math.toRadians(90)));
		
		BranchGroup Sheepy = new BranchGroup();
		TransformGroup T3d = new TransformGroup();
		T3d.setTransform(sheepTrans);
		T3d.addChild(myScene.getSceneGroup()); 
		
		
		Sheepy.addChild(T3d);
			
		sheepObject = new ModelObject(Sheepy);
		
		// sheepObject.getTransformGroup().setTransform(sheepTrans);
		
		viewer.addObject(sheepObject);
	}
	
	private void loadButton() {
		
		BlueAppearance blueAppearance = new BlueAppearance();
		CylinderObject button = new CylinderObject(0.023f, 0.03f, blueAppearance);
		
		
		Transform3D buttonT3D = new Transform3D();
	//	buttonT3D.setTranslation(new Vector3d(0f,0f,0.023f));
		buttonT3D.setRotation(new AxisAngle4d(1,0,0,Math.toRadians(90)));
		
		
		// Add transformation for rotation to the group 
		TransformGroup T3d = new TransformGroup();
		T3d.setTransform(buttonT3D);
		// Add button model to the TG
		T3d.addChild(button);
		
		// New BG to the TG
		BranchGroup bgButton = new BranchGroup();
		bgButton.addChild(T3d);
		
		// Create model object out of the Shape 
		buttonObject = new ModelObject(bgButton);
		
		viewer.addObject(buttonObject);
		
		
		
	}
	
	private void initializeJava3D() {
		System.out.println("Creating Viewer - " + EXERCISE);
		viewer = new ViewerUbitrack(EXERCISE, ubitrackFacade);

		
		System.out.println("Done");
	}
	
	
}
