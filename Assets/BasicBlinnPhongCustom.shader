Shader "Holistic/BasicBlinnCustom" {
	
	Properties {
		_Colour ("Colour", Color) = (1,1,1,1)
	}

	SubShader {
		Tags {
			"Queue" = "Geometry"
		}

		CGPROGRAM
		#pragma surface surf BasicBlinn

		half4 LightingBasicBlinn(SurfaceOutput s, half3 lightDir, half viewDir, half atten) {
			half3 h = normalize(lightDir + viewDir); // This is the halfway vector between the light angle and view angle

			half diff = max(0, dot(s.Normal, lightDir)); // The diffuse value is determined by the normal and light direction. The closer they are the brighter the value

			float nh = max(0, dot(s.Normal, h)); // nh is the dot product between the surface and the h value. That gives the falloff of the specular value.
			float spec = pow(nh, 48.0); // The spec is then taking the above and multiplying by 48 - default value in unity.

			half4 c;
			c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten;
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