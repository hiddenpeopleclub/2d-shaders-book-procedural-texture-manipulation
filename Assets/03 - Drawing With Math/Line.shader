Shader "2D Shader Development/Drawing With Math/Line"
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
            
            float plot(float2 uv, float f_x)
            {
                return smoothstep(f_x - 0.01, f_x, uv.y) - 
                       smoothstep(f_x, f_x + 0.01, uv.y);
            }
            
            float draw_line(float a, float x, float b) 
            {
                return a * x + b; 
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;
                float a = -1.5;
                float b = 0.9;
                
                fixed4 col = plot(
                    uv, 
                    draw_line(a, uv.x, b)
                );
                  
                return col * fixed4(1,1,1,1);
            }
            ENDCG
        }
    }
}
