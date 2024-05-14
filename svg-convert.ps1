Write-Host "Starting SVG to PDF conversion script"

$src_dir = "inkscape"
$target_dir = "build"

# Get all SVG files in the source directory
$svg_files = Get-ChildItem -Path $src_dir -Filter *.svg

# Loop over all SVG files
foreach ($svg_file in $svg_files) {
    # Get the base name of the file (without the directory and extension)
    $base_name = $svg_file.BaseName

    # Define the target PDF file
    $pdf_file = Join-Path -Path $target_dir -ChildPath "$base_name.pdf"
    $pdf_tex_file = Join-Path -Path $target_dir -ChildPath "$base_name.pdf_tex"

    # Check if the PDF file exists
    if (!(Test-Path -Path $pdf_tex_file)) {
        # Convert the SVG file to PDF using Inkscape
        Write-Host "Converting new file $svg_file to $pdf_tex_file"
        & inkscape --export-filename=$pdf_file --export-type=PDF --export-latex $svg_file.FullName
    } else {
        # Get the timestamps of the SVG and PDF files
        $svg_time = $svg_file.LastWriteTime
        $pdf_time = (Get-Item -Path $pdf_tex_file).LastWriteTime

        # Check if the SVG file is newer than the PDF file
        if ($svg_time -gt $pdf_time) {
            # Convert the SVG file to PDF using Inkscape
            Write-Host "Converting $svg_file to $pdf_tex_file"
            & inkscape --export-filename=$pdf_file --export-type=PDF --export-latex $svg_file.FullName
        } else {
            # Skip the conversion
            Write-Host "Skipping $svg_file"
        }
    }
}