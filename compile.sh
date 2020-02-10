#!/bin/sh

# Compile for SHMTUThesis

# Basename of thesis
THESIS='main'
THESISTEX=$THESIS.tex
THESISPDF=$THESIS.pdf
TEMP='.temp'

echo $THESISTEX

# Option for latexmk
LATEXMK_OPT="-xelatex -quiet -file-line-error -halt-on-error -interaction=nonstopmode"

command_exists() {
     command -v "$@" >/dev/null 2>&1
}

if command_exists latexmk;
then
    echo ""    
else
    echo "未找到latexmk命令，请确认该命令配置正确。"
    exit 1
fi

usage() {
    echo "请使用: $0 <option>
可使用的参数 <option> 包括:
    run         开始编译论文
    help        查看使用介绍"
    exit $1
}

compile(){
    mkdir -p $TEMP
    latexmk -pdf $LATEXMK_OPT -jobname=$TEMP/$THESIS $THESISTEX
    mv $TEMP/$THESISPDF .
    clean
}

clean(){
    rm -rf $TEMP
}

action=${1:-"help"}
case "$action" in
    run)
	compile
	;;
    clean)
	clean
	;;
    help)
        usage 0
        ;;
    *)
    usage 1
        ;;
esac
