default['cas_cron']['service'] = value_for_platform_family(
    'debian' => 'cron',
    'rhel'   => 'crond'
)

default['cas_cron']['packages'] = value_for_platform_family(
    'debian' => %w(cron),
    'rhel'   => %w(cronie cronie-anacron crontabs)
)

default['cas_cron']['jobs'] = {}
