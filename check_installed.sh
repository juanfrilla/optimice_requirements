#ensure you have your virtual environment activated and empty before running this script
#example usage sh check_installed.sh

remove_new_reqs_if_exists() {
    new_reqs="new_reqs.txt"
    if [ -f $new_reqs ]; then
        rm $new_reqs
    fi
}

gen_new_reqs() {
    reqs="requirements.txt"
    python -m pip install --upgrade pip

    while read -r line; do
        var="${line%%==*}"
        if python -c "import $var" &>/dev/null; then
            echo "$var installed"
        else
            python -m pip install $line
            echo "$line" >>new_reqs.txt
        fi
    done <$reqs
}

remove_new_reqs_if_exists
gen_new_reqs
