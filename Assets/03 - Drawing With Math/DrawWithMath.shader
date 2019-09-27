Shader "2D Shader Development/Drawing With Math/DrawWithMath"
{
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
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

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;
                fixed shade = smoothstep(uv.y - 0.01, uv.y,uv.x) - smoothstep(uv.y, uv.y + 0.01,uv.x);
                fixed4 col = fixed4(shade, shade, shade, 1);
                return col;
            }
            ENDCG
        }
    }
}
