Shader "Unlit/ExampleYellowCircle"
{
    Properties
    {
         _CircleRadius("Circle Radius", Float) = 0.3
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"

            struct v2f    // The structure for passing data between the vertex shader and the pixel shader
            {
                 float4 vertex : SV_POSITION;   // The position of the vertex in screen space

                 float2 position : TEXCOORD0;   // Normalized screen coordinates
            };

            v2f vert (appdata_base v) // Vertex Shader
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);    // Transform to screen space
                o.position = o.vertex.xy / o.vertex.w;       // Normalize positions (x, y) to the range [-1, 1]
                return o;
            }
            
            float _CircleRadius; // A global variable for the circle's radius
            
            fixed4 frag (v2f i) : SV_Target // Pixel Shader
            {
                float dist = length(i.position.xy);  // Distance from the center of the screen (0, 0)
                
                float insideCircle = step(dist, _CircleRadius);  //  step for determining the circle's boundary
                
                return fixed4(insideCircle, insideCircle, 0.0, 1.0);  // return a yellow color inside the circle and black outside
            }
            ENDCG
        }
    }
}
