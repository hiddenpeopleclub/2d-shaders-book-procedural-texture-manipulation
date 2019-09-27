Shader "2D Shader Development/Drawing With Math/Circle"
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
            
            fixed circle(float2 center, float radius, float softness, float2 uv)
            {
                fixed d = distance(center, uv);
                return 1 - smoothstep(radius - softness, radius + softness, d);
            }
                                    
            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;
                //fixed col = circle(float2(0.5, 0.5), 0.2, 0.005, uv);
                fixed2 center = fixed2(0.5, 0.5);
                fixed col = step(distance(center, uv ), 0.5); 
                fixed col2 =  step(distance(center, uv ), 0.2);
                return col - col2 * fixed4(1,1,1,1);
            }
            ENDCG
        }
    }
}
