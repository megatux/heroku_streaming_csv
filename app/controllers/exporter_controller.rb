class ExporterController < ApplicationController
  include Streameable

  def index
    respond_to do |format|
      format.html # index.html
      format.js   # index.js
      format.csv do
        send_stream(attachment_opts) do |stream|
          stream.write "email_address,updated_at\n"

          50.times.each do |i|
            line = "pepe_#{i}@acme.com,#{Time.zone.now}\n"
            stream.write line
            puts line
            sleep 1  # force slow response
          end
        end
      end
    end
  end

  private

  def attachment_opts
    {
      filename: "data_#{Time.zone.now.to_i}.csv",
      disposition: 'attachment',
      type: 'text/csv'
    }
  end
end
