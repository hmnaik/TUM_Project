package de.tum.in.far.threedui.ex2;

import javax.media.j3d.Appearance;
import javax.media.j3d.Transform3D;
import com.sun.j3d.utils.geometry.*;
import javax.vecmath.Vector3d;

import de.tum.in.far.threedui.general.TransformableObject;

public class CubeObject extends TransformableObject {
	
	
	private Box box;
	
	public CubeObject(Appearance app) {
		//Sphere iAmASphereButIllBeABoxSoon = new Sphere(0.005f, app);
		box = new Box(0.023f,0.023f,0.023f,app);
		
		
		Transform3D BoxTransform = new Transform3D();
		BoxTransform.setTranslation(new Vector3d(0.0f,0.0f,0.023f));
		
		transGroup.setTransform(BoxTransform);
		transGroup.addChild(box);
		
		
		
		
	}

	
	
}
