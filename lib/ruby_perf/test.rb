class Test
  attr_reader :test_params, :parser

  def initialize(params)
    @test_params = params
    @parser = Parser.new
  end

  def start_httperf_test
    conn = test_params.fetch(:num_conn)
    host = test_params.fetch(:host)
    port = test_params.fetch(:port)
    url  = test_params.fetch(:url)
    rate = test_params.fetch(:rate)
    time = test_params.fetch(:timeout)
    call = test_params.fetch(:num_call)

    test_command = "httperf --server #{host} "\
                   "--port #{port} --uri #{url} "\
                   "--rate #{rate} --num-conn #{conn} "\
                   "--num-call #{call} --timeout #{time}"

    test_result = `#{test_command}`
    parse_results(test_result)
  end

  def parse_results(test_output)
    parser.parse_test_result(test_output)
  end
end
