package de.tum.in.far.threedui.ex3;

import javax.media.j3d.Appearance;
import javax.media.j3d.BranchGroup;
import javax.media.j3d.Geometry;
import javax.media.j3d.Transform3D;
import javax.media.j3d.TransformGroup;
import javax.vecmath.AxisAngle4d;
import javax.vecmath.Vector3d;

import com.sun.j3d.utils.geometry.*;

public class ButtonObject extends BranchGroup {


		protected final TransformGroup transGroup;
		protected final Cylinder button;
		
		
		public ButtonObject(float r, float h, Appearance app) {
			transGroup = new TransformGroup();
			transGroup.setCapability(TransformGroup.ALLOW_TRANSFORM_WRITE);
			transGroup.setCapability(TransformGroup.ALLOW_CHILDREN_EXTEND);
			
			// Create your Shape
			button = new Cylinder(r, h, app);
			//Transform3D buttonT3D = new Transform3D();
			// buttonT3D.setRotation(new AxisAngle4d(0,0,1,Math.toRadians(90)));
			//buttonT3D.setTranslation(new Vector3d(0f,0f,0.5f));
			
			//transGroup.setTransform(buttonT3D);
			
			transGroup.addChild(button);
			
			addChild(transGroup);
		}

		public TransformGroup getTransformGroup() {
			return transGroup;
		}
		
		
	}

	
