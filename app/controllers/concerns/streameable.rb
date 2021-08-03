module Streameable
  extend ActiveSupport::Concern
  include ActionController::Live

  def send_stream(filename:, disposition: 'attachment', type: nil)
    response.headers['Content-Type'] =
      (type.is_a?(Symbol) ? Mime[type].to_s : type) ||
      Mime::Type.lookup_by_extension(File.extname(filename).downcase.delete('.')) ||
      'application/octet-stream'

    response.headers['Content-Disposition'] =
      ActionDispatch::Http::ContentDisposition.format(disposition: disposition, filename: filename)

    # Needed for streaming
    response.headers['Last-Modified'] = Time.now.httpdate

    yield response.stream
  ensure
    response.stream.close
  end
end
