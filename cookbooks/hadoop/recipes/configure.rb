execute "append java home to hadoop setenv.sh" do
  command %Q{echo "export JAVA_HOME=$JAVA_HOME" >> "#{node.hadoop.user_home}/hadoop-#{node.hadoop.version}/conf/hadoop-env.sh"}
  user node.hadoop.user
end

execute "create directory through execute, coz chef is stupid with permission on recursive" do
  command "mkdir -p #{node.hadoop.data_dir}"
  user node.hadoop.user
  group node.hadoop.user_group_name
  not_if {::File.exists?("#{node.hadoop.data_dir}")}
end

template "#{node.hadoop.user_home}/hadoop-#{node.hadoop.version}/conf/core-site.xml" do
  owner node.hadoop.user
  group node.hadoop.user_group_name
  mode 0664
  variables :data_dir => node.hadoop.data_dir
end

template "#{node.hadoop.user_home}/hadoop-#{node.hadoop.version}/conf/mapred-site.xml" do
  owner node.hadoop.user
  group node.hadoop.user_group_name
  mode 0664
end

template "#{node.hadoop.user_home}/hadoop-1.2.1/conf/hdfs-site.xml" do
  owner node.hadoop.user
  group node.hadoop.user_group_name
  mode 0664
end

execute "transfer ownership to hduser" do
  command "chown -R #{node.hadoop.user}:#{node.hadoop.user_group_name} #{node.hadoop.user_home}"
end

cookbook_file "VideoCount.java" do
  path "#{node.hadoop.user_home}/VideoCount.java"
  action :create_if_missing
  owner node.hadoop.user
  group node.hadoop.user_group_name
end

cookbook_file "VideoCountMap.java" do
  path "#{node.hadoop.user_home}/VideoCountMap.java"
  action :create_if_missing
  owner node.hadoop.user
  group node.hadoop.user_group_name
end

cookbook_file "VideoCountReduce.java" do
  path "#{node.hadoop.user_home}/VideoCountReduce.java"
  action :create_if_missing
  owner node.hadoop.user
  group node.hadoop.user_group_name
end

execute "create directory through execute, coz chef is stupid with permission on recursive" do
  command "./hadoop-#{node.hadoop.version}/bin/hadoop namenode -format -nonInteractive"
  user node.hadoop.user
  cwd node.hadoop.user_home
end