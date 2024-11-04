Shader "Holistic/Rim" {
	
	Properties {
		_Diffuse ("Diffuse Map", 2D) = "white"{}
		_RimColour ("Rim Colour", Color) = (0,0.5,0.5,0)
		_RimPower ("Rim Power", Range(0.5,8)) = 3.0
		_StripeSize ("Stripe Size", Range(0.0, 1)) = 0.4
	}

	SubShader {

		CGPROGRAM
			#pragma surface surf Lambert

			struct Input {
				float2 uv_Diffuse;
				float3 viewDir;
				float3 worldPos;
			};

			sampler2D _Diffuse;
			float4 _RimColour;
			float _RimPower;
			half _StripeSize;

			void surf (Input IN, inout SurfaceOutput o){
				half rim = 1-saturate(dot(normalize(IN.viewDir), o.Normal));
				//o.Emission = rim > 0.6 ? float3(1,0,0): rim > 0.3 ? float3(0,1,0): 0;
				//o.Emission = IN.worldPos.y > 1 ? float3(0,1,0): 0;
				o.Albedo = tex2D(_Diffuse, IN.uv_Diffuse).rgb;
				o.Emission = frac(IN.worldPos.y*10 * 0.5) > _StripeSize ?
					float3(0,1,0)*rim: float3(1,0,0)*rim;
			}
		ENDCG
	}

	FallBack "Diffuse"
}