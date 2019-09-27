Shader "2D Shader Development/Drawing With Math/Axis-Aligned Rectangle"
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
                        
            float aa_rectangle(float top, float left, float bottom, float right, float2 uv) 
            {
                float4 borders = float4(left, bottom, right, top);
                float4 uvs = float4(uv, 1 - uv);
                float4 rec = step(borders, uvs);
                return rec.x * rec.y * rec.z * rec.w;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;
                fixed col = aa_rectangle(0.25, 0.25, 0.25, 0.25, uv);
                return col * fixed4(1,1,1,1);
            }
            ENDCG
        }
    }
}
