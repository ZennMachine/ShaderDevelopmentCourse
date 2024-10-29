Shader "Holistic/Rim" {
	
	Properties {
		_RimColour ("Rim Colour", Color) = (0,0.5,0.5,0)
		_RimPower ("Rim Power", Range(0.5,8)) = 3.0
	}

	SubShader {

		CGPROGRAM
			#pragma surface surf Lambert

			struct Input {
				float3 viewDir;
			};

			float4 _RimColour;
			float _RimPower;

			void surf (Input IN, inout SurfaceOutput o){
				half rim = 1-saturate(dot(normalize(IN.viewDir), o.Normal));
				o.Emission = _RimColour * pow(rim,_RimPower);
			}
		ENDCG
	}

	FallBack "Diffuse"
}