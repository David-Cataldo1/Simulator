@echo off
setlocal

echo.
echo [1/4] Creating build directory...
if not exist build mkdir build
cd build

echo.
echo [2/4] Running CMake configuration...
cmake .. -G "Visual Studio 17 2022"

echo.
echo [3/4] Building project (Release)...
cmake --build . --config Release

echo.
echo [4/4] Opening solution in Visual Studio...
cd ..
start build\Simulator.sln

echo.
echo Done. You can now build and run the Simulator project.
pause
