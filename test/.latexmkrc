$ENV{'TZ'} = 'Europe/Brussels';

$clean_ext = "amc nav snm";
$do_cd = 1;
$lualatex = 'lualatex --file-line-error --interaction=batchmode --shell-escape %O %S';
$out_dir = 'out';
$pdf_mode = 4;
$pdf_update_method = 0;
$view = 'none';

@default_files = (glob('beamer/*_notes.tex'), glob('beamer/*_handout.tex'), glob('amc/test-*.tex'), glob('syllabus/test-*.tex'));
