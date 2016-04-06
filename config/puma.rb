on_worker_boot do
  ActiveRecord::Base.establish_connection

  TheLoneDyno.exclusive do |signal|
    puts "Running on DYNO: #{ENV['DYNO']}"

    require 'objspace'
    require 'tempfile'

    ObjectSpace.trace_object_allocations_start
    signal.watch do |payload|
      puts "Got signal #{ payload.inspect}"
      Tempfile.open("heap.dump") do |f|

        ObjectSpace.dump_all(output: f)
        f.close

        s3 = Aws::S3::Client.new(region: 'us-east-1')
        File.open(f, 'rb') do |file|
          s3.put_object(body: file, key: "#{Time.now.iso8601}-process:#{Process.pid}-heap.dump", bucket: ENV['AWS_S3_BUCKET_NAME'])
        end
      end
    end
  end
end