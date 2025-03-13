project "Box2D"
	kind "StaticLib"
	language "C++"
	cppdialect "C++11"
	staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"src/**.h",
		"src/**.c",
		"include/**.h"
	}

	includedirs
	{
		"include",
		"src"
	}

    -- SIMD tuki
    filter "options:BOX2D_ENABLE_SIMD=true"
        defines { "BOX2D_ENABLE_SIMD" }

    -- AVX2 tuki x86_64:llä
    filter "options:BOX2D_AVX2=true"
        defines { "BOX2D_AVX2" }

	filter "system:macosx"
		systemversion "12.0"	
        -- Apple erikoisasetukset (esim. sanitointi)
        -- buildoptions { "-fsanitize=address", "-fsanitize=undefined" }
        -- linkoptions { "-fsanitize=address", "-fsanitize=undefined" }

	filter "system:windows"
		systemversion "latest"
		-- MSVC erityisasetukset
        buildoptions { "/MP", "/Zi" } -- paralleelit, debug-tiedostot
        linkoptions { "/INCREMENTAL:NO" }

	filter "system:linux"
		pic "On"
		systemversion "latest"
		buildoptions { "-ffp-contract=off" }

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"
		defines { "DEBUG", "_DEBUG" }

	filter "configurations:Release"
		runtime "Release"
		optimize "on"
		defines { "NDEBUG" }

	filter "configurations:Dist"
		runtime "Release"
		optimize "on"
        symbols "off"
		defines { "NDEBUG" }
