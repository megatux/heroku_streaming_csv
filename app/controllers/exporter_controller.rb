class ExporterController < ApplicationController
  include ActionController::Live

  def index
    opts = {
      filename: "data_#{Time.zone.now.to_i}.csv",
      disposition: 'attachment',
      type: 'text/csv'
    }

    send_stream(opts) do |stream|
      stream.write "email_address,updated_at\n"

      50.times.each do |i|
        line = "pepe_#{rand(100)}@acme.com,#{Time.zone.now}\n"
        stream.write line
        sleep 1
        puts line
      end
    end
  end

  def send_stream(filename:, disposition: "attachment", type: nil)
    response.headers["Content-Type"] =
      (type.is_a?(Symbol) ? Mime[type].to_s : type) ||
      Mime::Type.lookup_by_extension(File.extname(filename).downcase.delete(".")) ||
      "application/octet-stream"

    response.headers["Content-Disposition"] =
      ActionDispatch::Http::ContentDisposition.format(disposition: disposition, filename: filename)

    yield response.stream
  ensure
    response.stream.close
  end
end
