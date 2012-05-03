package de.tum.in.far.threedui.ex2;

import javax.media.j3d.Appearance;

import com.sun.j3d.utils.geometry.Sphere;

import de.tum.in.far.threedui.general.TransformableObject;

public class CubeObject extends TransformableObject {
	
	public CubeObject(Appearance app) {
		Sphere iAmASphereButIllBeABoxSoon = new Sphere(0.005f, app);
		transGroup.addChild(iAmASphereButIllBeABoxSoon);
	}

	
}
