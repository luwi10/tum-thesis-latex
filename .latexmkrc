# Set the program used to generate the PDF
# 1: pdflatex
# 2: postscript conversion, don't use this
# 3: dvi conversion, don't use this
# 4: lualatex
# 5: xelatex
$pdf_mode = 1;
$root_filename = 'main.tex';
$out_dir = 'build';
$biber = "biber --output_directory=$out_dir";

@default_files = ('main.tex');

set_tex_cmds("-interaction=nonstopmode -file-line-error -shell-escape -synctex=1 %O %S");
