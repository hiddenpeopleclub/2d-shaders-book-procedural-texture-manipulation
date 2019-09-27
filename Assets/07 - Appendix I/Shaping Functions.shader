Shader "2D Shader Development/Appendix I - Shaping Functions"
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

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;
                
                float y = uv.x; float t = _Time.y;
                // float y = smoothstep(0.1,0.9, uv.x); float t = smoothstep(0.1,0.9, _Time.y);
                // float y = fmod(uv.x,0.5); float t = fmod(_Time.y,0.5);
                // float y = frac(uv.x * 2); float t = frac(_Time.y * 2);
                // float y = ceil(uv.x * 4) / 4; float t = ceil(_Time.y * 4) / 4;
                // float y = floor(uv.x * 4) / 4; float t = floor(_Time.y * 4) / 4;
                // float y = pow(uv.x,2); float t = pow(_Time.y,2);
                // float y = clamp(uv.x, 0.2, 0.8); float t = clamp(_Time.y, 0.2, 0.8);

                float function_plot = plot(uv, y);
                fixed4 crowie = tex2D(_MainTex, uv);
                fixed4 color = lerp(fixed4(1,0,0,1), fixed4(0,1,0,1), t);

                fixed4 col = function_plot + crowie * color;
                return col;
            }

            ENDCG
        }
    }
}
