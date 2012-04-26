package de.tum.in.far.threedui.ex1;

import javax.media.j3d.Appearance;
import javax.media.j3d.BoundingSphere;
import javax.media.j3d.Material;
import javax.media.j3d.PointLight;
import javax.media.j3d.Transform3D;
import javax.media.j3d.TransformGroup;
import javax.vecmath.Color3f;
import javax.vecmath.Point3f;

import javax.vecmath.Vector3d;

import com.sun.j3d.utils.geometry.Box;


import de.tum.in.far.threedui.general.*; // Add all possible package of 3D UI class 

public class Exercise1 {

	public static final String EXERCISE = "Exercise 1";

	static {
		BinaryEnv.init();
		
	}
	
	public static void main(String[] args) {
		Exercise1 exercise1 = new Exercise1();
		exercise1.initializeJava3D();
	}
	
	private void initializeJava3D() {
		System.out.println("Creating Viewer - " + EXERCISE);
		Viewer viewer = new Viewer(EXERCISE);

		// The first sphere of Radius 0.1f
		System.out.println("Create Sphere Object");
		SphereObject sphereObject = new SphereObject(0.1f);
		
		System.out.println("Create shadow of Sphere Object");
		FakeShadow Shadow1 = new FakeShadow(sphereObject.getGeometry(), new Color3f(0,0,0) );
		sphereObject.addChild(Shadow1);
		
		// Create a floor now for the shadow 
		Color3f black = new Color3f(0.0f, 0.0f, 0.0f);
		Color3f blue = new Color3f(0.3f, 0.8f, 0.3f);
		Color3f Ambient = new Color3f(0.9f, 0.9f, 0.9f);
		
		// Ambient,emissive,diffuse,specular,shininess
		Material floor = new Material(blue, black, blue, Ambient,0.0f);
		
		Appearance app = new Appearance();
		app.setMaterial(floor);
		Box box = new Box(-1f,0.0f,5f,app);	
		sphereObject.addChild(box);
	
		viewer.addObject(sphereObject); // Add the sphere to the viewer 
	
		// Create tranformation group for the Blue Sphere 
		Transform3D sphereT3D = new Transform3D(); // Create transformation object
		sphereT3D.setTranslation(new Vector3d(0.0, 0.2, 0.0)); // Set transformation 
		sphereObject.getTransformGroup().setTransform(sphereT3D); 
		
		
		System.out.println("Move Camera backwards and a little bit up");
		Transform3D cameraTransform = new Transform3D();
		cameraTransform.setTranslation(new Vector3d(0.0, 0.15, 1.0));
		TransformGroup cameraTG = viewer.getCameraTransformGroup();
		cameraTG.setTransform(cameraTransform);
		
		System.out.println("Create Blue Sphere Object");
		BlueAppearance blueAppearance = new BlueAppearance();
		SphereObject blueSphereObject = new SphereObject(0.04f, blueAppearance);
		
		FakeShadow Shadow2 = new FakeShadow(blueSphereObject.getGeometry(), new Color3f(0,0,0) );
		
		PointLight pointLight = new PointLight();
		Point3f Position = new Point3f(0.2f,0.2f,0.0f);
		pointLight.setPosition(Position); 
		
		BoundingSphere boundingSphere = new BoundingSphere();
		boundingSphere.setRadius(40.0f);
		
		pointLight.setInfluencingBounds(boundingSphere);
		blueSphereObject.addChild(pointLight);
		
		blueSphereObject.getTransformGroup().addChild(Shadow2);
		
		Transform3D blueSphereT3D = new Transform3D();
		blueSphereT3D.setTranslation(new Vector3d(0.2, 0.2, 0.0));
		blueSphereObject.getTransformGroup().setTransform(blueSphereT3D);
		
		
		Transform3D T3D = new Transform3D();
		T3D.setTranslation(new Vector3d(0.0, -0.2, 0.0));
		Shadow2.getTransformGroup().setTransform(T3D);
		
		System.out.println("Animation");
		AnimationRotation animationRotation = new AnimationRotation(blueSphereObject);
		viewer.addObject(animationRotation);
		
		
		
		System.out.println("Done - Enjoy");
	}
	

}
