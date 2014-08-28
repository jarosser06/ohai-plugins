%w{rgmanager ccs}.each do |pkg|
package pkg do
action :install
end
end
 
service 'ricci' do
action [ :start, :enable ]
end
 
user 'ricci' do
password '$6$BvVGAYEh$BIsvGcfwPy29P9AmwEwD/JyqugwbC24EN1gJmvbU69JRxN76Gwusk5cGt51PgACVLLluDHThTdHSI8EPJbKdb1'
end
 
execute 'create_cluster' do
command 'ccs -h localhost -p rack --createcluster testcluster'
end
 
execute 'add_localhost' do
command 'ccs -h localhost -p rack --addnode $(hostname)'
end
 
execute 'add_test_resource' do
command 'ccs -h localhost -p rack --addresource script name=testresource file=/etc/init.d/netfs'
end
 
execute 'add_service' do
command 'ccs -h localhost -p rack --addservice script-svc'
end
 
execute 'add_subservice' do
command 'ccs -h localhost -p rack --addsubservice script-svc script ref=testresource'
end
 
execute 'sync_and_activate' do
command 'ccs -h localhost -p rack --sync --activate'
end
 
execute 'start' do
command 'ccs -h localhost -p rack --startall'
end
