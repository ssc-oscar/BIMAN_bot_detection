inp=$1
while  read -r line
do
    if `echo $line | cut -d@ -f1 | grep -qiP "([\W0-9_]bot$|^bot[\W0-9_]|[\W0-9_]bot[\W0-9_])" `
    then
        echo $line
    fi
done < $inp
