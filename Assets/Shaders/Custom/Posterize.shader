Shader "Oxysoft/Posterize" {
	Properties {
		_Red ("Red", Int) = 8
		_Green ("Green", Int) = 8
		_Blue ("Blue", Int) = 8
	 	_MainTex ("", 2D) = "white" {}
	}

	SubShader {
		Lighting Off
		ZTest Always
		Cull Off
		ZWrite Off
		Fog { Mode Off }

	 	Pass {
	  		CGPROGRAM
			// Upgrade NOTE: excluded shader from DX11, Xbox360, OpenGL ES 2.0 because it uses unsized arrays
	  		#pragma exclude_renderers flash
	  		#pragma vertex vert_img
	  		#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
	  		#include "UnityCG.cginc"

	  		uniform int _Red;
	  		uniform int _Green;
	  		uniform int _Blue;
	  		uniform sampler2D _MainTex;

	  		fixed4 frag (v2f_img i) : COLOR
	  		{
	   			fixed3 col = tex2D (_MainTex, i.uv).rgb;
				fixed4 c = fixed4(0.0, 0.0, 0.0, 1.0);
				c.r = floor(col.r * _Red) / _Red;
				c.g = floor(col.g * _Green) / _Green;
				c.b = floor(col.b * _Blue) / _Blue;

				return c;
	  		}
	  		ENDCG
	 	}
	}

	FallBack "Diffuse"
}
