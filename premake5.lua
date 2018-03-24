workspace "workspace"
    configurations { "debug", "release" }
    platforms { "x32", "x64" }

    filter {"system:windows"}
        characterset "MBCS"
    filter {}

    -- Set up platforms 
    filter {"platforms:x32"}
        architecture "x32"
    filter {"platforms:x64"}
        architecture "x64"
    filter {}

    -- Setup c++ spec per platform
    -- Linux uses a buildoption to allow for more
    -- up to date standards (2a)
    filter {"system:windows"}
        toolset "msc-v141"
        cppdialect "C++17"
        buildoptions{ "--driver-mode=cl" } -- for compile commands
    filter {"system:linux"}
        toolset "clang" -- prefer clang over gcc
        buildoptions "-std=c++17"
    filter {}

    -- Setup configurations
    filter "configurations:Debug"
        defines { "DEBUG", "_DEBUG" }
        optimize "Off"

        filter {"system:windows"}
            symbols "Full"
        filter {"system:linux"}
            symbols "On"
            buildoptions "-g3" -- need this for gdb
        filter {}
        runtime "Debug"

    filter {"configurations:Release"}
        defines { "NDEBUG" }
        optimize "Full"
        symbols "Off"
        flags {"LinkTimeOptimization"}
        
    filter {}

    project "pe_lib"
        kind "StaticLib"
        language "C++"
        targetdir "bin/%{cfg.buildcfg}"
        
        includedirs { "pe_lib" }
        files { "pe_lib/**.h", "pe_lib/**.cpp" }