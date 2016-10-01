Shader "Oxysoft/Dither" {
	Properties {
		_Threshold ("Threshold", Float) = 0.45
		_Strength ("Strength", Float) = 0.45
		_Width ("Width", Int) = 0.45
		_Height ("Height", Int) = 0.45
	 	_Dither ("Dither", 2D) = "white" {}
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

	  		uniform float _Threshold;
	  		uniform float _Strength;
	  		uniform int _Width;
	  		uniform int _Height;

	  		uniform sampler2D _Dither;
	  		uniform sampler2D _MainTex;

			float luma(fixed3 color) {
				return dot(color, fixed3(0.299, 0.587, 0.114));
			}

			float luma(fixed4 color) {
				return dot(color.rgb, fixed3(0.299, 0.587, 0.114));
			}

			fixed4 ditherBayer2(fixed2 position, float brightness) {
				int x = fmod(position.x, 4.0);
                int y = fmod(position.y, 4.0);

                int index = x + y * 4;
                float lim = 0.0;

                if (x < 8) {
                    if (index == 0) lim = 0.0625;
                    if (index == 1) lim = 0.5625;
                    if (index == 2) lim = 0.1875;
                    if (index == 3) lim = 0.6875;
                    if (index == 4) lim = 0.8125;
                    if (index == 5) lim = 0.3125;
                    if (index == 6) lim = 0.9375;
                    if (index == 7) lim = 0.4375;
                    if (index == 8) lim = 0.25;
                    if (index == 9) lim = 0.75;
                    if (index == 10) lim = 0.125;
                    if (index == 11) lim = 0.625;
                    if (index == 12) lim = 1.0;
                    if (index == 13) lim = 0.5;
                    if (index == 14) lim = 0.875;
                    if (index == 15) lim = 0.375;
                }

                if (brightness < lim * _Strength)
                    return 0.0;

                return 1.0;
			}

			fixed3 ditherPattern2(fixed2 position, float brightness) {
				int x = fmod(position.x, _Width);
	            int y = fmod(position.y, _Height);

				float lim = 0.0;

	            lim = tex2D(_Dither, fixed2(x, y) / _Width).r;

                if (brightness < lim * _Threshold)
                    return _Strength;

	            return 1.0;
			}

			fixed3 ditherBayer(fixed2 position, fixed3 col) {
				return col * ditherBayer2(position, luma(col));
			}

			fixed3 ditherPattern(fixed2 position, fixed3 col) {
                return col * ditherPattern2(position, luma(col));
            }

	  		fixed4 frag (v2f_img i) : COLOR
	  		{
	   			fixed3 col = tex2D (_MainTex, i.uv).rgb;
				return fixed4(ditherPattern(i.pos.xy, col), 1.0);
	  		}
	  		ENDCG
	 	}
	}

	FallBack "Diffuse"
}
