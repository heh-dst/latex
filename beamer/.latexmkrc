$ENV{'LUAINPUTS'} = '.;styles;config;';
$ENV{'TEXINPUTS'} = '.;styles;config;';
$ENV{'TZ'} = 'Europe/Brussels';

$out_dir = 'build';
$out2_dir = 'out';
$pdf_mode = 4;
$lualatex = 'lualatex --file-line-error --interaction=batchmode --shell-escape %O %S';

$clean_ext = "nav snm";

$view = 'none';

# $silent = 1;

@default_files = (glob('*_notes.tex'), glob('*_handout.tex'));
