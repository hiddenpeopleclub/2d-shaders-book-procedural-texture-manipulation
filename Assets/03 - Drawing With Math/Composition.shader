Shader "2D Shader Development/Drawing With Math/Composition"
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
            
            // Adapted from https://www.shadertoy.com/view/MtSyRt
            float star(float2 uv, float vertices, float radius, float offset)
            {
                const float PI = 3.14159;

                float segmentAngle = 2*PI/vertices;
                float halfSegmentAngle = segmentAngle*0.5;
                float angleRadians = atan2(uv.x, uv.y);
                float repeat = abs(frac(angleRadians/segmentAngle - 0.5) - 0.5)*segmentAngle;
                float circle = length(uv);
                float x = sin(repeat)*circle;
                float y = cos(repeat)*circle;
                float uvRotation = halfSegmentAngle + offset;
                return cos(uvRotation)*y + sin(uvRotation)*x;;
            }
            
            fixed circle(float2 center, float radius, float softness, float2 uv)
            {
                fixed d = distance(center, uv);
                return smoothstep(radius - softness, radius + softness, d);
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;
                float gradient = smoothstep(0.4, 0.5, uv.x);
                fixed circle1 = circle(float2(0.5, 0.5), 0.2, 0.005, uv);
                fixed circle2 = circle(float2(0.5, 0.5), 0.15, 0.005, uv);
                float c = (circle2 - circle1) * gradient;
                return fixed4(c,c,c,1);
            }
            
            ENDCG
        }
    }
}
