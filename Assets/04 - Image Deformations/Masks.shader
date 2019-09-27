Shader "2D Shader Development/Image Deformations/Masks"
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
                fixed4 col = tex2D(_MainTex, uv);

                float bit_depth = 4;
                fixed4 col_quant = floor(col * bit_depth) / bit_depth;
                
                //fixed mask = step(uv.x, 0.5);
                //fixed mask = smoothstep(0.25, 0.75, uv.x);
                fixed mask = aa_rectangle(0.25, 0.25, 0.25, 0.25, uv);

                //return fixed4(mask, mask, mask, 1);
                
                //return col_quant * mask;
                return col * mask + (1 - mask) * col_quant;
            }
            

            ENDCG
        }
    }
}
