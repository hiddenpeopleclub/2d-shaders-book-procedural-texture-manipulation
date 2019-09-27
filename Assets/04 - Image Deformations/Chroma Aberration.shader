Shader "2D Shader Development/Image Deformations/Chroma Aberration"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags { "RenderType"="Transparent" }
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;
                fixed4 col1 = tex2D(_MainTex, uv);
                fixed4 col2 = tex2D(_MainTex, uv + float2(0.003, 0));
                fixed4 col3 = tex2D(_MainTex, uv - float2(0.003, 0));
                
                fixed4 col = fixed4(
                    col1.r * col1.a, 
                    col2.g * col2.a, 
                    col3.b * col3.a, 
                    saturate(col1.a + col2.a + col3.a)
                );
                return col;
            }
            ENDCG
        }
    }
}
