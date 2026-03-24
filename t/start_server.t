use t::APISIX 'no_plan';

no_long_string();
no_root_location();

add_block_preprocessor(sub {
    my ($block) = @_;
    if (!$block->request) {
        $block->set_value("request", "GET /apisix/admin/routes");
    }
    if (!$block->no_error_log && !$block->error_log) {
        $block->set_value("no_error_log", 1);
    }
});

run_tests;

__DATA__

=== TEST 1: Start server
--- request
GET /apisix/admin/routes
--- response_body
{"list":[],"total":0}
--- error_log
--- no_error_log
