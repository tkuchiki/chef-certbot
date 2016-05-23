setuptools = "python-setuptools"

case
when node[:platform] == "amazon"
  setuptools = "python#{node[:certbot][:pip][:shortver]}-setuptools"
end

package setuptools do
  action :install
end

easy_install_package "pip" do
  action :install
end

bash "pip install --upgrade pip" do
  code    "pip install --upgrade pip"
  only_if { node[:certbot][:pip][:is_update] }
end

bash "#{node[:certbot][:virtualenv][:pip_bin]} install --upgrade virtualenv" do
  code    "#{node[:certbot][:virtualenv][:pip_bin]} install --upgrade virtualenv"
  only_if { node[:certbot][:virtualenv][:is_update] }
end

localdir = File.expand_path("~#{node[:certbot][:user]}") + "/.local"

directory localdir do
  owner node[:certbot][:user]
  group node[:certbot][:group]
  mode  0700
end

remote_file node[:certbot][:bin] do
  owner  node[:certbot][:user]
  group  node[:certbot][:group]
  mode   node[:certbot][:mode]
  source node[:certbot][:download_uri]
end

bash "virtualenv letsencrypt" do
  code <<-EOC
virtualenv -p #{node[:certbot][:python_bin]} #{localdir}/share/letsencrypt
EOC

  not_if { File.exists?("#{localdir}/share/letsencrypt") }
end
