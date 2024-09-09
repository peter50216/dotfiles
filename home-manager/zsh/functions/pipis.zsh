function pipis {
    pip install $1 && pip freeze | grep $1 >> requirements.txt
}
