Shader "2D Shader Development/Image Deformations/Rotation Bottom Left"
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
            
            float degToRad(float deg)
            {
                return deg * 3.14159265359 / 180;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                float angle = degToRad(45);
                
                float2x2 rot = float2x2(
                    cos(angle),     sin(angle),
                    -sin(angle),    cos(angle)
                );
                
                float2 uv = mul(rot, i.uv);
                fixed4 col = tex2D(_MainTex, uv);
                return col;
            }
            ENDCG
        }
    }
}
