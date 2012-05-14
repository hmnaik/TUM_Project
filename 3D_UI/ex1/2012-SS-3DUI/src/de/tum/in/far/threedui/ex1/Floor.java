package de.tum.in.far.threedui.ex1;

import javax.media.j3d.Appearance;
import javax.media.j3d.BranchGroup;
import javax.media.j3d.TransformGroup;
import javax.vecmath.Vector3d;

import com.sun.j3d.utils.geometry.Box;

public class Floor extends BranchGroup{
	
	protected final TransformGroup transform ;
	protected final Box box;
	
	public Floor(Vector3d Position){
		
		this (Position, null);
	}
	
	public Floor(Vector3d Position, Appearance app ){
		
		transform = new TransformGroup();
		transform.setCapability(TransformGroup.ALLOW_TRANSFORM_WRITE);
		transform.setCapability(TransformGroup.ALLOW_CHILDREN_EXTEND);
		
		box = new Box((float)Position.getX(),(float)Position.getY(),(float)Position.getZ(), app );
		
		transform.addChild(box);
		
		addChild(transform);
		
	}
	
	public TransformGroup getTransformGroup(){
		
		return transform; 
		
	}
	
	

}
