require 'mysql2'

def config
  @config ||= {
    db: {
      host: ENV['ISUCONP_DB_HOST'] || 'localhost',
      port: ENV['ISUCONP_DB_PORT'] && ENV['ISUCONP_DB_PORT'].to_i,
      username: ENV['ISUCONP_DB_USER'] || 'root',
      password: ENV['ISUCONP_DB_PASSWORD'],
      database: ENV['ISUCONP_DB_NAME'] || 'isuconp',
    },
  }
end

def db
  return Thread.current[:isuconp_db] if Thread.current[:isuconp_db]
  client = Mysql2::Client.new(
    host: config[:db][:host],
    port: config[:db][:port],
    username: config[:db][:username],
    password: config[:db][:password],
    database: config[:db][:database],
    encoding: 'utf8mb4',
    reconnect: true,
  )
  client.query_options.merge!(symbolize_keys: true, database_timezone: :local, application_timezone: :local)
  Thread.current[:isuconp_db] = client
  client
end

image_ids = db.query('SELECT `id` FROM posts LIMIT 10')

image_ids.to_a.each do |image_id|
  id = image_id[:id]
  post = db.prepare('SELECT * FROM `posts` WHERE `id` = ?').execute(id).first
  next unless post

  mine = post[:mime]
  ext = ""
  if post[:mime] == "image/jpeg"
    ext = "jpeg"
  elsif post[:mime] == "image/png"
    ext = "png"
  elsif post[:mime] == "image/gif"
    ext = "gif"
  else
    next
  end

  imgdata = post[:imgdata]
  imgfile = File.open("/home/isucon/private_isu/webapp/public/image/#{id}.#{ext}", "w+b")
  imgfile.write(imgdata)
  imgfile.close
end
