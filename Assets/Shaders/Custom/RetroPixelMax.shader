Shader "Oxysoft/RetroPixelMax" {
	Properties {
		_ColorCount ("Color Count", Int) = 8
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

	  		uniform int _ColorCount;
			uniform fixed4 _Colors[256];
	  		uniform sampler2D _MainTex;

	  		fixed4 frag (v2f_img i) : COLOR
	  		{
	   			fixed3 original = tex2D (_MainTex, i.uv).rgb;

	   			fixed4 col = fixed4 (0,0,0,0);
	   			fixed dist = 10000000.0;

	   			for (int i = 0; i < _ColorCount; i++) {
	   				fixed4 c = _Colors[i];
	   				fixed d = distance(original, c);

	   				if (d < dist) {
	   					dist = d;
	   					col = c;
	   				}
	   			}

				return col;
	  		}
	  		ENDCG
	 	}
	}

	FallBack "Diffuse"
}
