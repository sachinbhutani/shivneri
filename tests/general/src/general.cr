require "../../../src/shivneri"
require "./controllers/default_controller"
require "./controllers/session_controller"
require "./controllers/home_controller"
require "./controllers/random_controller"
require "./controllers/user_controller"
require "./controllers/file_controller"

include Shivneri
include General
VERSION = "0.1.0"
require "./walls/wall_without_outgoing"

# TODO: Put your code here

class App < Fort
  def intialize
  end
end

def init_app(on_success = nil)
  app = App.new
  routes = [{
    controller: DefaultController,
    path:       "/*",
  }, {
    controller: SessionController,
    path:       "/session",
  }, {
    controller: HomeController,
    path:       "/home",
  }, {
    controller: RandomController,
    path:       "/random",
  }, {
    controller: UserController,
    path:       "/user",
  }, {
    controller: FileController,
    path:       "/file",
  }]
  # routes.each do |route|
  #   app.register_controller(route[:controller], route[:path])
  # end
  app.routes = routes
  app.walls = [WallWithoutOutgoing]
  app_option = AppOption.new
  path_of_static_folder = File.join(Dir.current, "static")
  app_option.folders = [{
    path_alias: "static",
    path:       path_of_static_folder,
  }, {
    path_alias: "/",
    path:       path_of_static_folder,
  }]
  ENV["APP_URL"] = "http://localhost:#{app.port}"
  app.create(app_option, on_success)
  return app
end

if (ENV["CRYSTAL_ENV"]? != "TEST")
  init_app(->{
    puts "Your fort is located at address - #{ENV["APP_URL"]}"
    puts "ENV is - #{ENV["CRYSTAL_ENV"]}"
  })
end
