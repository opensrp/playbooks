{{- define "config.opensrp.properties" }}
sms.can.be.sent={{ .Values.opensrp.sms_can_be_sent }}
number.of.audit.messages={{ .Values.opensrp.number_of_audit_messages }}
#Team module settings
use.opensrp.team.module={{ .Values.opensrp.use_opensrp_team_module}}

plan.evaluation.enabled={{ .Values.opensrp.plan_evaluation_enabled }}
#x
multimedia.directory.name=/opt/multimedia
# multimedia file manager (is file system by default)
multimedia.file.manager={{ .Values.opensrp.multimedia_file_manager }}
#Allowed MIME Types
multimedia.allowed.file.types={{ .Values.opensrp.multimedia_allowed_file_types }}
#files upload
file.maxUploadSize={{ .Values.opensrp.file_max_upload_size| default 20971520}}
#CORS allowed source domain
opensrp.cors.allowed.source={{ .Values.opensrp.cors_allowed_source }}
opensrp.cors.max.age={{ .Values.opensrp.cors_max_age | default 60 }}
#search for missing clients
opensrp.sync.search.missing.client={{ .Values.opensrp.sync_search_missing_client }}
#duration in seconds to cache authetication time to live
opensrp.authencation.cache.ttl={{ .Values.opensrp.authencation_cache_ttl | default 600}}
#Global unique ID settings
opensrp.config.global_id={{ .Values.opensrp.config_global_id }}

# OpenMRS configuration
openmrs.url={{ .Values.openmrs.url }}
openmrs.username={{ .Values.openmrs.username }}
openmrs.password={{ .Values.openmrs.password }}
openmrs.idgen.url={{ .Values.openmrs.idgen_url | default "/module/idgen/exportIdentifiers.form" }} 
openmrs.idgen.initial.batchsize={{ .Values.openmrs.idgen_initial_batchsize | default 300000 }}
openmrs.idgen.batchsize={{ .Values.openmrs.idgen_batchsize | default 100 }}
openmrs.idgen.idsource={{ .Values.openmrs.idgen_idsource | default 1 }}
#supported versions 1.11x and 2x
openmrs.version={{ .Values.openmrs.version | default "2.1.3" }}
# make REST calls and push data while testing on the server specified above
openmrs.test.make-rest-call={{ .Values.openmrs.test_make_rest_call | default false }}
openmrs.scheduletracker.syncer.interval-min={{ .Values.openmrs.scheduletracker_syncer_interval_min | default 2 }}

# DHIS2
dhis2.url={{ .Values.dhis2.url }}
dhis2.username={{ .Values.dhis2.username }}
dhis2.password={{ .Values.dhis2.password }}

#database configuration that is not likely to change unless massive refactoring are in build/maven.properties
#couchdb properties
couchdb.server={{ .Values.couchdb.server }}
couchdb.port={{ .Values.couchdb.port }}
couchdb.username={{ .Values.couchdb.username }}
couchdb.password={{ .Values.couchdb.password }}
couchdb.atomfeed-db.revision-limit={{ .Values.couchdb.atomfeed_db_revision_limit | default 2 }}

#RapidPro settings
rapidpro.url={{ .Values.rapidpro.url }}
rapidpro.token={{ .Values.rapidpro.token }}

#redis settings
redis.host={{ .Values.redis.host }}
redis.port={{ .Values.redis.port }}
redis.password={{ .Values.redis.password }}
redis.pool.max.connections={{ .Values.redis.pool_max_connections }}

# Object storage configuration (should be populated for deployments using object storage multimedia storage)
object.storage.access.key.id={{ .Values.object_storage.access_key_id }}
object.storage.secret.access.key={{ .Values.object_storage.secret_access_key }}
object.storage.region={{ .Values.object_storage.region }}
object.storage.bucket.name={{ .Values.object_storage.bucket_name }}
object.storage.bucket.folder.path={{ .Values.object_storage.bucket_folder_path }}

#Schedules Configuration
schedule.event.add.serverVersion.interval={{ .Values.schedule.event_add_serverVersion_interval }}
schedule.view.add.serverVersion.interval={{ .Values.schedule.view_add_serverVersion_interval }}
schedule.task.add.serverVersion.interval={{ .Values.schedule.task_add_serverVersion_interval }}
schedule.location.add.serverVersion.interval={{ .Values.schedule.location_add_serverVersion_interval }}
schedule.openmrs.sync.interval={{ .Values.schedule.openmrs_sync_interval }}
schedule.openmrs.validate.interval={{ .Values.schedule.openmrs_validate_interval }}
schedule.dhis2.sync.interval={{ .Values.schedule.dhis2_sync_interval }}

#keycloak
keycloak.configuration.endpoint={{ .Values.keycloak.configuration_endpoint }}
keycloak.password.reset.endpoint={{ .Values.keycloak.password_reset_endpoint }}
keycloak.users.endpoint={{ .Values.keycloak.users_endpoint }}

#RabbitMQ settings
rabbitmq.host={{ .Values.rabbitmq.host }}
rabbitmq.virtualhost={{ .Values.rabbitmq.virtualhost }}
rabbitmq.port={{ .Values.rabbitmq.port }}
rabbitmq.username={{ .Values.rabbitmq.username }}
rabbitmq.password={{ .Values.rabbitmq.password }}
rabbitmq.exchange={{ .Values.rabbitmq.exchange }}
rabbitmq.queue={{ .Values.rabbitmq.queue }}
rabbitmq.routingkey={{ .Values.rabbitmq.routingkey }}
rabbitmq.reply.timeout={{ .Values.rabbitmq.reply_timeout }}
rabbitmq.concurrent.consumers={{ .Values.rabbitmq.concurrent_consumers }}
rabbitmq.max.concurrent.consumers={{ .Values.rabbitmq.max_concurrent_consumers }}
{{- end }}