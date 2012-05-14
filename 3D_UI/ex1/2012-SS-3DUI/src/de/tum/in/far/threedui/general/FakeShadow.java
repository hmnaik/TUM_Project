package de.tum.in.far.threedui.general;

import javax.media.j3d.BranchGroup;
import javax.media.j3d.Geometry;
import javax.media.j3d.GeometryArray;
import javax.media.j3d.Shape3D;
import javax.media.j3d.TransformGroup;
import javax.media.j3d.TriangleStripArray;
import javax.vecmath.Color3f;
import javax.vecmath.Point3f;

public class FakeShadow extends BranchGroup {

	private float height = 0.0f;
	
	private final TransformGroup tg;
	
	public FakeShadow(Geometry geom, Color3f col) {
		tg = new TransformGroup();
		tg.setCapability(TransformGroup.ALLOW_TRANSFORM_WRITE);
		FlatShape flatShape = new FlatShape(geom, col);
		tg.addChild(flatShape);
	    addChild(tg);
	}

	public TransformGroup getTransformGroup() {
		return tg;
	}

	// ******************
	
	private class FlatShape extends Shape3D {
		FlatShape(Geometry geom, Color3f col) {
			
			// shadows can only be calculated for Geometries consisting of GeometryArrays
			// otherwise fail silently
			if (!(geom instanceof GeometryArray))
				return;
			
			GeometryArray geomArray = (GeometryArray)geom; 
			
    		int vCount = geomArray.getVertexCount();
    		int[] stripVertexArray = new int[((TriangleStripArray)geom).getNumStrips()];
    		((TriangleStripArray)geom).getStripVertexCounts(stripVertexArray);
    		TriangleStripArray poly = new TriangleStripArray(vCount, GeometryArray.COORDINATES | GeometryArray.COLOR_3 | GeometryArray.NORMALS, stripVertexArray);

    		Point3f vertex = new Point3f();
    		Point3f shadow = new Point3f();
    		for (int v = 0; v < vCount; v++) {
    			geomArray.getCoordinate(v, vertex);
    			shadow.set(vertex.x, height + 0.0001f, vertex.z);
    			
    			poly.setCoordinate(v, shadow);
    			poly.setColor(v, col);
    		}

    		this.setGeometry(poly);
		}
	}
}
