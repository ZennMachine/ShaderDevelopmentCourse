Shader "Holistic/Allprops"
{
	Properties {
		_myColour ("Colour", Color) = (1,1,1,1)
		_myRange ("Range", Range(0,5)) = 1
		_myTex ("Texture Map", 2D) = "white"{}
		_myCube ("Cube Map", CUBE) = "" {}
		_myFloat ("Float", Float) = 0.5
		_myVector ("Vector", Vector) = (0.5,1,1,1)
	}

	SubShader {

		CGPROGRAM
			#pragma surface surf Lambert

			fixed4 _myColour;
			half _myRange;
			sampler2D _myTex;
			samplerCUBE _myCube;
			float _myFloat;
			float4 _myVector;

			struct Input {
				float2 uv_myTex;
				float3 worldRefl;
			};

			void surf (Input IN, inout SurfaceOutput o) {
				o.Albedo = (tex2D(_myTex, IN.uv_myTex) * _myRange).rgb;
				o.Emission = (texCUBE(_myCube, IN.worldRefl) * _myRange / 2).rgb;
			}

		ENDCG
	}
	Fallback "Diffuse"
}