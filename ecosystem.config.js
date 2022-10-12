'use strict';

module.exports = {
  apps: [
    {
      name: 'rise_main_server',
      script: './build/app.js',
      watch: true,
      // instances: 'max',
      // instances: '2',
      exec_mode: 'cluster',
      env: { NODE_ENV: 'development' },
      env_production: { NODE_ENV: 'production' },
      ignore_watch: ['node_modules', '.whatap', 'logs', 'paramkey.txt','src'],
    },
  ],
};
