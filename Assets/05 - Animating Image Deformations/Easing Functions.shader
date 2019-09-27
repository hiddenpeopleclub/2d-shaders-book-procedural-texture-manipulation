Shader "2D Shader Development/Animating Image Deformations/EasingFunctions"
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
            
            float easing(float x) {
                return pow(x,2);
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;

                float easing_result = easing((_Time.y / 2) % 1);

                fixed4 plotting = plot(uv, easing_result) * fixed4(1,1,1,1);
                
                fixed4 color = lerp(fixed4(1,0,0,1), fixed4(0,1,0,1), easing_result);
                fixed4 image = tex2D(_MainTex, i.uv) * color;
                
                return plotting  + (1-plotting) *image;
            }
            ENDCG
        }
    }
}
