role :app, %w[ubuntu]

namespace :nginx do
  task :write_server do
    on roles(:app) do
      conf_path = "/etc/nginx/railsapp.conf.d/#{ENV['NAME']}.conf"
      unless test("test -f #{conf_path}")
        server_io = StringIO.new(<<-SERVER)
server {
  listen 80;
  server_name #{ENV['NAME']}.pragmatic-rails.com;

  root /home/deploy/railsapp-branches/#{ENV['NAME']}/current/public;
  passenger_enabled on;
}
        SERVER

        upload!(server_io, conf_path)
        execute("sudo reload-nginx")
      end
    end
  end
end
before "passenger:restart", "nginx:write_server"
