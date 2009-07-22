require 'open3'

module Rack
	class CGI
		def call(env)
		  env.each { |k, v| ENV[k] = v unless k.include? 'rack' }
		  
      # env['PATH_TRANSLATED'] = self.translate_path(uqrest) # not set

		  # send "rack.input" to script's STDIN
		  res = Response.new
		  Open3.popen3("test.sh") do |stdin, stdout, stderr|
        # stdin.write env['rack.input']
        puts stdout.readlines
		    res.write stdout.read
	    end
		  res.finish
		end
	end
end

use Rack::ShowExceptions
run Rack::CGI.new





# if query:
#     env['QUERY_STRING'] = query
# host = self.address_string()
# if host != self.client_address[0]:
#     env['REMOTE_HOST'] = host
# env['REMOTE_ADDR'] = self.client_address[0]
# authorization = self.headers.getheader("authorization")
# if authorization:
#     authorization = authorization.split()
#     if len(authorization) == 2:
#         import base64, binascii
#         env['AUTH_TYPE'] = authorization[0]
#         if authorization[0].lower() == "basic":
#             try:
#                 authorization = base64.decodestring(authorization[1])
#             except binascii.Error:
#                 pass
#             else:
#                 authorization = authorization.split(':')
#                 if len(authorization) == 2:
#                     env['REMOTE_USER'] = authorization[0]
# # XXX REMOTE_IDENT
# if self.headers.typeheader is None:
#     env['CONTENT_TYPE'] = self.headers.type
# else:
#     env['CONTENT_TYPE'] = self.headers.typeheader
# length = self.headers.getheader('content-length')
# if length:
#     env['CONTENT_LENGTH'] = length
# accept = []
# for line in self.headers.getallmatchingheaders('accept'):
#     if line[:1] in "\t\n\r ":
#         accept.append(line.strip())
#     else:
#         accept = accept + line[7:].split(',')
# env['HTTP_ACCEPT'] = ','.join(accept)
# ua = self.headers.getheader('user-agent')
# if ua:
#     env['HTTP_USER_AGENT'] = ua
# co = filter(None, self.headers.getheaders('cookie'))
# if co:
#     env['HTTP_COOKIE'] = ', '.join(co)
# # XXX Other HTTP_* headers
# # Since we're setting the env in the parent, provide empty
# # values to override previously set values
# for k in ('QUERY_STRING', 'REMOTE_HOST', 'CONTENT_LENGTH',
#           'HTTP_USER_AGENT', 'HTTP_COOKIE'):
#     env.setdefault(k, "")
# os.environ.update(env)
# 
# self.send_response(200, "Script output follows")
# 
# decoded_query = query.replace('+', ' ')
# 
# if self.have_fork:
#     # Unix -- fork as we should
#     args = [script]
#     if '=' not in decoded_query:
#         args.append(decoded_query)
#     nobody = nobody_uid()
#     self.wfile.flush() # Always flush before forking
#     pid = os.fork()
#     if pid != 0:
#         # Parent
#         pid, sts = os.waitpid(pid, 0)
#         # throw away additional data [see bug #427345]
#         while select.select([self.rfile], [], [], 0)[0]:
#             if not self.rfile.read(1):
#                 break
#         if sts:
#             self.log_error("CGI script exit status %#x", sts)
#         return
#     # Child
#     try:
#         try:
#             os.setuid(nobody)
#         except os.error:
#             pass
#         os.dup2(self.rfile.fileno(), 0)
#         os.dup2(self.wfile.fileno(), 1)
#         os.execve(scriptfile, args, os.environ)
#     except:
#         self.server.handle_error(self.request, self.client_address)
#         os._exit(127)
# 
# elif self.have_popen2 or self.have_popen3:
#     # Windows -- use popen2 or popen3 to create a subprocess
#     import shutil
#     if self.have_popen3:
#         popenx = os.popen3
#     else:
#         popenx = os.popen2
#     cmdline = scriptfile
#     if self.is_python(scriptfile):
#         interp = sys.executable
#         if interp.lower().endswith("w.exe"):
#             # On Windows, use python.exe, not pythonw.exe
#             interp = interp[:-5] + interp[-4:]
#         cmdline = "%s -u %s" % (interp, cmdline)
#     if '=' not in query and '"' not in query:
#         cmdline = '%s "%s"' % (cmdline, query)
#     self.log_message("command: %s", cmdline)
#     try:
#         nbytes = int(length)
#     except (TypeError, ValueError):
#         nbytes = 0
#     files = popenx(cmdline, 'b')
#     fi = files[0]
#     fo = files[1]
#     if self.have_popen3:
#         fe = files[2]
#     if self.command.lower() == "post" and nbytes > 0:
#         data = self.rfile.read(nbytes)
#         fi.write(data)
#     # throw away additional data [see bug #427345]
#     while select.select([self.rfile._sock], [], [], 0)[0]:
#         if not self.rfile._sock.recv(1):
#             break
#     fi.close()
#     shutil.copyfileobj(fo, self.wfile)
#     if self.have_popen3:
#         errors = fe.read()
#         fe.close()
#         if errors:
#             self.log_error('%s', errors)
#     sts = fo.close()
#     if sts:
#         self.log_error("CGI script exit status %#x", sts)
#     else:
#         self.log_message("CGI script exited OK")
