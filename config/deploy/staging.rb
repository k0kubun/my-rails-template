role :app, %w[ubuntu]

namespace :nginx do
  task :write_server do
    on roles(:app) do
      server_io = StringIO.new(<<-SERVER)
server {
  listen 80;
  server_name #{ENV['NAME']}.pragmatic-rails.com;

  root /home/deploy/railsapp-branches/#{ENV['NAME']}/current/public;
  passenger_enabled on;
}
      SERVER

      upload!(server_io, "/etc/nginx/railsapp.conf.d/#{ENV['NAME']}.conf")
    end
  end
end
before "passenger:restart", "nginx:write_server"
