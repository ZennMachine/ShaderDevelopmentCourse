Shader "Holistic/BumpDiffuseStencil"
{
    Properties {
		_diffuse ("Diffuse Texture", 2D) = "white"{}
		_bump ("Bump Texture", 2D) = "bump"{}
		_normalSlider ("Bump Amount", Range(0,10)) = 1
		_scaleSlider ("Scale Amount", Range(0,10)) = 1

		_SRef("Stencil Ref", Float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)]   _SComp("Stencil Comp", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)]   _SOp("Stencil Op", Float) = 2
	}

	SubShader {

		Stencil
		{
            Ref[_SRef]
            Comp[_SComp]
            Pass[_SOp]
        }

		CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _diffuse;
			sampler2D _bump;
			half _normalSlider;
			half _scaleSlider;

			struct Input {
				float2 uv_diffuse;
				float2 uv_bump;
			};

			void surf (Input IN, inout SurfaceOutput o){
				o.Albedo = tex2D(_diffuse, IN.uv_diffuse * _scaleSlider).rgb;
				o.Normal = UnpackNormal(tex2D(_bump, IN.uv_bump * _scaleSlider));
				o.Normal *= float3(_normalSlider,_normalSlider,1);
			}

		ENDCG
	}

	FallBack "Diffuse"
}