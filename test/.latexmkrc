$ENV{'TZ'} = 'Europe/Brussels';

$clean_ext = "amc nav snm";
$do_cd = 1;
$lualatex = 'lualatex --file-line-error --interaction=batchmode --shell-escape %O %S';
$out_dir = 'out';
$pdf_mode = 4;
$pdf_update_method = 0;
$view = 'none';

# Build all test documents in parallel
@default_files = (
    glob('beamer/*_notes.tex'),      # Beamer presentations with notes
    glob('beamer/*_handout.tex'),    # Beamer student handouts
    glob('amc/test-*.tex'),          # AMC exam documents
    glob('syllabus/test-*.tex')      # Syllabus documents
);
