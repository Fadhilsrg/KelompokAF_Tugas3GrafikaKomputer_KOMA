Shader"Custom/ColorChangeShader" {
    Properties {
        _Color1 ("Color 1", Color) = (1, 0, 0, 1) // Red
        _Color2 ("Color 2", Color) = (0, 1, 0, 1) // Green
        _Color3 ("Color 3", Color) = (0, 0, 1, 1) // Blue
        _DeltaChange ("Delta Change", Range(0, 5)) = 1.0
        _DeltaAnimation ("Delta Animation", Range(0, 2)) = 0.1
    }
    SubShader {
        Tags { "Queue" = "Overlay" }
        LOD 100

        CGPROGRAM
        #pragma surface surf Lambert

            sampler2D _Maintex;

            struct Input
            {
                float2 uv_MainTex;
                float3 worldPos;
            };

            fixed4 _Color1;
            fixed4 _Color2;
            fixed4 _Color3;
            float _DeltaChange;
            float _DeltaAnimation;

                    UNITY_INSTANCING_BUFFER_START(Props)
                    UNITY_INSTANCING_BUFFER_END(Props)

            void surf(Input IN, inout SurfaceOutput o)
            {
                float height = sin(IN.uv_MainTex.y * 3.141592);

                float deltaTime = _DeltaChange;
                float currPos = (_Time.y % deltaTime) / deltaTime;

                float smoothStepValue = smoothstep(0.0, 1.0, abs(frac(_Time.y * _DeltaAnimation) - height));
            
                fixed4 c;
                o.Alpha = 1.0;

                if (abs(IN.worldPos.y + 0.5 - currPos) < 0.02)
                {
                    c.rgb = lerp(lerp(_Color1.rgb, _Color2.rgb, smoothstep(0.0, 0.5, height)),
                                 lerp(_Color2.rgb, _Color3.rgb, smoothstep(0.5, 1.0, height)),
                                         smoothStepValue);

                    o.Albedo = c.rgb;
                }
                else
                {
                    o.Albedo = fixed3(0.0, 0.0, 0.0);
                }
            }
        ENDCG
    }
FallBack"Diffuse"
}
