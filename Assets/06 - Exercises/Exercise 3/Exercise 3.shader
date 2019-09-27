Shader "2D Shader Development/Exercise 3"
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

            float2x2 rotate(float angle)
            {
                return float2x2(
                    cos(angle),     sin(angle), 
                    -sin(angle),    cos(angle)
                );
            }

            float degToRad(float deg)
            {
                return deg * 3.14159265359 / 180;
            }
            


            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;

                fixed4 crowie = tex2D(_MainTex, uv);
                fixed4 col = crowie;
                return col;
            }

            ENDCG
        }
    }
}
