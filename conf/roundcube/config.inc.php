<?php

$config = [];


$config['db_dsnw'] = 'sqlite:////var/db/roundcube.db?mode=0640';


$config['default_host'] = 'tls://dovecot';
$config['default_port'] = 143;
$config['imap_conn_options']['ssl'] = [
    'verify_peer' => false,
    'verify_peer_name' => false,
];


$config['smtp_server'] = 'tls://postfix';
$config['smtp_port'] = 587;
$config['smtp_user'] = '%u';
$config['smtp_pass'] = '%p';
$config['smtp_conn_options']['ssl'] = [
    'verify_peer' => false,
    'verify_peer_name' => false,
];


$config['des_key'] = 'Change_me_I_am_example!!';

$config['plugins'] = [
    'archive',
    'zipdownload',
];
