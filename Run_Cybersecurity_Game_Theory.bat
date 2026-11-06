@echo off
setlocal
title Cybersecurity Investment Game Theory - Live Demo
cd /d "%~dp0"

echo.
echo ================================================================
echo       CYBERSECURITY INVESTMENT GAME THEORY - LIVE DEMO
echo ================================================================
echo.
echo Project folder: %CD%
echo.

if not exist ".venv\Scripts\python.exe" (
    echo [ERROR] Virtual environment not found at .venv\Scripts\python.exe
    echo Please create the .venv environment in this project folder first.
    echo.
    pause
    exit /b 1
)

set "PYTHON=.venv\Scripts\python.exe"

echo [1/4] Checking Python environment...
"%PYTHON%" --version
if errorlevel 1 (
    echo [ERROR] Python could not run from the project virtual environment.
    echo.
    pause
    exit /b 1
)

echo.
echo ================================================================
echo [2/4] MODEL COMPARISON RESULTS
echo ================================================================
echo This compares the target-shifting, contagion, and independent models.
echo.
"%PYTHON%" main.py --compare-models
if errorlevel 1 (
    echo.
    echo [WARNING] Model comparison returned an error. Review the output above.
) else (
    echo.
    echo [OK] Model comparison command completed.
)

echo.
echo ================================================================
echo [3/4] WHAT THESE RESULTS MEAN
echo ================================================================
echo.
echo TARGET-SHIFTING:
echo Firms choose HIGH investment at the reported Nash equilibrium,
echo while MEDIUM, MEDIUM gives the highest combined welfare.
echo Reported welfare gap: 4.76; Price of Anarchy: 1.0029.
echo.
echo CONTAGION:
echo The reported Nash equilibrium is MEDIUM, MEDIUM, while the social
echo optimum is HIGH, HIGH. This model shows a larger welfare gap.
echo Reported welfare gap: 25.62; Price of Anarchy: 1.0162.
echo.
echo INDEPENDENT BENCHMARK:
echo The Nash equilibrium and social optimum are both MEDIUM, MEDIUM.
echo Reported welfare gap: 0.00; Price of Anarchy: 1.0000.
echo.
echo KEY IDEA:
echo Nash equilibrium means neither firm benefits by changing its choice
echo alone. Social optimum means the combined welfare is maximized.
echo These are theoretical results based on model assumptions, not real
echo cybersecurity incident measurements.
echo.

echo ================================================================
echo [4/4] UNIT TESTS
echo ================================================================
echo.
"%PYTHON%" -m unittest discover -s tests -v
if errorlevel 1 (
    echo.
    echo [WARNING] One or more tests failed. See the test output above.
    set "TEST_STATUS=FAILED"
) else (
    echo.
    echo [OK] Unit tests completed successfully.
    set "TEST_STATUS=PASSED"
)

echo.
echo ================================================================
echo DEMO FINISHED
echo Unit test status: %TEST_STATUS%
echo The terminal will stay open. Press any key to close it.
echo ================================================================
echo.
pause
endlocal
