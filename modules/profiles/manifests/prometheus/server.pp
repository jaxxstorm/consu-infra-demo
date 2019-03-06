# prometheus server profile
class profiles::prometheus::server {

  class { 'prometheus::server':
    version        => '2.6.1',
    scrape_configs => [
      {
        'job_name'          => 'node_exporter',
        'consul_sd_configs' => [
          'server'        => 'consul.service.consul:8500',
          'tag_separator' => ',',
          'services'       => [
            'prometheus-node',
          ],
        ],
        'relabel_configs'   => [
          {
            'source_labels' => '[__meta_consul_node]',
            'separator'     => ';',
            'regex'         => '(.*)',
            'target_label'  => '__address__',
            'replacement'   => '$1:9100',
            'action'        => 'replace',
          },
          {
            'source_labels' => '[__meta_consul_node]',
            'separator'     => ';',
            'regex'         => '(.*)',
            'target_label'  => 'instance',
            'replacement'   => '$1',
            'action'        => 'replace',
          }
        ],

      },
      {
        'job_name'        => 'prometheus',
        'scrape_interval' => '10s',
        'scrape_timeout'  => '10s',
        'static_configs'  =>
        [
          { 'targets' => [ 'localhost:9090' ],
            'labels'  => { 'alias' => 'Prometheus'}
          }
        ]
      },
    ]
  }


}
