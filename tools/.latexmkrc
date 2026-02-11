$latex     = 'platex %O -synctex=1 -interaction=nonstopmode -file-line-error %S';
$bibtex    = 'pbibtex %O %B';
$biber     = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$makeindex = 'mendex %O -o %D %S';
$dvipdf    = 'dvipdfmx %O -o %D %S';
$pdf_mode  = 3;
$clean_ext .= " %R.bbl-SAVE-ERROR";
$clean_full_ext .= " %R.bbl";
