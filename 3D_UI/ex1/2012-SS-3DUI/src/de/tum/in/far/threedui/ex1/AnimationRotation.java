package de.tum.in.far.threedui.ex1;

import javax.media.j3d.Alpha;
import javax.media.j3d.BoundingSphere;
import javax.media.j3d.BranchGroup;
import javax.media.j3d.RotationInterpolator;
import javax.media.j3d.TransformGroup;

public class AnimationRotation extends BranchGroup {

	public AnimationRotation(BranchGroup targetObject) {
		TransformGroup targetTransformGroup = new TransformGroup();
		targetTransformGroup.setCapability(TransformGroup.ALLOW_TRANSFORM_WRITE);
		targetTransformGroup.addChild(targetObject);
		addChild(targetTransformGroup);
		
		//Rotation interpolation (default) around y-axis from 0 to 2xPi radians
		Alpha a = new Alpha(-1, 3000); //-1=infinity and a rotation takes 3000ms
		RotationInterpolator rotationInterpolator = new	RotationInterpolator(a, targetTransformGroup);

		BoundingSphere bounds = new BoundingSphere();
		bounds.setRadius(40.0);
		rotationInterpolator.setSchedulingBounds(bounds);
		
		addChild(rotationInterpolator);
	}		
}
