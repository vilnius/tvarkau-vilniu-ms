module OmniAuth
  module Strategies
    class Viisp
      include OmniAuth::Strategy

      attr_accessor :ticket

      def request_phase
        url = VIISP::Auth.portal_endpoint
        ticket = VIISP::Auth.ticket(postback_url: callback_url)

        html = <<~HTML
          <html>
          <body>
            <form id="login" action="#{url}" method="post">
              <input type="hidden" name="ticket" value="#{ticket}">
            </form>
            <script type='text/javascript'>
              document.getElementById("login").submit();
            </script>
          </body>
          </html>
        HTML

        Rack::Response.new(html, 200, 'content-type' => 'text/html').finish
      end

      def callback_phase
        self.ticket = request.params['ticket']
        super
      end

      uid do
        raw_identity['attributes']['lt-personal-code'] ||
          raw_identity['attributes']['lt-company-code']
      end

      info do
        raw_identity['user_information']
      end

      extra do
        hash = {}
        hash['raw_identity'] = raw_identity unless skip_info?
        hash
      end

      def raw_identity
        @raw_identity ||= VIISP::Auth.identity(ticket: ticket)
      end
    end
  end
end
