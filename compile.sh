#!/bib/bash

# set variables to default values
TEX_COMPILER=pdflatex;
BIB_COMPILER=bibtex;
FILENAME=root;
ITERATE=${1:-1};

function cleanup() {
    rm -f **.brf **.pdf **.gz **.aux **.log **.out **.blg **.fls **.xdv \
      **.fdb_latexmk **.xml **.bcf **.bbl **.dvi **.ilg **.nav **.snm **.toc \
      *-blx.bib **.lof **.lot
}

function bbl() {
    rm **.bbl

    $TEX_COMPILER -output-format=pdf $FILENAME.tex

    for file in *.aux; do
        $BIB_COMPILER $file
    done
}

function run() {

    # cleanup if equal to 0
    if [[ $ITERATE -eq 0 ]]; then
        cleanup
    fi

    # bbl if greater to 1
    if [[ $ITERATE -gt 1 ]]; then
        cleanup
        bbl
    fi

    if [[ $ITERATE -ge 1 ]]; then
        for i in `seq 1 $ITERATE`; do
            # echo $i
          $TEX_COMPILER -output-format=pdf $FILENAME.tex
        done;
    fi

}


# execute the run function
run;



