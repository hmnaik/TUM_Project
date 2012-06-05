package de.tum.in.far.threedui.ex3;

import javax.media.j3d.Appearance;
import javax.media.j3d.Transform3D;
import javax.vecmath.Vector3d;

import com.sun.j3d.utils.geometry.*;

import de.tum.in.far.threedui.general.TransformableObject;

public class CylinderObject extends TransformableObject{
	
	private Cylinder button;
	
	public CylinderObject(float r, float h, Appearance app) {
		
		button = new Cylinder(r, h, app);
		
		
		Transform3D BoxTransform = new Transform3D();
		BoxTransform.setTranslation(new Vector3d(0.0f,0.0f,0.023f));
		
		transGroup.setTransform(BoxTransform);
		transGroup.addChild(button);
	

	}	
	
}