require 'open3'
require 'pathname'

module Rack
  class CGI
    def initialize(script)
      @script = Pathname.new(script)
    end

    def call(env)
      env.each { |k, v| ENV[k] = v unless k.include? 'rack' }

      res = Response.new
      Dir.chdir(@script.dirname) do
        Open3.popen3("./#{@script.basename}") do |stdin, stdout, stderr|
          begin
            stdin.write env['rack.input'].read
            stdin.close_write
          rescue Errno::EPIPE; end

          puts stderr.read

          line = stdout.readline
          while line.strip.length > 0
            header_name, header_value = line.split(': ', 2)
            if header_name == "Status"
              res.status = header_value.strip.to_i
            else
              res[header_name] = header_value.rstrip
            end
            line = stdout.readline
          end

          res.write stdout.read unless stdout.closed?
        end
      end
      res.finish
    end
  end
end

run Rack::CGI.new("index.cgi")