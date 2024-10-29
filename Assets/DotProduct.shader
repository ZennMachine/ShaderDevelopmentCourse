Shader "Holistic/DotProduct" {
	
	Properties {
		
	}

	SubShader {

		CGPROGRAM
			#pragma surface surf Lambert

			struct Input {
				float3 viewDir;
			};

			void surf (Input IN, inout SurfaceOutput o){
				half dotp = 1-dot(IN.viewDir,o.Normal);
				o.Albedo.gb = float2(1-dot(IN.viewDir,o.Normal),0);
			}
		ENDCG
	}

	FallBack "Diffuse"
}