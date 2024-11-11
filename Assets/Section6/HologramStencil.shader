Shader "Holistic/RimHologramStencil" {
	
	Properties {
		_RimColour ("Rim Colour", Color) = (0,0.5,0.5,0)
		_RimPower ("Rim Power", Range(0.5,8)) = 3.0

		_SRef("Stencil Ref", Float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)]   _SComp("Stencil Comp", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)]   _SOp("Stencil Op", Float) = 2
	}

	SubShader {
		
		Tags{
			"Queue" = "Transparent"
		}

		Pass {
			Zwrite On
			ColorMask 0
		}

		Stencil
		{
            Ref[_SRef]
            Comp[_SComp]
            Pass[_SOp]
        }

		CGPROGRAM
			#pragma surface surf Lambert alpha:fade

			struct Input {
				float2 uv_Diffuse;
				float3 viewDir;
				float3 worldPos;
			};

			sampler2D _Diffuse;
			float4 _RimColour;
			float _RimPower;

			void surf (Input IN, inout SurfaceOutput o){
				half rim = 1-saturate(dot(normalize(IN.viewDir), o.Normal));
				o.Emission = _RimColour.rgb * pow(rim, _RimPower) * 10;
				o.Alpha = pow(rim, _RimPower);
			}
		ENDCG
	}

	FallBack "Diffuse"
}