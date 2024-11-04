Shader "Holistic/BasicLambertCustom" {
	
	Properties {
		_Colour ("Colour", Color) = (1,1,1,1)
	}

	SubShader {
		Tags {
			"Queue" = "Geometry"
		}

		CGPROGRAM
		#pragma surface surf BasicLambert

		half4 LightingBasicLambert(SurfaceOutput s, half3 lightDir, half atten) {
			half NdotL = dot(s.Normal, lightDir); // Get the dot product of the light source and surface normal
			half4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
			c.a = s.Alpha;
			return c; // This is the resulting colour for this pixel
		}

		float4 _Colour;

		struct Input {
			float2 uv_MainTex;	
		};

		void surf(Input IN, inout SurfaceOutput o) {
			o.Albedo = _Colour.rgb;
		}

		ENDCG
	}

	FallBack "Diffuse"
}