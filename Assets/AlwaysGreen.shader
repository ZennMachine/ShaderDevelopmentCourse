Shader "Holistic/Challenges/AllGreen" {
	
	Properties {
		_myColour ("Example Colour", Color) = (1,1,1,1)
		_myTex ("Texture", 2D) = "white"{}
		_greenFloat ("Green Float", Float) = 1
	}

	SubShader {

		CGPROGRAM
			#pragma surface surf Lambert

			struct Input {
				float2 uvMainTex;
			};

			fixed4 _myColour;
			sampler2D _myTex;
			float _greenFloat;

			void surf (Input IN, inout SurfaceOutput o){
				o.Albedo = tex2D(_myTex, IN.uvMainTex).rgb;
				o.Albedo.g = (tex2D(_myTex, IN.uvMainTex) * _greenFloat).g;
			}

		ENDCG
	}

	FallBack "Diffuse"
}