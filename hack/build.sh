script_dir=$(dirname "$0") 
(cd ../fib-go; bash _build)
(cd ../fib-node; bash _build) 
(cd ../frontend; bash _build)
(cd ../haproxy; bash _build)     
  