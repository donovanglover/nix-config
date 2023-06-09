require "spec"
require "http/client"
require "json"

def check_latest_commit(repository, branch = "master")
  response = HTTP::Client.get "https://api.github.com/repos/#{repository}/branches/#{branch}"
  response.status_code.should eq(200)
  json = JSON.parse(response.body)

  File.read_lines("./overlays/#{repository.split("/")[1]}/default.nix").each do |line|
    if line.includes? "version ="
      nix_hash = line.split('"')[1]
      json["commit"]["sha"].should eq(nix_hash)
    end
  end
end
