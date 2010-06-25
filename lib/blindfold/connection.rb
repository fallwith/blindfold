class Connection
  include Rack::Test::Methods

  def initialize(args={})
    perform_pre_flight_check
    log_in unless args.has_key?(:logged_in) && !args[:logged_in]
  end
  
  def log_in
    # Define for your app's process of logging in
  end
  
  def call(name, params={})
    method, url = resolve(name)
    process_request method, url, params
    @cookie_session_id = last_response.headers['Set-Cookie']
  end
  
  def response
    last_response
  end
  
  def xml
    Nokogiri::XML(last_response.body)
  end
  
  private

  def perform_pre_flight_check
    # Define for your app's prerequisite checks (connection to db, etc.)
  end
  
  def app
    ActionController::Dispatcher.new # For Rails
  end
  
  def process_request(method, url, params)
    env_vars = {}  # Define your app's required environment vars

    header('Cookie', @cookie_session_id) if @cookie_session_id

    case method.downcase.to_s
    when 'get'
      get url, params, env_vars
    when 'post'
      post url, params, env_vars
    when 'put'
      put url, params, env_vars
    when 'delete'
      delete url, params, env_vars
    else
      raise "Unsupported method '#{method}'!"
    end
  end
  
  def resolve(service)
    # Define for your app. Return a URL and method for the given service nickname
    ['get', service]
  end
end