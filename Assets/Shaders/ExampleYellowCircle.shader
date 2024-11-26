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

            struct v2f    // Структура для передачи данных между вершинным и пиксельным шейдером
            {
                 float4 vertex : SV_POSITION;   // Позиция вершины в пространстве экрана
                 float2 position : TEXCOORD0;   // Нормализованные координаты экрана
            };

            v2f vert (appdata_base v) // Вершинный шейдер
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);    // Преобразуем в пространство экрана
                o.position = o.vertex.xy / o.vertex.w;       // Нормализуем позиции (x, y) в диапазоне [-1, 1]
                return o;
            }
            
            float _CircleRadius; // Глобальная переменная для радиуса окружности
            
            fixed4 frag (v2f i) : SV_Target // Пиксельный шейдер
            {
                float dist = length(i.position.xy);  // расстояние от центра экрана (0, 0)
                
                float insideCircle = step(dist, _CircleRadius);  //  step для определения границы окружности
                
                return fixed4(insideCircle, insideCircle, 0.0, 1.0);  // Возвращаем желтый цвет внутри окружности и черный снаружи
            }
            ENDCG
        }
    }
}
