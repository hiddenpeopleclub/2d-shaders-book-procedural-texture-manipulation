Shader "2D Shader Development/Appendix II - Distance Fields"
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

            float plot(float2 uv, float f_x)
            {
                return smoothstep(f_x - 0.01, f_x, uv.y) - 
                       smoothstep(f_x, f_x + 0.01, uv.y);
            }

            fixed circle(float2 uv, float radius)
            {
                return length(uv) - radius;
            }

            fixed square(float2 uv, float side)
            {
                return length(max(abs(uv) - side, 0));
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                // Center the UV
                float2 uv = (i.uv * 2) - 1;
                
                float d = square(uv, 0.5);
                d = frac(d * 5);
                d = step(d,0.2);
                fixed4 col = fixed4(d, d, d, 1);
                return col;
            }

            ENDCG
        }
    }
}
