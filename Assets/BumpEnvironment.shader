Shader "Holistic/BumpEnviro" {
	
	Properties {
		_diffuse ("Diffuse Texture", 2D) = "white"{}
		_bump ("Bump Texture", 2D) = "bump"{}
		_normalSlider ("Bump Amount", Range(0,10)) = 1
		_scaleSlider ("Scale Amount", Range(0,10)) = 1
		_cube ("Cube Map", CUBE) = "white"{}
	}

	SubShader {

		CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _diffuse;
			sampler2D _bump;
			half _normalSlider;
			half _scaleSlider;
			samplerCUBE _cube;

			struct Input {
				float2 uv_diffuse;
				float2 uv_bump;
				float3 worldRefl; INTERNAL_DATA
			};

			void surf (Input IN, inout SurfaceOutput o){
				o.Albedo = tex2D(_diffuse, IN.uv_diffuse * _scaleSlider).rgb;
				o.Normal = UnpackNormal(tex2D(_bump, IN.uv_bump * _scaleSlider));
				o.Normal *= float3(_normalSlider,_normalSlider,1);
				o.Emission = texCUBE(_cube, WorldReflectionVector (IN, o.Normal)).rgb;
			}
		ENDCG
	}

	FallBack "Diffuse"
}