Shader "2D Shader Development/Exercise 1/PlotWithThicknessAndSmoothness"
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
            
            float plot(float2 uv, float f_x, float thickness, float smoothness)
            {
                return smoothstep(f_x - 0.01, f_x, uv.y) -
                       smoothstep(f_x, f_x + 0.01, uv.y);
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;
                float f_x = uv.x;
                
                fixed4 col = plot(uv, f_x, 0.01, 0.5) * fixed4(1,1,1,1);
                return col;
            }
            ENDCG
        }
    }
}
