package scripts;

import com.stencyl.graphics.G;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import nme.ui.Mouse;
import nme.display.Graphics;
import nme.display.BlendMode;
import nme.display.BitmapData;
import nme.display.Bitmap;
import nme.events.Event;
import nme.events.KeyboardEvent;
import nme.events.TouchEvent;
import nme.net.URLLoader;

import box2D.dynamics.joints.B2Joint;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_9_9_BackandForthVertically extends ActorScript
{          	
	
public var _DistanceUp:Float;

public var _Speed:Float;

public var _InitialDirection:Float;

public var _DistanceDown:Float;

public var _ChangeDirectiononCollision:Bool;

public var _Start:Float;

public var _End:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Distance Up", "_DistanceUp");
_DistanceUp = 100.0;
nameMap.set("Speed", "_Speed");
_Speed = 10.0;
nameMap.set("Initial Direction", "_InitialDirection");
_InitialDirection = 0.0;
nameMap.set("Distance Down", "_DistanceDown");
_DistanceDown = 100.0;
nameMap.set("Change Direction on Collision", "_ChangeDirectiononCollision");
_ChangeDirectiononCollision = true;
nameMap.set("Start", "_Start");
_Start = 0.0;
nameMap.set("End", "_End");
_End = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        actor.makeAlwaysSimulate();
        _Start = asNumber((actor.getYCenter() - _DistanceUp));
propertyChanged("_Start", _Start);
        _End = asNumber((actor.getYCenter() + _DistanceDown));
propertyChanged("_End", _End);
        actor.setYVelocity((_InitialDirection * _Speed));
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((actor.getYCenter() > _End))
{
            actor.setYVelocity(-(_Speed));
}

        else if((actor.getYCenter() < _Start))
{
            actor.setYVelocity(_Speed);
}

}
});
    
/* ======================== Something Else ======================== */
addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_ChangeDirectiononCollision)
{
            if(event.thisFromTop)
{
                actor.setYVelocity(_Speed);
}

            if(event.thisFromBottom)
{
                actor.setYVelocity(-(_Speed));
}

}

}
});
    
/* ========================= When Drawing ========================= */
addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((sceneHasBehavior("Game Debugger") && asBoolean(getValueForScene("Game Debugger", "_Enabled"))))
{
            g.strokeColor = getValueForScene("Game Debugger", "_CustomColor");
            g.strokeSize = Std.int(getValueForScene("Game Debugger", "_StrokeThickness"));
            g.translateToScreen();
            g.drawLine((actor.getXCenter() - getScreenX()), (_Start - getScreenY()), (actor.getXCenter() - getScreenX()), (_End - getScreenY()));
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}