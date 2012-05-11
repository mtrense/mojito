# encoding: UTF-8

module Mojito
	
	HttpStatusCode = Struct.new :code, :symbol, :message
	STATUS = {}
	
	[
		HttpStatusCode.new(100, :continue, 'Continue'),
		HttpStatusCode.new(101, :switching_protocols, 'Switching Protocols'),
		HttpStatusCode.new(102, :processing, 'Processing'),
		HttpStatusCode.new(103, :checkpoint, 'Checkpoint'),
		HttpStatusCode.new(122, :request_uri_too_long, 'Request-URI too long'),
		HttpStatusCode.new(200, :ok, 'OK'),
		HttpStatusCode.new(201, :created, 'Created'),
		HttpStatusCode.new(202, :accepted, 'Accepted'),
		HttpStatusCode.new(203, :non_authoritative_information, 'Non-Authoritative Information'),
		HttpStatusCode.new(204, :no_content, 'No Content'),
		HttpStatusCode.new(205, :reset_content, 'Reset Content'),
		HttpStatusCode.new(206, :partial_content, 'Partial Content'),
		HttpStatusCode.new(207, :multi_status, 'Multi-Status'),
		HttpStatusCode.new(208, :already_reported, 'Already Reported'),
		HttpStatusCode.new(226, :im_used, 'IM Used'),
		HttpStatusCode.new(300, :multiple_choices, 'Multiple Choices'),
		HttpStatusCode.new(301, :moved_permanently, 'Moved Permanently'),
		HttpStatusCode.new(302, :found, 'Found'),
		HttpStatusCode.new(303, :see_other, 'See Other'),
		HttpStatusCode.new(304, :not_modified, 'Not Modified'),
		HttpStatusCode.new(305, :use_proxy, 'Use Proxy'),
		HttpStatusCode.new(306, :switch_proxy, 'Switch Proxy'),
		HttpStatusCode.new(307, :temporary_redirect, 'Temporary Redirect'),
		HttpStatusCode.new(308, :resume_incomplete, 'Resume Incomplete'),
		HttpStatusCode.new(400, :bad_request, 'Bad Request'),
		HttpStatusCode.new(401, :unauthorized, 'Unauthorized'),
		HttpStatusCode.new(402, :payment_required, 'Payment Required'),
		HttpStatusCode.new(403, :forbidden, 'Forbidden'),
		HttpStatusCode.new(404, :not_found, 'Not Found'),
		HttpStatusCode.new(405, :method_not_allowed, 'Method Not Allowed'),
		HttpStatusCode.new(406, :not_acceptable, 'Not Acceptable'),
		HttpStatusCode.new(407, :proxy_authentication_required, 'Proxy Authentication Required'),
		HttpStatusCode.new(408, :request_timeout, 'Request Timeout'),
		HttpStatusCode.new(409, :conflict, 'Conflict'),
		HttpStatusCode.new(410, :gone, 'Gone'),
		HttpStatusCode.new(411, :length_required, 'Length Required'),
		HttpStatusCode.new(412, :precondition_failed, 'Precondition Failed'),
		HttpStatusCode.new(413, :request_entity_too_large, 'Request Entity Too Large'),
		HttpStatusCode.new(414, :request_uri_too_long, 'Request-URI Too Long'),
		HttpStatusCode.new(415, :unsupported_media_type, 'Unsupported Media Type'),
		HttpStatusCode.new(416, :request_range_not_satisfiable, 'Request Range Not Satisfiable'),
		HttpStatusCode.new(417, :expectation_failed, 'Expectation Failed'),
		HttpStatusCode.new(418, :im_a_teapot, 'I\'m a teapot'),
		HttpStatusCode.new(419, :enhance_your_calm, 'Enhance Your Calm'),
		HttpStatusCode.new(500, :internal_server_error, 'Internal Server Error'),
		HttpStatusCode.new(501, :not_implemented, 'Not Implemented'),
		HttpStatusCode.new(502, :bad_gateway, 'Bad Gateway'),
		HttpStatusCode.new(503, :service_unavailable, 'Service Unavailable'),
		HttpStatusCode.new(504, :gateway_timeout, 'Gateway Timeout'),
		HttpStatusCode.new(505, :http_version_not_supported, 'HTTP Version Not Supported'),
	].each do |sc|
		STATUS[sc.code] = sc
		STATUS[sc.symbol] = sc
	end
	
end