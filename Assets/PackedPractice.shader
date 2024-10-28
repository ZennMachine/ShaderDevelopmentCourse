Shader "Holistic/PackedShader" {
	
	Properties {
		_myColour ("Example Colour", Color) = (1,1,1,1)
	}

	SubShader {

		CGPROGRAM
			#pragma surface surf Lambert

			struct Input {
				float2 uvMainTex;
			};

			fixed4 _myColour;

			void surf (Input IN, inout SurfaceOutput o){
				o.Albedo.r = _myColour.g;
				o.Albedo.b = _myColour.r;
			}

		ENDCG
	}

	FallBack "Diffuse"
}