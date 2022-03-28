script_dir=$(dirname "$0")
cd $script_dir/..

oc new-project graphtuitous
oc project graphtuitous
oc apply -R -f $script_dir/../deploy    
