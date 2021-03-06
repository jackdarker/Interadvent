package animation.easing{
	
	////////////////////////////////////////////////////////////////////////////////
	//	Easing 1.0 12/24/10
	//  Copyright © 2003 Robert Penner
	//	All rights reserved.
	//	Terms of Use: http://www.robertpenner.com/easing_terms_of_use.html
	//	
	////////////////////////////////////////////////////////////////////////////////


	public class Back{
		
		public function Back(){
			
		}
		
		//Back
		public static function easeIn(t:Number, b:Number, c:Number, d:Number, s:Number=1.70158):Number {
			return c*(t/=d)*t*((s+1)*t - s) + b;
		}
		public static function easeOut(t:Number, b:Number, c:Number, d:Number, s:Number=1.70158):Number {
			return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
		}
		public static function easeInOut(t:Number, b:Number, c:Number, d:Number, s:Number=1.70158):Number {
			if ((t/=d/2) < 1) 
				return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
				
			return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
		}
			
	}
}