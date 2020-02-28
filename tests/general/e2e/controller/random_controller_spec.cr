require "../spec_helper.cr"
require "../../src/controllers/default_controller"

describe "UserController" do
  http_client = HttpClient.new(ENV["APP_URL"] + "/random")

  it "/ + accept:text/html" do
    response = http_client.get("/", HTTP::Headers{
      "Accept" => "text/html",
    })
    response.status_code.should eq 200
    response.content_type.should eq "text/html"
    response.body.should eq "<p>hello world</p>"
  end

  it "/ + accept:text/plain" do
    response = http_client.get("/", HTTP::Headers{
      "Accept" => "text/plain",
    })
    response.status_code.should eq 200
    response.content_type.should eq "text/plain"
    response.body.should eq "hello world"
  end

  it "/ + accept:application/json" do
    response = http_client.get("/", HTTP::Headers{
      "Accept" => "application/json",
    })
    response.status_code.should eq 200
    response.content_type.should eq "application/json"
    response.body.should eq "{\"result\":\"hello world\"}"
  end

  it "/ + accept:application/xml" do
    response = http_client.get("/", HTTP::Headers{
      "Accept" => "application/xml",
    })
    response.status_code.should eq 406
  end
end
