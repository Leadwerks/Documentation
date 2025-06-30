# Programming with C++

C++ is a powerful programming language capable of crafting games and simulations in Ultra Engine. It offers a low-level, close-to-the-metal programming experience while maintaining excellent debugging capabilities and seamless compatibility with a vast array of third-party libraries and APIs. Ultra Engine's integration of C++ smart pointers simplifies C++ development, providing memory management akin to high-level languages without compromising performance.

## Prerequisites

Before you dive into C++ programming for Ultra Engine on Windows, ensure you have the necessary tools in place:

1. **Install Visual Studio Community Edition:**
   - Download and install [Visual Studio Community Edition](https://visualstudio.microsoft.com/#vs-section).

2. **Select "Desktop Development with C++":**
   - During the installation process, make sure to select the "Desktop development with C++" option.

![Visual Studio Components](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/vs_components.png)

## Getting Started

To start your C++ programming journey with Ultra Engine, follow these steps:

1. **Open Your C++ Ultra Engine Project:**
   - Locate the .sln file in your C++ Ultra Engine project directory.
   - Open this solution file using Visual Studio Community Edition.

![Project Files](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/projectfiles.png)

2. **Compile and Run Your Game:**
   - With your project open in Visual Studio, press F5 to compile and run your Ultra Engine game.

![Compile and Run](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/vs.png)

## Environment Variable

On Windows, Leadwerks uses an environment variable to specify the location of header and library files. This will be created automatically by the standalone installer, or you may asked for permission to add it during project creation.

You can also add an environment variable manually called "LEADWERKS" and set its value to your install location. To access Windows environment variables, run the **System Properties** app.

![Project Files](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/systemproperties.png)

Press the **Enviurnment Variables** button. If it does not already exist, you can add a system variable. For the Steam version of Leadwerks, the default path is "C:\Program Files (x86)\Steam\steamapps\common\Leadwerks". For the standalone version, the default path is "C:\Program Files\Leadwerks". These paths may be different if you installed Steam or Leadwerks to different directories.

![Project Files](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/environmentvariables.png)

Use of an environment variable makes it easier for developers to share C++ projects across different computers.

## Exploring Examples

You can quickly explore C++ programming in Ultra Engine by trying out example projects. Follow these steps:

1. **Copy Example Code:**
   - Visit the [examples section](https://www.ultraengine.com/learn/LoadModel?lang=cpp) of the documentation.
   - Copy the code from any example you wish to try.

2. **Paste into Your main.cpp File:**
   - Open your main.cpp file in Visual Studio.
   - Paste the copied code into your main.cpp file.

3. **Compile and Run:**
   - Compile and run your project in Visual Studio, and the example will be displayed.

This guide will help you kickstart your C++ development with Ultra Engine, enabling you to create games and simulations with ease.

