default[:certbot] = {
  :user         => "root",
  :group        => "root",
  :bin          => "/usr/local/sbin/certbot-auto",
  :python_bin   => "/usr/bin/python27",
  :download_uri => "https://dl.eff.org/certbot-auto"
}

default[:certbot][:pip] = {
  :version   => "2.7",
  :is_update => true,
}

default[:certbot][:pip][:shortver] = node[:certbot][:pip][:version].to_s.delete(".")

default[:certbot][:virtualenv] = {
  :pip_bin   => "/usr/local/bin/pip",
  :is_update => true,
}
