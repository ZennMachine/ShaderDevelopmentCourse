Shader "Holistic/Challenges/PBREmis"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MetallicTex ("Metallic (R)", 2D) = "white" {}
        _SpecColor("Specular", Color) = (1,1,1,1)
        _EmisSlide("Emissive", Range(0.0,2)) = 1
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }


        CGPROGRAM
        #pragma surface surf StandardSpecular

        sampler2D _MetallicTex;
        half _Metallic;
        fixed4 _Color;
        float _EmisSlide;

        struct Input {
            float2 uv_MetallicTex;
        };

        void surf(Input IN, inout SurfaceOutputStandardSpecular o) {
            o.Albedo = _Color.rgb;
            o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
            o.Specular = _SpecColor.rgb;
            o.Emission = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
            o.Emission *= float3(_EmisSlide, _EmisSlide, 1);
        }

        ENDCG
    }
}
