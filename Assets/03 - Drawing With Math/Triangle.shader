Shader "2D Shader Development/Drawing With Math/Triangle"
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
            
            float polygon(float2 uv, float n)
            {
                const float PI = 3.14159;
                float a = atan2(uv.x, uv.y);
                float r = 2 * PI / n;
                float d = (frac(a/r) - 0.5) * r;
                return cos(d) * length(uv);
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv * 2 - 1;                
                float c = 1 - smoothstep(0.3, 0.31, polygon(uv, 3));
                return fixed4(c,c,c,1);
            }
            
            ENDCG
        }
    }
}
