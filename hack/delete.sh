
script_dir=$(dirname "$0")
cd $script_dir/..

kubectl delete -R -f deploy 
