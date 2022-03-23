script_dir=$(dirname "$0")
cd $script_dir/..

oc apply -R -f $script_dir/../deploy    
