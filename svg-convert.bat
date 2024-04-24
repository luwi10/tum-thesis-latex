@echo off
setlocal enabledelayedexpansion

:: Define the source and target directories
set "src_dir=%~dp0\inkscape"
set "target_dir=%~dp0\figures"

:: Loop over all SVG files in the source directory
for %%F in ("%src_dir%\*.svg") do (
    :: Get the base name of the file (without the directory and extension)
    for %%N in (%%~nF) do (
        :: Define the target PDF file
        set "pdf_file=!target_dir!\%%N.pdf"
        :: Check if the PDF file exists
        if not exist "!pdf_file!" (
            :: Convert the SVG file to PDF using Inkscape
            echo Converting "%%F" to "!pdf_file!"
            inkscape "%%F" -o "!pdf_file!"
        ) else (
            :: Get the timestamps of the SVG and PDF files
            for %%P in ("!pdf_file!") do set "pdf_time=%%~tP"
            set "svg_time=%%~tF"
            :: Check if the SVG file is newer than the PDF file
            if "!svg_time!" GTR "!pdf_time!" (
                :: Convert the SVG file to PDF using Inkscape
                echo Converting "%%F" to "!pdf_file!"
                inkscape "%%F" -o "!pdf_file!"
            ) else (
                :: Skip the conversion
                echo Skipping "%%F"
            )
        )
    )
)

endlocal