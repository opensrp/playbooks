# OpenSRP

OpenSRP is short for "Open Smart Register Platform". It is an open-source, mobile-first platform, built to enable data-driven decision making at all levels of the health system.

## Introduction

This chart bootstraps an [OpenSRP](https://smartregister.org/) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

-   Kubernetes 1.9+ with Beta APIs enabled
-   PV provisioner support in the underlying infrastructure (Only when persisting data)

## Installing the Chart

To install the chart with the release name `my-release`:

```sh
helm install --name my-release stable/opensrp-server-web
```

The command deploys OpenSRP server on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```sh
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following is a list of the configurable parameters of the OpenSRP chart and their default values.

```yaml
time_zone: "GMT+0:00"

postgres:
  host: "db"
  port: 5432
  username: "opensrp"
  password: "password"
  database: "opensrp"

mybatis:
  core_tablespace: "pg_default"
  error_tablespace: "pg_default"
  schedule_tablespace: "pg_default"
  feed_tablespace: "pg_default"
  form_tablespace: "pg_default"

opensrp:
  sms_can_be_sent: false
  number_of_audit_messages: 1000
  #Team module settings
  use_opensrp_team_module: false
  plan_evaluation_enabled: false
  #Multimedia
  multimedia_directory_name:  "/opt/multimedia"
  # multimedia file manager (is file system by default)
  multimedia_file_manager: FileSystemMultimediaFileManager
  #Allowed MIME Types
  multimedia_allowed_file_types: application/octet-stream,image/jpeg,image/gif,image/png
  #files upload
  file_max_upload_size: 20971520
  #CORS allowed source domain
  cors_allowed_source: ""
  cors_max_age: 60
  #search for missing clients
  sync_search_missing_client: false
  #duration in seconds to cache authetication time to live
  authencation_cache_ttl: 600
  #Global unique ID settings
  config_global_id: OPENSRP_ID

openmrs:
  url: "http://localhost:8080/openmrs/"
  username: admin
  password: Admin123
  idgen_url: "/module/idgen/exportIdentifiers.form"
  idgen_initial_batchsize: 300000
  idgen_batchsize: 100
  idgen_idsource: 1
  #supported versions 1.11x and 2x
  version: "2.1.3"
  # make REST calls and push data while testing on the server specified above
  test_make_rest_call: false
  scheduletracker_syncer_interval_min: 2

dhis2:
  url: "http://dhis2-url/api/"
  username: path
  password: Path@123

couchdb:
  server: localhost
  port: 5984
  username: rootuser
  password: adminpass
  atomfeed_db_revision_limit: 2

  #RapidPro settings
rapidpro:
  url: "https://rapidpro.ona.io"
  token: YOUR_AUTH_TOKEN

redis:
  host: redis
  port: 6379
  password: ""
  pool_max_connections: 25

  # Object storage configuration (should be populated for deployments using object storage multimedia storage)
object_storage:
  access_key_id: dummy
  secret_access_key: dummy
  region: dummy
  bucket_name: dummy
  bucket_folder_path: dummy

schedule:
  event_add_serverVersion_interval: 180000
  view_add_serverVersion_interval: 120000
  task_add_serverVersion_interval: 120000
  location_add_serverVersion_interval: 120000
  openmrs_sync_interval: 300000
  openmrs_validate_interval: 420000
  dhis2_sync_interval: 600000

keycloak:
  configuration_endpoint: "{0}realms/{1}/.well-known/openid-configuration"
  password_reset_endpoint: "{0}realms/{1}/account/credentials/password"
  users_endpoint: "{0}/admin/realms/{1}/users"

rabbitmq:
  host: localhost
  virtualhost: /
  port: 5672
  username: ""
  password: ""
  exchange: "exchange"
  queue: "task.queue"
  routingkey: "rabbitmq.routingkey"
  reply_timeout: 60000
  concurrent_consumers: 1
  max_concurrent_consumers: 1


keycloak_json:
  realm: ""
  auth-server-url: "https://keycloak-url/auth/"
  ssl-required: "external"
  resource: ""
  credentials:
    secret: ""
  confidential-port: 0
```

You can override the an entire object such as

```yaml
postgres:
  host: "postgres.mydomain.com"
  port: 6432
  username: "opensrp"
  password: "mypassword"
  database: "opensrp"
```

or you can can set an individual parameter like `postgres.password: passwordManagedBySecrets`
